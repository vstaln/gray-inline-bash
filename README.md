<p align="center">
  <img src="assets/gray-logo.svg" alt="gray" width="96">
</p>
<h1 align="center">gray-inline-bash</h1>
<p align="center">Run shell commands inline — `!cmd` or `$ cmd` — without spending a model turn.</p>
<p align="center">
  <a href="https://github.com/vstaln/gray-inline-bash/blob/main/LICENSE"><img alt="MIT License" src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
  <img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-7aa2f7.svg">
  <img alt="rust" src="https://img.shields.io/badge/built%20with-rust-orange.svg">
</p>

Run shell commands inline — `!cmd` or `$ cmd` — and see the output without a
model turn.

A sidecar plugin for [gray](https://github.com/vstaln/gray).

## What it does

Hooks `input/submit` (protocol 2.0):

| input | effect |
|---|---|
| `!cmd` / `!{cmd}` / `$ cmd` | runs `timeout 10 sh -c "cmd"` in the session cwd, `host/say`s the output (4 KB cap), input swallowed |
| anything else | passes through unchanged |

If `host/say` fails (capability ungranted) the input is rewritten to
`The user ran `<cmd>` and saw: …` instead — a visible turn beats a silent
swallow. Non-zero exit codes are shown as `(exit N)`.

`/inline` reports status; `/inline on|off` toggles (state in
`~/.gray/inline-bash/`).

## Wire methods

- `plugin/manifest`, `plugin/shutdown`
- `input/submit` — `{handled:true}` swallow / `{text}` fallback rewrite / `{}` pass
- `command/run` — `/inline`, `/inline on|off`
- sidecar→host `host/say` — capability `host.say`

## Install / consent

```sh
gray plugin install inline-bash
gray plugin capabilities inline-bash --all   # grants host.say
```

## Develop

```sh
cargo test
gray account check      # entry point + manifest handshake
gray account publish    # check → build → release → publish to the gray registry
```

Bump `version` in `Cargo.toml` before each `publish`; the registry refuses to
republish a version.

---

Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
