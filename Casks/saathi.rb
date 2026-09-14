cask "saathi" do
  version "0.5.0"
  sha256 "8898b7e40b88d93907f20d3217a292157e9046ee4c65c310ae8174ca008cb487"

  url "https://github.com/saathihq/saathi/releases/download/v#{version}/Saathi-#{version}.zip"
  name "Saathi"
  desc "Companion for learning and playing with new things, driven by voice"
  homepage "https://github.com/saathihq/saathi"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  # Both stanzas, on purpose.
  #
  # `app` puts the bundle in /Applications, which is what gives Saathi its own identity to macOS —
  # a bare executable has no main bundle, and without one it cannot ask for the microphone or for
  # speech recognition at all. The default voice lane needs both.
  #
  # `binary` then puts the executable inside that bundle on PATH, so `saathi voice` works from a
  # terminal without anyone typing a path into /Applications. It is a symlink INTO the app rather
  # than a second copy, so there is one signed, stapled binary on the machine and not two.
  app "Saathi.app"
  binary "#{appdir}/Saathi.app/Contents/MacOS/saathi"

  # `~/.saathi/shell.json` can hold an API key or an account token, so it is never removed on
  # uninstall — only on `--zap`, which is the flag that says "remove what I configured too".
  zap trash: [
    "~/.saathi",
    "~/Library/Preferences/dev.saathi.Saathi.plist",
  ]

  caveats <<~EOS
    Saathi runs against a model on your own machine by default — no key, no account,
    and nothing leaves the device. Check what you are actually in with:

      saathi provider
      saathi voice

    macOS attributes a permission prompt to the process that started it, so granting
    the microphone from a terminal can attach the permission to the terminal rather
    than to Saathi. If speech recognition does not come up, launch it once with
    `open -a Saathi` and grant it there.
  EOS
end
