class Agentch < Formula
  desc "macOS notch app that tracks your Claude Code and Codex sessions"
  homepage "https://github.com/aktoriukas/agentch"
  url "https://github.com/aktoriukas/agentch/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "b5b3109aafb444bcc917e4134aa55708415e5455c149f243e1e7a470f1161206"
  license "MIT"
  head "https://github.com/aktoriukas/agentch.git", branch: "main"

  # Built on the user's own machine, which is also what keeps Gatekeeper out of the way: there is
  # no Developer ID signature to check because nothing arrived pre-built.
  depends_on macos: :sonoma

  def install
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
