# Mozak beta

Mozak is a browser automation CLI and MCP server for macOS. Install it through Homebrew to drive Chrome, inspect pages, and capture screenshots or recordings.

## Install

```sh
brew tap e0da/beta
brew install e0da/beta/mozak
mozak --version
mozak --help
```

If Homebrew asks you to trust the formula, run `brew trust --formula e0da/beta/mozak` and retry the install.

The Homebrew package includes the compiled CLI for Apple Silicon and Intel Macs. Installation works without GitHub credentials. Use a running Docker-compatible runtime with Compose for Mozak-managed Chrome, or connect to an existing browser over Chrome DevTools Protocol (CDP).

## First run

From the workspace where you want to use managed Chrome, run these commands.

```sh
mozak start --wait
mozak open https://example.com
mozak status
mozak screen
```

`mozak screen` opens the managed browser display so you can see the page. Use `mozak instructions agent` for agent workflows or run `mozak mcp` as a stdio server from your MCP client.

## Upgrade an existing installation

```sh
brew update
brew upgrade e0da/beta/mozak
brew test e0da/beta/mozak
mozak --version
```

`brew test` checks the installed package. From the workspace you were using, run `mozak status` and `mozak doctor` to check the browser. Follow the diagnosed recovery action. If the managed browser needs the upgraded image, run `mozak restart` in that workspace, then run `mozak doctor` again and verify the page and any login you need.

If Homebrew reports no upgrade, compare `mozak --version` with the version listed in the [Mozak formula](../Formula/mozak.rb) and its linked release. Use `brew reinstall e0da/beta/mozak` when you intend to replace the installed package at the same version.

## Configuration

### Connect to an existing browser

Start your browser with a reachable CDP endpoint, then run the following. Replace the example endpoint with your browser's endpoint.

```sh
mozak connect http://localhost:9222
MOZAK_CDP_ENDPOINT=http://localhost:9222 mozak status
```

`connect` verifies the connection for that invocation. Set `MOZAK_CDP_ENDPOINT` for each subsequent command that should use the same browser. You manage the browser process.

### Local settings

Mozak looks for global configuration such as lifecycle hooks in `~/.config/mozak/`. Set `XDG_CONFIG_HOME` to place that directory under a different root. Chrome profile data uses a separate location, `~/.local/share/mozak/profiles/` by default.

```sh
XDG_CONFIG_HOME="$HOME/custom-config" mozak status
```

`CDP_PORT` and `NOVNC_PORT` set the loopback ports for the default managed session. They default to `9322` and `6080`, respectively. For workspace-scoped sessions, use `mozak status` to find the allocated ports.

### Demo configuration examples

Homebrew installs the AG Grid and caller-owned composition references with their own READMEs and `demo.mozak.json` files.

```sh
examples_dir="$(brew --prefix mozak)/share/mozak/examples"
ls "$examples_dir/ag-grid" "$examples_dir/caller-owned-composition"
```

Follow the example README to fill in the fixture URL and evidence directory in a copy of its demo file. Use `mozak demo check <file>` to validate the configured copy.

## Support

Report bugs, ideas, and questions in the [public beta issues](https://github.com/e0da/homebrew-beta/issues). Report suspected vulnerabilities through [private vulnerability reporting](https://github.com/e0da/homebrew-beta/security/advisories/new).
