import {test} from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import {build, output} from '../scripts/build.mjs';

const result=build();
const html=url=>fs.readFileSync(path.join(output,url,'index.html'),'utf8');
test('both static homepages render translated content and native FAQ controls',()=>{
  for(const [url,lang,text] of [['/','en','Life moves fast.'],['/zh/','zh','日子向前，']]){
    const page=html(url);
    assert.ok(page.includes(`<html lang="${lang}">`));
    assert.ok(page.includes(text));
    assert.equal((page.match(/<details>/g)||[]).length,5);
    assert.ok(page.includes('<script src="/js/downloads.js" defer></script>'));
    assert.ok(!/{{|{%/.test(page));
    assert.ok(page.includes('id="download-computer"'));
    assert.ok(page.includes('id="download-phone"'));
    assert.ok(!page.includes('lomosw.lomorage.com'));
    assert.ok(!/href="[^"\s]+\.(?:msi|dmg)/i.test(page));
  }
});
test('new install commands, app links and QR codes are available without the old domain',()=>{
  const source=JSON.parse(fs.readFileSync(new URL('../data/downloads.json',import.meta.url),'utf8'));
  for(const lang of ['en','zh']){
    const page=html(lang==='zh'?'/zh/':'/');
    for(const platform of source[lang].platforms){
      assert.ok(page.includes(`id="command-${platform.id}"`));
      assert.ok(platform.command.includes('https://lomorage.com/'));
      assert.ok(fs.existsSync(path.join(output,platform.script)));
    }
    for(const app of ['ios','android']){
      assert.ok(page.includes(source[lang][app+'Url']));
      const svg=fs.readFileSync(path.join(output,`img/download/${app}-${lang}.svg`),'utf8');
      assert.ok(svg.includes(`<desc>${source[lang][app+'Url']}</desc>`));
      assert.ok(svg.includes('shape-rendering="crispEdges"'));
    }
    assert.ok(page.includes('/windows/LomoImporter.zip'));
    assert.ok(page.includes('/mac/LomoImporter.zip'));
  }
});
test('migrated downloads match their recorded checksums and release updates stay on the main domain',()=>{
  const migration=JSON.parse(fs.readFileSync(new URL('../migration/download-assets.json',import.meta.url),'utf8'));
  for(const asset of migration.files){
    const bytes=fs.readFileSync(path.join(output,asset.path));
    assert.equal(crypto.createHash('sha256').update(bytes).digest('hex'),asset.sha256,asset.path);
    if(asset.path.endsWith('.zip'))assert.equal(bytes.subarray(0,2).toString(),'PK');
  }
  const release=JSON.parse(fs.readFileSync(path.join(output,'release.json'),'utf8'));
  for(const key of ['darwin','windows']){
    assert.ok(release[key].LomoUpdateURL.startsWith('https://lomorage.com/'));
    assert.ok(fs.existsSync(path.join(output,new URL(release[key].LomoUpdateURL).pathname)));
  }
  for(const key of ['windows-cli','macos-cli-arm64','macos-cli-amd64'])assert.match(release[key].SHA256,/^[0-9a-f]{64}$/i);
});
test('historical article URLs and FAQ heading anchors survive migration',()=>{
  assert.ok(html('/blog/2022/02/11/photoprism/').includes('PhotoPrism meets Lomorage'));
  assert.ok(html('/zh/blog/2023/03/02/migrate_from_pi_win/').includes('class="prose"'));
  assert.ok(html('/faq/').includes('id="how-comes-the-name-lomorage"'));
  assert.ok(html('/compare/').includes('<table>'));
  assert.ok(!html('/compare/').includes('{{<'));
  assert.ok(html('/contact/').includes('href="mailto:support@lomorage.com"'));
  assert.ok(html('/blog/page/1/').includes('content="0;url=/blog/"'));
  assert.ok(html('/zh/tags/树莓派/page/1/').includes('http-equiv="refresh"'));
});
test('all homepage assets, anchors and local navigation links resolve',()=>{
  for(const url of ['/','/zh/']){
    const page=html(url);
    for(const match of page.matchAll(/(?:href|src)="([^"]+)"/g)){
      const href=match[1];
      if(href.startsWith('#')){assert.ok(page.includes(`id="${href.slice(1)}"`),href);continue;}
      if(!href.startsWith('/'))continue;
      const route=decodeURIComponent(href.split('#')[0]);
      const file=path.join(output,route,route.endsWith('/')?'index.html':'');
      assert.ok(fs.existsSync(file),`Missing ${href}`);
    }
  }
});
test('language pairs, custom domain, discovery and error pages are generated',()=>{
  assert.ok(html('/zh/blog/2022/02/11/photoprism/').includes('href="/blog/2022/02/11/photoprism/" lang="en"'));
  assert.ok(result.pages.filter(p=>p.isBlog).length>=20);
  assert.equal(fs.readFileSync(path.join(output,'CNAME'),'utf8').trim(),'lomorage.com');
  for(const file of ['sitemap.xml','robots.txt','index.xml','zh/index.xml','404.html'])assert.ok(fs.existsSync(path.join(output,file)));
});
