class Nb < Formula
  desc "Command-line and local web note-taking, bookmarking, and archiving"
  homepage "https://xwmx.github.io/nb"
  url "https://github.com/xwmx/nb/archive/refs/tags/7.14.3.tar.gz"
  sha256 "3aa61b50146aff15399bdb4d5cb050620680ab6b5b68190d7d0f80fd4fb773dc"
  license "AGPL-3.0-or-later"
  head "https://github.com/xwmx/nb.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "331924af95aefbdd3b5210918184f69d83cdfe6b8ac0a20638b94054506d7eb1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "331924af95aefbdd3b5210918184f69d83cdfe6b8ac0a20638b94054506d7eb1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "331924af95aefbdd3b5210918184f69d83cdfe6b8ac0a20638b94054506d7eb1"
    sha256 cellar: :any_skip_relocation, sonoma:        "2994445324b07ad561337d6edc0ce81cb444e2c146f1b46a1c7a89f0a2df4c54"
    sha256 cellar: :any_skip_relocation, ventura:       "2994445324b07ad561337d6edc0ce81cb444e2c146f1b46a1c7a89f0a2df4c54"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "331924af95aefbdd3b5210918184f69d83cdfe6b8ac0a20638b94054506d7eb1"
  end

  depends_on "bat"
  depends_on "nmap"
  depends_on "pandoc"
  depends_on "ripgrep"
  depends_on "tig"
  depends_on "w3m"

  uses_from_macos "bash"

  def install
    bin.install "nb", "bin/bookmark"

    bash_completion.install "etc/nb-completion.bash" => "nb.bash"
    zsh_completion.install "etc/nb-completion.zsh" => "_nb"
    fish_completion.install "etc/nb-completion.fish" => "nb.fish"
  end

  test do
    # EDITOR must be set to a non-empty value for ubuntu-latest to pass tests!
    ENV["EDITOR"] = "placeholder"

    assert_match version.to_s, shell_output("#{bin}/nb version")

    system "yes | #{bin}/nb notebooks init"
    system bin/"nb", "add", "test", "note"
    assert_match "test note", shell_output("#{bin}/nb ls")
    assert_match "test note", shell_output("#{bin}/nb show 1")
    assert_match "1", shell_output("#{bin}/nb search test")
  end
end
