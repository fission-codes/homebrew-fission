class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/archive/refs/tags/2.16.1.tar.gz"
  sha256 "21c5211d81f9107150a37f78f58830dae23070bb77bfe574db9e25f6307cb834"
  license "AGPL-3.0-or-later"

  bottle do
    root_url "https://github.com/fission-suite/homebrew-fission/releases/download/fission-cli-2.16.1"
    sha256 cellar: :any,                 catalina:     "1e054af1885d9fe5b4129fa58bef2faf6a2b302f01dbd7c6bafe4b9e44ad2331"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "30d082f663c29b3d8f6f89c742b802611aadf767be9c09b757beb1e9a21ebb61"
  end

  depends_on "ghc" => :build
  depends_on "haskell-stack" => :build
  depends_on "openssl"

  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  def install
    system "stack", "install", "--system-ghc", "--no-install-ghc", "--skip-ghc-check", "--local-bin-path=#{bin}",
      "--no-nix", "fission-cli:fission"

    (bash_completion/"fission").write `#{bin}/fission --bash-completion-script #{bin}/fission`
    (fish_completion/"fission.fish").write `#{bin}/fission --fish-completion-script #{bin}/fission`
    (zsh_completion/"_fission").write `#{bin}/fission --zsh-completion-script #{bin}/fission`
  end

  test do
    system "#{bin}/fission", "--version"
  end
end
