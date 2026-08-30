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
| Actions / workflows | yes (formula CI) | **none, by design** |

## Zero workflows, on purpose

This repo ships no GitHub Actions workflows. That's the enforcement mechanism
for keeping a public repo safe from stranger-triggered CI, not a convention
that happens to be true today — see
`ops/docs/homebrew-public-tap-standard.md` for the full rationale. Formula
validation for products on this tap runs in the product's own repo (private,
no outside access) before release assets are ever pushed here.

## Formulae

None yet. The first is `lenair` (E0D-1596/1597).
