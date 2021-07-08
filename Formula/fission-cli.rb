class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/archive/refs/tags/2.15.0.tar.gz"
  sha256 "ffa187785fb4e8dee1096f90642404109ffd04fc8290d9ddf7303cf983210f18"
  license "AGPL-3.0-or-later"

  bottle do
    root_url "https://github.com/fission-suite/homebrew-fission/releases/download/fission-cli-2.14.2"
    sha256 cellar: :any,                 catalina:     "6c678fd25cfe73a9d2ed71dd392829b86d3643f48ddd1152c527064763371419"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e0c9553ac3ade0785741540ef76aa43cb3c76a69c25875305d5743648a58220d"
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
