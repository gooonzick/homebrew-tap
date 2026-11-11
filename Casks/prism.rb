cask "prism" do
  version "0.2.0"
  sha256 "32a078518c0ca149abb1a725a4541bfb983242ff47488af206db537422231dc1"

  url "https://github.com/gooonzick/prism/releases/download/v#{version}/prism-#{version}-macos-arm64.zip"
  name "Prism"
  desc "Manage agent skills and MCP servers"
  homepage "https://github.com/gooonzick/prism"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Prism.app"
  binary "#{appdir}/Prism.app/Contents/MacOS/prism"

  # The app is ad-hoc signed, not notarized: without this Gatekeeper refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Prism.app"]
  end

  zap trash: "~/Library/Application Support/dev.prism.skills"
end
