class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-codes/fission/archive/refs/tags/2.18.0.tar.gz"
  sha256 "876cd9e24ae584c283257ffa64504be5d08e20fd1804fb278a1e1c475f6aeed8"
  license "AGPL-3.0-or-later"

  bottle do
    root_url "https://github.com/fission-codes/homebrew-fission/releases/download/fission-cli-2.18.0"
    sha256 cellar: :any,                 arm64_monterey: "527972bfe69e2d73aff6ece43101c0187e6d0f05ee844c7e4640c5ac2ee56c6e"
    sha256 cellar: :any,                 big_sur:        "688022b02f748dce9ecb8132c9b67dc1480f047521339defa4435ae014fa67d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4944310619cbcc19bb8ada248d10858bf490ca96c26a3d2b86a4cf937d7c9397"
  end

  depends_on "ghc" => :build
  depends_on "haskell-stack" => :build
  depends_on "openssl"

  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  def install
    system "stack", "install", "--system-ghc", "--no-install-ghc", "--skip-ghc-check", "--local-bin-path=#{bin}",
      "--no-nix", "fission-cli:fission"

    generate_completions_from_executable(bin/"fission", "--bash-completion-script", bin/"fission",
                                         shells: [:bash], shell_parameter_format: none)
    generate_completions_from_executable(bin/"fission", "--fish-completion-script", bin/"fission",
                                         shells: [:fish], shell_parameter_format: none)
    generate_completions_from_executable(bin/"fission", "--zsh-completion-script", bin/"fission",
                                         shells: [:zsh], shell_parameter_format: none)
  end

  test do
    system "#{bin}/fission", "--version"
  end
end
