# gooonzick/tap

Homebrew casks for [Prism](https://github.com/gooonzick/prism) and
[Keysmith](https://github.com/gooonzick/keysmith). macOS, Apple silicon.

```bash
brew tap gooonzick/tap && brew trust gooonzick/tap
brew install --cask gooonzick/tap/prism
brew install --cask gooonzick/tap/keysmith
```

Prism's cask also puts the `prism` command on your `PATH`.

Both apps are ad-hoc signed, not notarized. Each cask clears the quarantine flag after
install so the app opens without a Gatekeeper prompt.

## Updating

`.github/workflows/bump.yml` checks each app's latest release every hour and commits the new
version and checksum. Run it now with `gh workflow run bump.yml -R gooonzick/homebrew-tap`, or
locally with `scripts/bump.sh`.
