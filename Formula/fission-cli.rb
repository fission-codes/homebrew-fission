class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/archive/refs/tags/2.15.0.tar.gz"
  sha256 "ffa187785fb4e8dee1096f90642404109ffd04fc8290d9ddf7303cf983210f18"
  license "AGPL-3.0-or-later"

  bottle do
    root_url "https://github.com/fission-suite/homebrew-fission/releases/download/fission-cli-2.15.0"
    sha256 cellar: :any,                 catalina:     "b5fd16a0229da926c7ae7dee95243b0cbcd4b0ae6977903782cba173bd3aaa50"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "995368d0c71a91f5b8ef4e42de3b54e4974f9fd9cdf55be7f8aa1fb259993dbe"
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
