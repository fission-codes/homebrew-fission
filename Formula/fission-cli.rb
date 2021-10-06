class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/archive/refs/tags/2.16.1.tar.gz"
  sha256 "21c5211d81f9107150a37f78f58830dae23070bb77bfe574db9e25f6307cb834"
  license "AGPL-3.0-or-later"

  bottle do
    root_url "https://github.com/fission-suite/homebrew-fission/releases/download/fission-cli-2.16.1"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "936dfd1f0e20b8634efd441262595d37d4b263dd2bb4c430311ef5d4140cbd6d"
    sha256 cellar: :any,                 catalina:      "387f1c1eccfd99789218a036ba3f92fc1a59e80077bc7b461e975de9feebd353"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2779e909167af807c89a15f9e8051745b4f897d8ab0ee16b7fe6093e17290167"
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
