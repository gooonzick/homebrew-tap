cask "keysmith" do
  version "0.1.0"
  sha256 "892998d6e9d59faeb5d3bdfc2498dd87064abcb9c44014eba91045d7f50f9aa9"

  url "https://github.com/gooonzick/keysmith/releases/download/v#{version}/keysmith-#{version}-macos-arm64.zip"
  name "Keysmith"
  desc "SSH config and SSH keys in one native window"
  homepage "https://github.com/gooonzick/keysmith"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Keysmith.app"

  # The app is ad-hoc signed, not notarized: without this Gatekeeper refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Keysmith.app"]
  end
end
