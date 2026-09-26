---
title: Updates and maintenance
weight: 40
---

Windows checks for Lomorage updates in the background. You can also safely run the current install command again when you want to update immediately; it does not remove your photo library.

On macOS, run the install command again to update the photo assistant. The current macOS installer does not schedule the same daily update check as Windows.

Linux, NAS and container installations follow the package or image method described in their platform guide. Before an update, make sure important photos have another independent copy and note any custom mount paths, ports or container settings.

If an APT-based installation reports a `NO_PUBKEY` or repository signature error after a signing-key change, refresh the Lomoware repository key using the current steps in the relevant Linux installation guide, then run the package update again. Do not disable signature verification as a workaround.
