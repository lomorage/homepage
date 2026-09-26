import fs from 'node:fs';
import path from 'node:path';

const root=path.resolve(path.dirname(new URL(import.meta.url).pathname.replace(/^\/(.:)/,'$1')),'..');
const walk=dir=>fs.readdirSync(dir,{withFileTypes:true}).flatMap(entry=>entry.isDirectory()?walk(path.join(dir,entry.name)):[path.join(dir,entry.name)]);
const source=walk(path.join(root,'docs-content')).filter(file=>file.endsWith('.md')).map(file=>fs.readFileSync(file,'utf8')).join('\n');
const referenced=new Set([...source.matchAll(/\/img\/installation\/[^)"'\s>]+/g)].map(match=>decodeURI(match[0].slice('/img/installation/'.length)).replaceAll('/',path.sep)));
const assets=walk(path.join(root,'static/img/installation')).map(file=>path.relative(path.join(root,'static/img/installation'),file));
const missing=[...referenced].filter(file=>!assets.includes(file));
const unused=assets.filter(file=>!referenced.has(file));
if(missing.length){console.error(`Missing documentation assets:\n${missing.join('\n')}`);process.exitCode=1;}
if(process.argv.includes('--prune')){
  const assetRoot=path.resolve(root,'static/img/installation')+path.sep;
  for(const relative of unused){
    const target=path.resolve(assetRoot,relative);
    if(!target.startsWith(assetRoot))throw new Error(`Unsafe asset path: ${relative}`);
    fs.rmSync(target);
  }
}
console.log(JSON.stringify({referenced:referenced.size,available:assets.length,missing,unused},null,2));
