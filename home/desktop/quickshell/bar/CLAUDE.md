# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A [Quickshell](https://quickshell.outfoxxed.net/) status bar config, written in QML, for a Hyprland/Wayland desktop. `shell.qml` is the entry point: it instantiates backend services once at the root, then for each screen (`Variants { model: Quickshell.screens }`) builds a `PanelWindow` containing left/mid/right `RowLayout`s of module widgets.

## Running / developing

There is no build step — QML is interpreted at runtime by Quickshell.

```sh
nix develop            # enters devShell with quickshell + qt6.qtdeclarative on PATH, sets QML_IMPORT_PATH
quickshell -p .         # run the shell from this directory (-p sets the working/config path)
```

To iterate on a single module/window in isolation, it's usually faster to temporarily instantiate just that component in a scratch `.qml` file and run it with `quickshell -p <scratch dir>` rather than reloading the whole bar.

There are no linters or automated tests in this repo. Validate changes by running quickshell and visually/functionally checking the affected widget; also check the terminal output quickshell prints (QML warnings/errors show up there, not as exceptions).

## Architecture

Four layers, imported into each other via relative `import "../x"` and declared per-directory in `qmldir` files (every new `.qml` file must be added to its directory's `qmldir` or it won't be importable):

- **`services/`** — headless `Item`s that own state and talk to the OS (via `Quickshell.Io.Process`, `Quickshell.Services.*`). Each service is instantiated **once** in `shell.qml` and passed into windows/modules as a `required property` (e.g. `BatteryService`, `EmailService`). Services poll external tools on a `Timer` and parse `stdout` (e.g. `BatteryService` shells out to `tlp-stat`/`upower`, `EmailService` shells out to `notmuch count`). Not every module needs a service — some (`SoundModule`, `HyprlandWSModule`) read directly from a Quickshell singleton (`Pipewire.defaultAudioSink`, `Hyprland.*`) since that state is already global/live.
- **`modules/`** — the small widgets that sit in the bar itself (one per tray item: clock, battery, network, bluetooth, sound, player, systray, workspaces, email...). Pure presentation + light derived state (e.g. `BatteryModule` maps `battery.percentage`/`state` to a Nerd Font glyph). Registered as `*Module` in `modules/qmldir`.
- **`windows/`** — popups/overlays opened from a module (e.g. clicking the battery module toggles `BatteryWindow`, a `PopupWindow` anchored to the panel item via `anchor.window`/`anchor.item`/`anchor.edges`). Windows receive the same service instance the triggering module uses.
- **`components/`** — generic, reusable building blocks with no domain knowledge (`IconButton`, `StyledText`, `BatteryInfoModal`). Prefer extending/reusing these over hand-rolling `Rectangle`+`Text`+`MouseArea` combos in a module.
- **`constants/Theme.qml`** — singleton (`pragma Singleton`) color palette (Nord-based). Always reference colors via `Theme.xxx`, never hardcode hex except for one-off/legacy spots.
- **`utils.js`** — `.pragma library` shared JS helpers (e.g. `getMinute`, `sliceText`); import with the relative path when needed.

### Conventions seen throughout the code
- Icons are Nerd Font glyphs rendered with `font.family: "JetBrainsMono Nerd Font"` — match existing glyph lookup patterns (ladder of `if (percentage >= x) return "..."`) when adding similar icon logic.
- Shelling out to external CLI tools (`tlp-stat`, `upower`, `notmuch`, `loginctl`, `systemctl`, `pkexec ...`) is the standard way to get/set system state that Quickshell's built-in services don't cover; use `Quickshell.Io.Process` with `StdioCollector`/`SplitParser` as shown in `services/BatteryService.qml` and `services/EmailService.qml`.
- Popups (`PopupWindow`) expose a `toggle()` function and are opened from a `MouseArea.onClicked` in the owning module's parent `Rectangle` in `shell.qml`, not from inside the module itself.
- Module/window files that need a service declare it as `required property <ServiceType> serviceName` rather than instantiating the service themselves — keeps services as singletons wired up from `shell.qml`.

### In-progress refactor (visible in git status)
The bar used to have flat module names (`Battery.qml`, `Clock.qml`, `Network.qml`, etc. — see deleted files) and is being migrated to a `*Module.qml` naming/registration convention (`BatteryModule.qml`, `ClockModule.qml`, ...) plus split out dedicated services and an `EmailModule`/`EmailService`. When touching an older-style file, prefer finishing the rename pattern rather than reintroducing the old naming.
