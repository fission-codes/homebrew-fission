class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/archive/refs/tags/2.18.0.tar.gz"
  sha256 "876cd9e24ae584c283257ffa64504be5d08e20fd1804fb278a1e1c475f6aeed8"
  license "AGPL-3.0-or-later"

  bottle do
    root_url "https://github.com/fission-suite/homebrew-fission/releases/download/fission-cli-2.17.2"
    sha256 cellar: :any,                 arm64_monterey: "1d149cb72a22c2602a22255f3bce7d1199a9f36c8c4a8ad26761d890bbd66608"
    sha256 cellar: :any,                 big_sur:        "b05a1495931ef97b38ea9190d1ac888dca6e01c52b8892b9d4db72178203ac2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1673155c2fc18f898ae65fff7c0f695a1831138a700ac358863d57ccda5241d9"
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
