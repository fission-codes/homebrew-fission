class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/archive/refs/tags/2.17.0.tar.gz"
  sha256 "82180794d726d3017639ea7c53a9d6e327447bff13272e79cdd40313ddfcc36f"
  license "AGPL-3.0-or-later"

  bottle do
    root_url "https://github.com/fission-suite/homebrew-fission/releases/download/fission-cli-2.17.0"
    sha256 cellar: :any,                 arm64_big_sur: "ac5b2400a658b410e2d15602faccb09b58a63ba71eb4363143ed865c0a92a7ab"
    sha256 cellar: :any,                 catalina:      "d3fcc74af4ac7f0ab2d6ea9ff50088cd5798a70fc852eb2ff81e168d38ce2cb8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dfa19c24fea4cbd068f3e48e0072c646c57111ab958bcd87f5446602e63bdbb5"
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
