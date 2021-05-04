class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/archive/refs/tags/2.13.0.tar.gz"
  sha256 "563e738c6e86d816d73a079ef16db90f7ee722849104e311467520ec259620dc"
  license "AGPL-3.0-or-later"

  bottle do
    root_url "https://github.com/fission-suite/homebrew-fission/releases/download/fission-cli-2.13.0"
    sha256 cellar: :any,                 catalina:     "8ac3fd027adb5a991b2c9f1693478841b51faaa3f4c28c28906d73d60d783b0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "eba1e5f2165f3956b9879ce8218a5b82df6566513a936dc7870f09a1175cfe4b"
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
