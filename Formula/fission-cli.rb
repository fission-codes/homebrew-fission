class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/archive/refs/tags/2.10.2.tar.gz"
  sha256 "9803da4b5c6d06b53d7c3fb2abdb79fa08091588d2e82b58b5547b73ebc6709b"
  license "AGPL-3.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/fission-suite/homebrew-fission/releases/download/fission-cli-2.10.2_1"
    sha256 cellar: :any,                 catalina:     "d5b54bc1d27794a558146032b1794fa6dd31239cf56d1a8db833e7124abba374"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "aa0ea15bd4175b136d0ab37316f08607a1853eebf913a0362fa546c756695d10"
  end

  depends_on "ghc" => :build
  depends_on "haskell-stack" => :build
  depends_on "openssl"

  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  def install
    system "stack", "install", "--system-ghc", "--no-install-ghc", "--skip-ghc-check", "--local-bin-path=#{bin}",
      "fission-cli:fission"

    (bash_completion/"fission").write `#{bin}/fission --bash-completion-script #{bin}/fission`
    (fish_completion/"fission.fish").write `#{bin}/fission --fish-completion-script #{bin}/fission`
    (zsh_completion/"_fission").write `#{bin}/fission --zsh-completion-script #{bin}/fission`
  end

  test do
    system "#{bin}/fission", "--version"
  end
end
