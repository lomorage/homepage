import {test} from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import vm from 'node:vm';
import {spawnSync} from 'node:child_process';

const installer = fs.readFileSync(new URL('../static/mac/install.sh', import.meta.url), 'utf8');
const parser = installer.match(/\/usr\/bin\/osascript -l JavaScript -e '\r?\n([\s\S]*?)\r?\n' "\$\{MANIFEST_JSON\}"/)[1];
const parseField = vm.runInNewContext(`${parser}\nrun`);
const manifest = fs.readFileSync(new URL('../static/release.json', import.meta.url), 'utf8');

test('Mac installer reads both architecture releases without Python', () => {
  assert.doesNotMatch(installer, /python3/);
  for (const key of ['macos-cli-arm64', 'macos-cli-amd64']) {
    for (const field of ['URL', 'SHA256', 'Version']) {
      assert.equal(parseField([manifest, key, field]), JSON.parse(manifest)[key][field]);
    }
  }
});

test('Mac installer rejects malformed or incomplete release metadata', () => {
  for (const json of ['{', 'null', '{}', '{"mac":null}']) {
    assert.throws(() => parseField([json, 'mac', 'URL']));
  }
  for (const value of [null, '', '  ', 123, true, {}, []]) {
    assert.throws(() => parseField([JSON.stringify({mac: {URL: value}}), 'mac', 'URL']));
  }
});

test('Mac installer treats special characters and downloaded content as data', () => {
  const value = 'https://example.com/a?x="quoted"&y=雪&z=$(touch unwanted)';
  assert.equal(parseField([JSON.stringify({'mac.custom': {URL: value}}), 'mac.custom', 'URL']), value);
});

test('native macOS parser outputs the requested value and fails on missing fields', {skip: process.platform !== 'darwin'}, () => {
  const result = spawnSync('/usr/bin/osascript', ['-l', 'JavaScript', '-e', parser, manifest, 'macos-cli-arm64', 'URL'], {encoding: 'utf8'});
  assert.equal(result.status, 0, result.stderr);
  assert.equal(result.stdout.trim(), JSON.parse(manifest)['macos-cli-arm64'].URL);
  const invalid = spawnSync('/usr/bin/osascript', ['-l', 'JavaScript', '-e', parser, '{}', 'missing', 'URL']);
  assert.notEqual(invalid.status, 0);
});
