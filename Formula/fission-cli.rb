class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/archive/refs/tags/2.14.1.tar.gz"
  sha256 "7a3d2e526aa6b83903463555f84a997d75c22688f377561763967b40d3a76aa1"
  license "AGPL-3.0-or-later"

  bottle do
    root_url "https://github.com/fission-suite/homebrew-fission/releases/download/fission-cli-2.14.1"
    sha256 cellar: :any,                 catalina:     "e240cc10c95a84c2c10e5a5967e90fa132353cf0a51a4dee060fb8ae72e020f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3da4a758fb7e9eda951aa65f65d6f78cc19fbcfc0769c796a2323cc6fd5d473e"
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
