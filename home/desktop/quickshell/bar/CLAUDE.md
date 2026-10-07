# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A [Quickshell](https://quickshell.org) (QtQuick/QML) status bar config — pure QML + JS, no package manager, no build step, no test suite. It is one of two Quickshell shells managed from the parent NixOS config (the other is `quickshell/triggerkey`, a sibling directory, not part of this project).

In deployment, this whole directory is copied verbatim (via home-manager, see `../../quickshell.nix`) to `~/.config/quickshell-bar` and run as the systemd user service `quickshell-bar` with `quickshell -p shell.qml`, started `After=graphical-session.target`. Editing files here does not affect the running bar until the home-manager generation is rebuilt/switched and the service restarts (or you run quickshell directly against this directory, see below).

## Commands

- Enter the dev shell (provides `quickshell` and Qt6 QML, and sets `QML_IMPORT_PATH`): `nix develop`
- Run the bar directly against this source tree for iteration: `quickshell -p shell.qml` (from inside `nix develop`, run from this directory)
- Restart the deployed instance after a NixOS/home-manager rebuild: `systemctl --user restart quickshell-bar`
- There is no linter, formatter, or test runner in this repo — validate changes by running quickshell and watching stdout/stderr for QML warnings (bad bindings, missing properties) and by exercising the widget/popup in question.

## Architecture

`shell.qml` is the entry point (`ShellRoot`). It wires three kinds of QML components together, each imported via its directory's `qmldir`:

- **`services/`** — headless `Item`s that own polling `Process`es (via `Quickshell.Io`) and a `Timer` (almost always 1000ms), parsing CLI tool output (`pactl`, `upower`, `tlp-stat`, `date`, `notmuch`, `cliphist`, …) into QML properties. Services are instantiated **once** in `shell.qml` and passed down to the modules/windows that need them via `required property <ServiceType>` — a module never creates its own service instance, so there is a single source of truth per data source. Some simple modules (network, bluetooth, workspaces, sound, player) instead talk directly to a `Quickshell.*` backend singleton (e.g. `Quickshell.Networking`, `Quickshell.Hyprland`, `Quickshell.Services.Mpris`, `Quickshell.Services.Pipewire`) and have no corresponding service file.
- **`modules/`** — the small widgets actually placed in the bar row in `shell.qml` (battery %, clock, workspaces, mic/sound icons, email counts, etc). Thin presentational layer; `implicitWidth`/`implicitHeight` sized to content so the parent `Rectangle`/`Layout` in `shell.qml` can size around them.
- **`windows/`** — popups opened by clicking a module (battery details, audio mixer, network info, clipboard history, clock/calendar). Built on Quickshell's `PopupWindow`, anchored to the triggering module via `anchor.window` / `anchor.item` / `anchor.edges` / `anchor.gravity`, and exposing a `toggle()` method that the module's `MouseArea.onClicked` calls. Windows that need live data take the same service instance as a `required property`, so a window and its bar module always render the same backend state.
- **`components/`** — generic reusable leaf widgets (`IconButton`, `StyledText`) with no domain knowledge, used by modules/windows.
- **`constants/Theme.qml`** — a `pragma Singleton` holding the Nord-derived color palette and the font family (`"JetBrainsMono Nerd Font"`, used everywhere for icon glyphs). Any new UI should pull colors from `Theme`, not hardcode hex values.
- **`utils.js`** — a `.pragma library` of small formatting helpers (duration/time formatting, string slicing), imported as `import "../utils.js" as Utils"`.

`shell.qml` itself lays out the bar per-screen with `Variants { model: Quickshell.screens; delegate: PanelWindow { ... } }`, so the same bar is replicated on every connected screen; screen-specific data (if ever needed) would come from the delegate's `modelData`.

### Adding a new bar widget

The established pattern, following e.g. battery (service `BatteryService.qml` + module `BatteryModule.qml` + popup `BatteryWindow.qml`):
1. If it needs process polling, add a `services/XModule.qml` `Item` with a `Timer` + `Process`/`StdioCollector` (or `SplitParser` for line-streamed output) and expose plain QML properties.
2. Register it in `services/qmldir`.
3. Build the bar-row widget in `modules/`, taking the service as `required property XService` if it needs one; register in `modules/qmldir`.
4. If it needs a popup, add it in `windows/` as a `PopupWindow` with a `toggle()` and `anchor.*` bindings set from the module's `MouseArea`; register in `windows/qmldir`.
5. Instantiate the service (if any) once and the module/window in `shell.qml`.

### Notes on current state

- `modules/SysTrayModule.qml` exists but is not imported/placed in `shell.qml` — it's not currently part of the live bar layout.
- Process-based services generally poll on a fixed 1s `Timer` rather than reacting to events — follow that convention unless there's a push-based signal available (as the Quickshell `Networking`/`Hyprland`/`Mpris`/`Pipewire`/`UPower` backends provide).
