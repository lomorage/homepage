# Lomorage static website

The website no longer uses Hugo. Node.js 22+ is only used to build ordinary HTML and CSS. GitHub Pages serves the generated files; no Node server or browser framework is required in production.

Legacy `themes/`, `layouts/`, `archetypes/`, `resources/`, `config.toml`, and `content/_index*.md` are not used by this build. They remain in the checkout only as historical files; homepage content now comes from `data/home.json`.

```sh
npm ci
npm run dev
```

Open http://localhost:4173/ or http://localhost:4173/zh/. After editing source files, run `npm run build` in another terminal and refresh the browser.

```sh
npm test
npm run build
```

The deployable website is in `dist/`. The existing GitHub Actions workflow publishes this directory to `lomorage/lomorage.github.io` on pushes to `master`, using the existing `ACTIONS_DEPLOY_KEY` secret. Pull requests build and test without publishing. `static/CNAME` preserves the custom domain.

- `src/home.njk`: homepage HTML, with small Nunjucks loops for translated copy.
- `src/head.njk`, `src/header.njk`, `src/footer.njk`: shared HTML.
- `data/home.json`: English and Chinese homepage copy.
- `static/css/home.css`: homepage and article styles, including mobile layouts.
- `content/`: existing Markdown articles and information pages. TOML metadata is preserved.
- `scripts/build.mjs`: static generation, existing dated article URLs, tags, categories, RSS, sitemap and language links.

The homepage uses a small local script only for the installation-command copy buttons. Platform selection, downloads, QR codes, and FAQ disclosure work without JavaScript. It has no external fonts, trackers or third-party image requests. The legacy privacy page and historical article content are preserved.

## Integrated downloads

Installation is now part of `/#download` and `/zh/#download`; `/download/` and `/zh/download/` redirect there. The old MSI/DMG installers are not offered. `data/downloads.json` contains both languages, current commands, and mobile app destinations. `src/downloads.njk` and `static/css/downloads.css` share the homepage design. QR codes are generated during the build from the exact mobile button URLs, so no third-party QR service is needed.

Windows and Mac installation scripts, photo importers, and legacy updater ZIPs were copied from the supplied download repository. `migration/download-assets.json` records the source tree, Git blob IDs, and SHA-256 values; tests verify the migrated files. Installer behavior is unchanged; comments and documented command URLs now use the main domain. No installer was executed during website validation. `static/release.json` now points its updater ZIPs at the same files on the main domain. Release binaries continue to be distributed by GitHub Releases.

Before retiring the old download host, publish this main site and verify its `/windows/install.ps1`, `/mac/install.sh`, importer and updater endpoints. Then switch the old download site's human-facing pages to redirects to the corresponding main-homepage sections. Keep compatibility for old installer commands and installed clients that may still reference the old hostname; an HTML redirect cannot replace an installer script or ZIP response. No DNS settings, GitHub Pages settings, or live sites have been changed by this local migration.

## Photography

Illustrative photos downloaded from Unsplash and served locally:

- `coast.jpg`: https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1
- `family.jpg`: https://images.unsplash.com/photo-1511895426328-dc8714191300
- `mountains.jpg`: https://images.unsplash.com/photo-1464822759023-fed622ff2c3b

These are editorial illustrations, not screenshots or customer testimonials. The connection diagram and memory badge illustrate the product concept, not live backup status.
