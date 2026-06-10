class Afk < Formula
  desc "Autonomous build/validate/review sessions for Claude Code"
  homepage "https://github.com/aktoriukas/afk"
  url "https://github.com/aktoriukas/afk/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "REPLACE_ME_AT_RELEASE"
  license "MIT"
  head "https://github.com/aktoriukas/afk.git", branch: "main"

  def install
    bin.install "bin/afk"
    pkgshare.install Dir["share/*"]
    pkgshare.install "VERSION"
  end

  def caveats
    <<~EOS
      AFK is installed but not yet wired into Claude Code.

      Run:
        afk install        # symlink workflow files into ~/.claude/
        afk doctor         # verify

      To remove later:
        afk uninstall
        brew uninstall afk

      `afk install` is idempotent — re-run it after `brew upgrade afk`.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/afk version")
    assert_match "skills/afk/SKILL.md", shell_output("ls #{pkgshare}/skills/afk")
  end
end
