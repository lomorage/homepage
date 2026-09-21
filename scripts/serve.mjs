import http from 'node:http';
import fs from 'node:fs';
import path from 'node:path';
import {build, output} from './build.mjs';
build();
const mime = {'.html':'text/html; charset=utf-8','.css':'text/css; charset=utf-8','.js':'text/javascript; charset=utf-8','.jpg':'image/jpeg','.jpeg':'image/jpeg','.png':'image/png','.svg':'image/svg+xml','.ico':'image/x-icon','.xml':'application/xml','.txt':'text/plain','.json':'application/json','.pdf':'application/pdf','.mp4':'video/mp4'};
const portIndex = process.argv.indexOf('--port');
const port = Number(portIndex >= 0 ? process.argv[portIndex+1] : process.env.PORT || 4173);
http.createServer((req,res)=>{
  let pathname;
  try {pathname=decodeURIComponent(new URL(req.url,'http://localhost').pathname);} catch {res.writeHead(400);res.end();return;}
  let file=path.resolve(output,'.'+pathname);
  if (file!==output && !file.startsWith(output+path.sep)){res.writeHead(403);res.end();return;}
  if(fs.existsSync(file)&&fs.statSync(file).isDirectory()){
    if(!pathname.endsWith('/')){res.writeHead(301,{Location:pathname+'/'});res.end();return;}
    file=path.join(file,'index.html');
  }
  const exists=fs.existsSync(file)&&fs.statSync(file).isFile();
  if(!exists) file=path.join(output,'404.html');
  res.writeHead(exists?200:404,{'Content-Type':mime[path.extname(file)]||'application/octet-stream','Cache-Control':'no-cache'});
  if(req.method==='HEAD'){res.end();return;}
  fs.createReadStream(file).pipe(res);
}).listen(port,'127.0.0.1',()=>console.log(`Lomorage preview: http://localhost:${port}/zh/`));
