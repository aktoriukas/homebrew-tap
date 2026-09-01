class Agentch < Formula
  desc "macOS notch app that tracks your Claude Code and Codex sessions"
  homepage "https://github.com/aktoriukas/agentch"
  url "https://github.com/aktoriukas/agentch/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "6e11ce308ba6de35ae91bb3ee127670db22aa586b690c6a7c8b6cc88e290562d"
  license "MIT"
  head "https://github.com/aktoriukas/agentch.git", branch: "main"

  # Built on the user's own machine, which is also what keeps Gatekeeper out of the way: there is
  # no Developer ID signature to check because nothing arrived pre-built.
  depends_on macos: :sonoma

  def install
    # No git metadata in a tarball, so the bundle version has to come from the formula.
    ENV["AGENTCH_VERSION"] = version.to_s
    system "./scripts/build-app.sh"
    prefix.install "build/Agentch.app"
  end

  def caveats
    <<~EOS
      agentch is a GUI app, so it lands in the Homebrew prefix rather than /Applications.
      Link it so Spotlight and "Launch at login" can find it:

        ln -sfn #{opt_prefix}/Agentch.app /Applications/Agentch.app

      Then:

        open -a Agentch

      Nothing appears in the Dock or the menu bar — move the pointer to the notch.
    EOS
  end

  test do
    system "#{prefix}/Agentch.app/Contents/MacOS/Agentch", "--selfcheck"
  end
end
