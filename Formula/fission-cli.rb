class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/archive/refs/tags/2.10.2.tar.gz"
  sha256 "9803da4b5c6d06b53d7c3fb2abdb79fa08091588d2e82b58b5547b73ebc6709b"
  license "AGPL-3.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/fission-suite/homebrew-fission/releases/download/fission-cli-2.10.2"
    sha256 cellar: :any,                 catalina:     "32eb34015170ec117aa8bacd9bed23cacccb9c15791872ee6f46442a6503c0d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "72755d734868addb0b410adb26493d79a110316810034c6ff3f1fc89c8c40b2b"
  end

  depends_on "ghc" => :build
  depends_on "haskell-stack" => :build
  depends_on "openssl"

  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  def install
    system "stack", "install", "--system-ghc", "--no-install-ghc", "--skip-ghc-check", "--local-bin-path=#{bin}",
      "fission-cli:fission"
  end

  test do
    system "#{bin}/fission", "--version"
  end
end
