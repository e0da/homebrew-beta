# homebrew-beta

Public Homebrew tap for e0da beta-channel products.

```sh
brew tap e0da/beta
brew install e0da/beta/<formula>
```

## Why this tap exists, and how it differs from `homebrew-internal`

`e0da/homebrew-internal` is a **private** tap for products whose release
assets require authentication (`GitHubPrivateReleaseAssetDownloadStrategy`,
`HOMEBREW_GITHUB_API_TOKEN`). `homebrew-beta` is the opposite shape: a
**public** tap for products whose source repo is private but whose release
assets are public, so `brew install` needs no token at all.

| | `homebrew-internal` | `homebrew-beta` |
| --- | --- | --- |
| repo visibility | private | public |
| release asset visibility | private | public |
| formula `url` | `GitHubPrivateReleaseAssetDownloadStrategy` | plain `url` + `sha256` |
| install requires a token | yes | no |
| Actions / workflows | yes (formula CI) | formula syntax and metadata audits |

## Formulae

See [Formula](Formula) for the available products.

- [Mozak beta guide](docs/mozak.md) covers installation, upgrades, and configuration for the browser automation CLI and MCP server.

## Formula CI

Pull requests and main pushes that change formulas run Ruby syntax and Homebrew metadata audits on a disposable hosted macOS runner. The check installs no formula. Lenair and Mozak keep explicit version stanzas because their shared release publisher requires and updates those lines; Homebrew's version audit is excluded for those two generated formulas. CI separately requires those explicit version lines. All other metadata audits still run, and other formulas retain version auditing.
