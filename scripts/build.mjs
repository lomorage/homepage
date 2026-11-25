import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import MarkdownIt from 'markdown-it';
import nunjucks from 'nunjucks';
import { parse as parseToml } from 'smol-toml';
import QRCode from 'qrcode';

export const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
export const output = path.join(root, 'dist');
const siteUrl = 'https://lomorage.com';
const copy = JSON.parse(fs.readFileSync(path.join(root, 'data/home.json'), 'utf8'));
const downloads = JSON.parse(fs.readFileSync(path.join(root, 'data/downloads.json'), 'utf8'));
const docsNavigation = JSON.parse(fs.readFileSync(path.join(root, 'data/docs.json'), 'utf8'));
const connect = JSON.parse(fs.readFileSync(path.join(root, 'data/connect.json'), 'utf8'));
const env = nunjucks.configure(path.join(root, 'src'), { autoescape: true, throwOnUndefined: true });
const escape = value => String(value).replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const slug = value => String(value).toLowerCase().replace(/[^\p{L}\p{N}\s_.-]/gu, '').trim().replace(/\s+/g, '-');
const md = new MarkdownIt({html:true, linkify:true});
md.core.ruler.push('heading_ids', state => {
  const seen = new Map();
  state.tokens.forEach((token, i) => {
    if (token.type !== 'heading_open') return;
    const base = slug(state.tokens[i + 1].content.replace(/[*`]/g, ''));
    const count = seen.get(base) || 0;
    seen.set(base, count + 1);
    token.attrSet('id', base + (count ? `-${count}` : ''));
  });
});
const jsonLd = value => JSON.stringify(value).replace(/</g, '\\u003c');
// Meta descriptions: plain text, cut at a word/sentence boundary near 160 characters.
function clip(text, max = 160) {
  const clean = String(text).replace(/\s+/g, ' ').trim();
  // CJK characters take roughly twice the width in search results.
  if ((clean.match(/[　-鿿＀-￯]/g) || []).length > clean.length / 3) max = Math.round(max * 0.55);
  if (clean.length <= max) return clean;
  const cut = clean.slice(0, max);
  const boundary = Math.max(cut.lastIndexOf('. '), cut.lastIndexOf('。'), cut.lastIndexOf('，'), cut.lastIndexOf(', '), cut.lastIndexOf(' '));
  return (boundary > max * 0.6 ? cut.slice(0, boundary) : cut).replace(/[\s,，.。]+$/, '') + '…';
}
const absolute = src => !src ? '' : /^https?:/.test(src) ? src : `${siteUrl}/${String(src).replace(/^\/+/, '')}`;
const plain = text => text.replace(/<[^>]*>/g, '').replace(/!\[[^\]]*\]\([^)]*\)/g, '').replace(/\[([^\]]*)\]\([^)]*\)/g, '$1').replace(/^=+$/gm, '').replace(/[#*`\[\]_]/g, '').replace(/\s+/g, ' ').trim();
function files(dir) {
  return fs.readdirSync(dir, {withFileTypes:true}).flatMap(entry => entry.isDirectory() ? files(path.join(dir, entry.name)) : [path.join(dir, entry.name)]);
}
function readPage(file) {
  const raw = fs.readFileSync(file, 'utf8').trimStart();
  const front = raw.match(/^\+\+\+\r?\n([\s\S]*?)\r?\n\+\+\+\r?\n/);
  if (!front) throw new Error(`Missing TOML front matter: ${file}`);
  const data = parseToml(front[1]);
  const lang = file.endsWith('.zh.md') ? 'zh' : 'en';
  const name = path.basename(file).replace(/(?:\.zh)?\.md$/, '');
  const isBlog = path.basename(path.dirname(file)) === 'blog';
  const date = data.date instanceof Date ? data.date.toISOString().slice(0,10) : String(data.date || '').slice(0,10);
  const prefix = lang === 'zh' ? '/zh' : '';
  if (isBlog && !/^\d{4}-\d{2}-\d{2}$/.test(date)) throw new Error(`Invalid article date: ${file}`);
  const url = `${prefix}/${isBlog ? `blog/${date.replaceAll('-', '/')}/` : ''}${name}/`;
  // Convert the former table shortcode to ordinary Markdown tables.
  const body = raw.slice(front[0].length).replace(/{{<\s*\/?table\b[^}]*>}}/g, '').replace(/mailto:\s+/g, 'mailto:');
  if (/{{[<%]/.test(body)) throw new Error(`Unconverted shortcode in ${file}`);
  const intro = plain(body.split('<!--more-->')[0]);
  const updated = data.lastmod instanceof Date ? data.lastmod.toISOString().slice(0,10) : String(data.lastmod || date).slice(0,10);
  return {...data, date, updated, lang, name, isBlog, url, html:md.render(body), summary:clip(intro, 180), description:clip(data.description || intro), image:absolute(data.banner)};
}
function readDocPage(file, lang) {
  const raw = fs.readFileSync(file, 'utf8').trimStart();
  const front = raw.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n/);
  if (!front) throw new Error(`Missing YAML front matter: ${file}`);
  const title = front[1].match(/^title:\s*["']?(.+?)["']?\s*$/m)?.[1] || path.basename(file, '.md');
  const weight = Number(front[1].match(/^weight:\s*(\d+)/m)?.[1] || 100);
  const langRoot = path.join(root, 'docs-content', lang);
  const relative = path.relative(langRoot, file).replaceAll('\\', '/');
  const clean = relative.endsWith('/_index.md') ? relative.slice(0, -9) : relative.replace(/\.md$/, '/');
  const prefix = lang === 'zh' ? '/zh' : '';
  const url = `${prefix}/${clean}`.replace(/\/+/g, '/');
  let body = raw.slice(front[0].length)
    .replace(/^#\s+[^\r\n]+\r?\n+/, '')
    .replace(/https:\/\/docs\.lomorage\.com(?=\/)/g, '')
    .replace(/mailto:\s+/g, 'mailto:');
  const notes = [];
  body = body.replace(/{{<\s*hint\s+(warning|info)\s*>}}([\s\S]*?){{<\s*\/hint\s*>}}/g, (_, kind, content) => {
    const token = `LOMORAGE_DOC_NOTE_${notes.length}`;
    notes.push(`<aside class="doc-note${kind === 'warning' ? ' doc-warning' : ''}">${md.render(content.trim())}</aside>`);
    return token;
  });
  if (/{{[<%]/.test(body)) throw new Error(`Unconverted docs shortcode in ${file}`);
  let html = md.render(body);
  notes.forEach((note, index) => { html = html.replace(`<p>LOMORAGE_DOC_NOTE_${index}</p>`, note); });
  const summary = body.replace(/<[^>]*>/g, '').replace(/!\[[^\]]*\]\([^)]*\)/g, '').replace(/[#*`\[\]]/g, '').trim().slice(0, 180);
  return {lang, title, weight, relative, url, html, summary};
}
function write(url, content) {
  const relative = url.endsWith('/') ? `${url}index.html` : url;
  const target = path.resolve(output, '.' + relative);
  if (!target.startsWith(output + path.sep)) throw new Error(`Output escapes dist: ${url}`);
  fs.mkdirSync(path.dirname(target), {recursive:true});
  fs.writeFileSync(target, content);
}
function context(lang, url, title, description, translations=[], extra={}) {
  const homeUrl = lang === 'zh' ? '/zh/' : '/';
  const other = translations.find(item => item.lang !== lang);
  const xDefault = translations.length > 1 ? translations.find(item => item.lang === 'en')?.url || '' : '';
  return {lang, d:downloads[lang], t:{...copy[lang], languageUrl:other ? other.url.replace(siteUrl,'') : copy[lang].languageUrl}, pageTitle:title, pageDescription:clip(description), canonical:siteUrl+url, homeUrl, siteUrl, year:new Date().getFullYear(), translations, xDefault,
    ogType:'website', ogImage:`${siteUrl}/img/home/coast.jpg`, published:'', modified:'', structuredData:'', feedUrl:`${siteUrl}${lang === 'zh' ? '/zh' : ''}/blog/index.xml`, article:null, ...extra};
}
const organization = {'@type':'Organization','@id':`${siteUrl}/#organization`,name:'Lomorage',url:siteUrl+'/',logo:`${siteUrl}/img/brand/memory-embrace-256.png`,sameAs:['https://github.com/lomorage']};
function homeStructuredData(lang) {
  const zh = lang === 'zh';
  return jsonLd({'@context':'https://schema.org','@graph':[
    organization,
    {'@type':'WebSite','@id':`${siteUrl}/#website`,url:siteUrl+'/',name:'Lomorage',inLanguage:zh ? 'zh-CN' : 'en',publisher:{'@id':`${siteUrl}/#organization`}},
    {'@type':'SoftwareApplication',name:'Lomorage',applicationCategory:'MultimediaApplication',operatingSystem:'Windows, macOS, Linux, iOS, Android',description:copy[lang].description,url:siteUrl+(zh ? '/zh/' : '/'),image:`${siteUrl}/img/home/coast.jpg`,publisher:{'@id':`${siteUrl}/#organization`},
      offers:[{'@type':'Offer',name:zh ? '桌面端' : 'Desktop app',price:'0',priceCurrency:'USD'},{'@type':'Offer',name:zh ? '手机 App（一次性购买）' : 'Phone app (one-time purchase)',price:'1.99',priceCurrency:'USD'}]}
  ]});
}
function qrSvg(url) {
  const {modules}=QRCode.create(url,{errorCorrectionLevel:'M'});
  const size=modules.size;
  let squares='';
  for(let row=0;row<size;row++)for(let col=0;col<size;col++){
    if(modules.get(row,col))squares+=`M${col+4},${row+4}h1v1h-1z`;
  }
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${size+8} ${size+8}" shape-rendering="crispEdges"><desc>${escape(url)}</desc><path fill="#fff" d="M0 0h${size+8}v${size+8}H0z"/><path fill="#283b30" d="${squares}"/></svg>`;
}
export function build() {
  // The output is a fixed child of this repository, never a caller-provided path.
  if (path.dirname(output) !== root || path.basename(output) !== 'dist') throw new Error('Unsafe output directory');
  fs.rmSync(output, {recursive:true, force:true});
  fs.mkdirSync(output, {recursive:true});
  fs.cpSync(path.join(root, 'static'), output, {recursive:true});
  const pages = files(path.join(root,'content')).filter(file => file.endsWith('.md') && !path.basename(file).startsWith('_index')).map(readPage).filter(page => !page.draft);
  const docs = ['en','zh'].flatMap(lang => files(path.join(root,'docs-content',lang,'docs')).filter(file => file.endsWith('.md')).map(file => readDocPage(file,lang)));
  const urls = new Set();
  const sitemapInfo = new Map();
  function renderPage(url, lang, title, html, translations=[], description='', extra={}) {
    urls.add(url);
    sitemapInfo.set(url, {translations, lastmod:extra.modified || ''});
    write(url, env.render('page.njk', {...context(lang,url,title,description || copy[lang].description,translations,extra), content:html}));
  }
  function renderDoc(page) {
    const translations = docs.filter(other => other.relative === page.relative).map(other => ({lang:other.lang,url:siteUrl+other.url}));
    const headings = [...page.html.matchAll(/<h([23]) id="([^"]+)">([\s\S]*?)<\/h\1>/g)].map(match => ({level:Number(match[1]),id:match[2],text:match[3].replace(/<[^>]+>/g,'')}));
    urls.add(page.url);
    sitemapInfo.set(page.url, {translations, lastmod:''});
    write(page.url, env.render('docs.njk', {...context(page.lang,page.url,page.title,page.summary || copy[page.lang].description,translations), content:page.html, docsNav:docsNavigation[page.lang], headings, isDocs:true}));
  }
  const homeTranslations = [{lang:'en',url:siteUrl+'/'},{lang:'zh',url:siteUrl+'/zh/'}];
  for (const lang of ['en','zh']) {
    const prefix = lang === 'zh' ? '/zh' : '';
    const url = prefix + '/';
    write(`/img/download/ios-${lang}.svg`,qrSvg(downloads[lang].iosUrl));
    write(`/img/download/android-${lang}.svg`,qrSvg(downloads[lang].androidUrl));
    sitemapInfo.set(url, {translations:homeTranslations, lastmod:''});
    write(url, env.render('home.njk',context(lang,url,copy[lang].title,copy[lang].description,homeTranslations,{structuredData:homeStructuredData(lang)})));
    urls.add(url);
    const posts = pages.filter(p=>p.lang===lang && p.isBlog).sort((a,b)=>b.date.localeCompare(a.date));
    const cards = list => `<div class="article-list">${list.map(p=>`<article><time datetime="${escape(p.date)}">${escape(p.date)}</time><h2><a href="${escape(p.url)}">${escape(p.title)}</a></h2><p>${escape(p.summary)}</p><a class="text-link" href="${escape(p.url)}">${lang==='zh'?'阅读全文':'Read the story'} →</a></article>`).join('')}</div>`;
    renderPage(prefix+'/blog/',lang,lang==='zh'?'博客':'Journal',cards(posts),[{lang:'en',url:siteUrl+'/blog/'},{lang:'zh',url:siteUrl+'/zh/blog/'}],
      lang==='zh'?'Lomorage 博客：不用 iCloud 备份 iPhone 照片、自建 Google 相册替代方案、家庭照片 3-2-1 备份、手机空间清理和 NAS/树莓派私有相册教程。':'Lomorage journal: back up iPhone and Android photos without iCloud, self-hosted Google Photos alternatives, the 3-2-1 rule for family photos, and NAS or Raspberry Pi guides.');
    for (const taxonomy of ['tags','categories']) {
      const terms = [...new Set(posts.flatMap(p=>p[taxonomy] || []))].sort();
      renderPage(`${prefix}/${taxonomy}/`,lang,taxonomy==='tags'?(lang==='zh'?'标签':'Tags'):(lang==='zh'?'分类':'Categories'),`<ul>${terms.map(term=>`<li><a href="${prefix}/${taxonomy}/${encodeURI(slug(term))}/">${escape(term)}</a></li>`).join('')}</ul>`);
      for (const term of terms) renderPage(`${prefix}/${taxonomy}/${slug(term)}/`,lang,term,cards(posts.filter(p=>(p[taxonomy]||[]).includes(term))),[],lang==='zh'?`Lomorage 博客中关于「${term}」的文章与教程。`:`Lomorage articles and guides about ${term}.`);
    }
    const feed = `<?xml version="1.0" encoding="UTF-8"?><rss version="2.0"><channel><title>Lomorage</title><link>${siteUrl}${prefix}/blog/</link><description>${escape(copy[lang].footerTagline)}</description>${posts.map(p=>`<item><title>${escape(p.title)}</title><link>${siteUrl}${p.url}</link><guid>${siteUrl}${p.url}</guid><pubDate>${new Date(p.date+'T00:00:00Z').toUTCString()}</pubDate><description>${escape(p.description)}</description></item>`).join('')}</channel></rss>`;
    write(prefix+'/index.xml',feed);write(prefix+'/blog/index.xml',feed);
  }
  for (const p of pages) {
    const translations = pages.filter(other=>other.name===p.name && other.isBlog===p.isBlog).map(other=>({lang:other.lang,url:siteUrl+other.url}));
    if (!p.isBlog) { renderPage(p.url,p.lang,p.title,p.html,translations,p.description); continue; }
    const prefix = p.lang === 'zh' ? '/zh' : '';
    // Related posts: explicit `related` names first, then shared tags/categories, then recency.
    const score = o => (p.related||[]).includes(o.name) * 10 + (o.related||[]).includes(p.name) * 5
      + (o.tags||[]).filter(t=>(p.tags||[]).includes(t)).length + (o.categories||[]).filter(t=>(p.categories||[]).includes(t)).length;
    const related = pages.filter(o=>o.isBlog && o.lang===p.lang && o.url!==p.url)
      .map(o=>({o,s:score(o)})).sort((a,b)=>b.s-a.s || b.o.date.localeCompare(a.o.date)).slice(0,3)
      .map(({o})=>({title:o.title,url:o.url,date:o.date}));
    const tags = (p.tags||[]).map(term=>({name:term,url:`${prefix}/tags/${encodeURI(slug(term))}/`}));
    const image = p.image || `${siteUrl}/img/home/coast.jpg`;
    const structuredData = jsonLd({'@context':'https://schema.org','@graph':[
      {'@type':'BlogPosting',headline:p.title,description:p.description,image,datePublished:p.date,dateModified:p.updated,inLanguage:p.lang === 'zh' ? 'zh-CN' : 'en',mainEntityOfPage:siteUrl+p.url,url:siteUrl+p.url,keywords:(p.tags||[]).join(', '),author:{'@type':'Organization',name:'Lomorage Team',url:siteUrl+'/'},publisher:organization},
      {'@type':'BreadcrumbList',itemListElement:[
        {'@type':'ListItem',position:1,name:'Lomorage',item:`${siteUrl}${prefix}/`},
        {'@type':'ListItem',position:2,name:p.lang === 'zh' ? '博客' : 'Journal',item:`${siteUrl}${prefix}/blog/`},
        {'@type':'ListItem',position:3,name:p.title,item:siteUrl+p.url}]},
      ...(p.faq ? [{'@type':'FAQPage',mainEntity:p.faq.map(item=>({'@type':'Question',name:item.q,acceptedAnswer:{'@type':'Answer',text:item.a}}))}] : [])
    ]});
    renderPage(p.url,p.lang,p.title,p.html,translations,p.description,{ogType:'article',ogImage:image,published:p.date,modified:p.updated,structuredData,
      article:{date:p.date,updated:p.updated !== p.date ? p.updated : '',tags,related,blogUrl:`${prefix}/blog/`}});
  }
  for (const page of docs) renderDoc(page);
  const redirect = url => `<!DOCTYPE html><html lang="en"><meta charset="utf-8"><meta http-equiv="refresh" content="0;url=${url}"><link rel="canonical" href="${siteUrl}${url}"><title>Lomorage</title><a href="${url}">Continue to Lomorage</a></html>`;
  for (const url of urls) {
    if (/^\/(zh\/)?(blog\/|(?:tags|categories)\/[^/]+\/)$/.test(url)) write(url+'page/1/',redirect(encodeURI(url)));
  }
  write('/en/',redirect('/'));
  write('/download/',redirect('/#download'));
  write('/zh/download/',redirect('/zh/#download'));
  // Target of the setup QR code a fresh Lomorage server shows (lomo-backend
  // handler/setup.go). Phones with LomoMobile open it in the app through
  // /.well-known/; others land here to install the app. Not in the sitemap.
  write('/s/',env.render('connect.njk',{c:connect,downloads}));
  write('/.nojekyll','');
  write('/404.html',env.render('page.njk',{...context('en','/404.html','Page not found','This page could not be found.'),content:'<p>The page may have moved. <a href="/">Return home</a> or <a href="/blog/">browse the journal</a>.</p>'}));
  write('/robots.txt',`User-agent: *\nAllow: /\nSitemap: ${siteUrl}/sitemap.xml\n`);
  const sitemapEntry = url => {
    const {translations=[], lastmod=''} = sitemapInfo.get(url) || {};
    const en = translations.find(t=>t.lang==='en');
    const alternates = translations.length > 1
      ? translations.map(t=>`<xhtml:link rel="alternate" hreflang="${t.lang}" href="${escape(encodeURI(t.url))}"/>`).join('') + (en ? `<xhtml:link rel="alternate" hreflang="x-default" href="${escape(encodeURI(en.url))}"/>` : '')
      : '';
    return `<url><loc>${siteUrl}${escape(encodeURI(url))}</loc>${lastmod ? `<lastmod>${lastmod}</lastmod>` : ''}${alternates}</url>`;
  };
  write('/sitemap.xml',`<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">${[...urls].map(sitemapEntry).join('')}</urlset>`);
  console.log(`Built ${urls.size} pages, ${pages.filter(p=>p.isBlog).length} articles, ${docs.length} docs and both languages. No Hugo required.`);
  return {urls:[...urls],pages,docs};
}
if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) build();
