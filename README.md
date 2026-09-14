# saathihq/homebrew-tap

Homebrew tap for [Saathi](https://github.com/saathihq/saathi) — a companion for learning and
playing with new things, approached from the accessibility side.

```bash
brew trust saathihq/tap
brew tap saathihq/tap
brew install --cask saathi
```

`Saathi.app` is installed to `/Applications` and `saathi` is put on your PATH.

**The `brew trust` step is not optional.** Homebrew 6 refuses to load a cask from a third-party tap
until you say you trust it — a cask is Ruby that runs on your machine, so it is asking a fair
question. Without it, `brew tap` fails with `Refusing to load cask ... from untrusted tap`. Every
third-party cask tap needs this now; it is not specific to Saathi.

## Why a tap rather than homebrew-cask

homebrew-cask requires a project to be about a month old with a few dozen stars before it will take
a submission. This tap needs no approval and behaves identically for anyone who taps it; the cask
can move to homebrew-cask later without changing the command people type to install it.

## Why a cask and not a formula

Saathi's executable is inside an `.app` bundle, and that is not cosmetic. A bare command-line
executable has no main bundle, and macOS will not let a process ask for the microphone or for
speech recognition unless the usage-description strings live in its main bundle. Saathi's default
voice lane — the one that needs no API key and keeps everything on the machine — needs both.

So the cask installs the bundle and then symlinks the executable inside it onto your PATH. One
signed, notarized binary on the machine, reachable both ways.
