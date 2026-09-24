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
  return {...data, date, lang, name, isBlog, url, html:md.render(body), summary:body.split('<!--more-->')[0].replace(/<[^>]*>/g,'').replace(/!\[[^\]]*\]\([^)]*\)/g,'').replace(/[#*`\[\]]/g,'').trim().slice(0,180)};
}
function write(url, content) {
  const relative = url.endsWith('/') ? `${url}index.html` : url;
  const target = path.resolve(output, '.' + relative);
  if (!target.startsWith(output + path.sep)) throw new Error(`Output escapes dist: ${url}`);
  fs.mkdirSync(path.dirname(target), {recursive:true});
  fs.writeFileSync(target, content);
}
function context(lang, url, title, description, translations=[]) {
  const homeUrl = lang === 'zh' ? '/zh/' : '/';
  const other = translations.find(item => item.lang !== lang);
  return {lang, d:downloads[lang], t:{...copy[lang], languageUrl:other ? other.url.replace(siteUrl,'') : copy[lang].languageUrl}, pageTitle:title, pageDescription:description, canonical:siteUrl+url, homeUrl, siteUrl, year:new Date().getFullYear(), translations};
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
  const urls = new Set();
  function renderPage(url, lang, title, html, translations=[], description='') {
    urls.add(url);
    write(url, env.render('page.njk', {...context(lang,url,title,description || copy[lang].description,translations), content:html}));
  }
  const homeTranslations = [{lang:'en',url:siteUrl+'/'},{lang:'zh',url:siteUrl+'/zh/'}];
  for (const lang of ['en','zh']) {
    const prefix = lang === 'zh' ? '/zh' : '';
    const url = prefix + '/';
    write(`/img/download/ios-${lang}.svg`,qrSvg(downloads[lang].iosUrl));
    write(`/img/download/android-${lang}.svg`,qrSvg(downloads[lang].androidUrl));
    write(url, env.render('home.njk',context(lang,url,copy[lang].title,copy[lang].description,homeTranslations)));
    urls.add(url);
    const posts = pages.filter(p=>p.lang===lang && p.isBlog).sort((a,b)=>b.date.localeCompare(a.date));
    const cards = list => `<div class="article-list">${list.map(p=>`<article><time datetime="${escape(p.date)}">${escape(p.date)}</time><h2><a href="${escape(p.url)}">${escape(p.title)}</a></h2><p>${escape(p.summary)}</p><a class="text-link" href="${escape(p.url)}">${lang==='zh'?'阅读全文':'Read the story'} →</a></article>`).join('')}</div>`;
    renderPage(prefix+'/blog/',lang,lang==='zh'?'博客':'Journal',cards(posts),[{lang:'en',url:siteUrl+'/blog/'},{lang:'zh',url:siteUrl+'/zh/blog/'}]);
    for (const taxonomy of ['tags','categories']) {
      const terms = [...new Set(posts.flatMap(p=>p[taxonomy] || []))].sort();
      renderPage(`${prefix}/${taxonomy}/`,lang,taxonomy==='tags'?(lang==='zh'?'标签':'Tags'):(lang==='zh'?'分类':'Categories'),`<ul>${terms.map(term=>`<li><a href="${prefix}/${taxonomy}/${encodeURI(slug(term))}/">${escape(term)}</a></li>`).join('')}</ul>`);
      for (const term of terms) renderPage(`${prefix}/${taxonomy}/${slug(term)}/`,lang,term,cards(posts.filter(p=>(p[taxonomy]||[]).includes(term))));
    }
    const feed = `<?xml version="1.0" encoding="UTF-8"?><rss version="2.0"><channel><title>Lomorage</title><link>${siteUrl}${prefix}/blog/</link><description>${escape(copy[lang].footerTagline)}</description>${posts.map(p=>`<item><title>${escape(p.title)}</title><link>${siteUrl}${p.url}</link><guid>${siteUrl}${p.url}</guid><pubDate>${new Date(p.date+'T00:00:00Z').toUTCString()}</pubDate><description>${escape(p.summary)}</description></item>`).join('')}</channel></rss>`;
    write(prefix+'/index.xml',feed);write(prefix+'/blog/index.xml',feed);
  }
  for (const p of pages) {
    const translations = pages.filter(other=>other.name===p.name && other.isBlog===p.isBlog).map(other=>({lang:other.lang,url:siteUrl+other.url}));
    renderPage(p.url,p.lang,p.title,p.html,translations,p.description || p.summary);
  }
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
  write('/sitemap.xml',`<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">${[...urls].map(url=>`<url><loc>${siteUrl}${escape(encodeURI(url))}</loc></url>`).join('')}</urlset>`);
  console.log(`Built ${urls.size} pages, ${pages.filter(p=>p.isBlog).length} articles and both languages. No Hugo required.`);
  return {urls:[...urls],pages};
}
if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) build();
