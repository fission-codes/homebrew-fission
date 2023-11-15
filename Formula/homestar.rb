class Homestar < Formula
  desc "IPVM reference implementation"
  homepage "https://fission.codes/ipvm"
  url "https://github.com/ipvm-wg/homestar/archive/cca75812fe50b0fe6d911e922223a16b501ebf57.tar.gz"
  version "0.1.0-1"
  sha256 "a131062ed8d446e735da22fdb438cff176a448d425876b3a0848782e1f95fa07"
  license "Apache-2.0"

  head "https://github.com/ipvm-wg/homestar.git", branch: "main"

  bottle do
    root_url "https://github.com/fission-codes/homebrew-fission/releases/download/homestar-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "888c9f72c5cdd3f9d95095eab9966a814f7e7439e5ef537d7050af12a3a6c513"
    sha256 cellar: :any_skip_relocation, monterey:      "aff14819ed561e9bb13cc4b1696df922916dbbf6a8599335d9d4d0b2e77f278e"
  end

  depends_on "rust" => :build

  depends_on "ipfs"
  depends_on "rustup-init"

  def install
    system "cargo", "install", *std_cargo_args(path: "homestar-runtime")

    # sample config
    (etc/"homestar").install "homestar-runtime/config/settings.toml" => "settings.toml"
  end

  # Run as a service
  service do
    run [opt_bin/"homestar", "start", "--config", etc/"homestar/settings.toml", "--db", var/"homestar.db"]
    keep_alive true
    log_path var/"log/homestar.log"
    error_log_path var/"log/homestar_error.log"
  end

  test do
    # assert_match "homestar #{version}", shell_output("#{bin}/homestar --version")
    system "#{bin}/homestar", "--version"
  end
end
