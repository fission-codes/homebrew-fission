class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/archive/refs/tags/2.10.2.tar.gz"
  sha256 "9803da4b5c6d06b53d7c3fb2abdb79fa08091588d2e82b58b5547b73ebc6709b"
  license "AGPL-3.0-or-later"

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
