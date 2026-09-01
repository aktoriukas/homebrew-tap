# homebrew-tap

Homebrew tap for [aktoriukas](https://github.com/aktoriukas) tools.

## Install

```sh
brew tap aktoriukas/tap
brew install afk
brew install agentch
```

## Formulae

| Name | Description |
|---|---|
| [`afk`](./Formula/afk.rb) | Autonomous build/validate/review sessions for Claude Code. Source: [`aktoriukas/afk`](https://github.com/aktoriukas/afk). |
| [`agentch`](./Formula/agentch.rb) | macOS notch app tracking live Claude Code and Codex sessions, spend and rate limits. Source: [`aktoriukas/agentch`](https://github.com/aktoriukas/agentch). |

## Releasing a new version of `afk`

1. Tag a release in [`aktoriukas/afk`](https://github.com/aktoriukas/afk).
2. Download the tag tarball and compute its sha256:
   ```sh
   curl -fsSL "https://github.com/aktoriukas/afk/archive/refs/tags/vX.Y.Z.tar.gz" | shasum -a 256
   ```
3. Edit `Formula/afk.rb`: update `url` and `sha256`.
4. `brew audit --strict --new aktoriukas/tap/afk` to sanity-check.
5. Commit, push.
6. End users: `brew update && brew upgrade afk && afk install`.

## Trying a local change before tagging

```sh
brew install --HEAD aktoriukas/tap/afk    # installs from main
brew install --build-from-source ./Formula/afk.rb
```


## Releasing a new version of `agentch`

Same shape as `afk`, but the formula builds from source rather than installing a script, so the
user needs macOS 14+ and a Swift 6 toolchain (Xcode or the Command Line Tools). Building locally is
deliberate: an unsigned app downloaded from a release would be quarantined by Gatekeeper, and one
compiled on the machine is not.
