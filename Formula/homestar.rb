class Homestar < Formula
  desc "IPVM reference implementation"
  homepage "https://fission.codes/ipvm"
  url "https://github.com/ipvm-wg/homestar/archive/refs/tags/homestar-runtime-v0.3.0.tar.gz"
  sha256 "6bf60fb789f44935095d99b397e40961d44cfd07672c3b58d2e68524c3d327ac"
  license "Apache-2.0"

  head "https://github.com/ipvm-wg/homestar.git", branch: "main"

  bottle do
    root_url "https://github.com/fission-codes/homebrew-fission/releases/download/homestar-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b06b2630bf0e7c0aee717a96ba6a8643248f6803d8023e11c5394fb58a088fe4"
    sha256 cellar: :any_skip_relocation, monterey:      "91e750000240dcc51151cdc6aeacc7e854badb689a5ed010050dda87cc12c2e4"
  end

  depends_on "rust" => :build

  depends_on "ipfs"
  depends_on "rustup-init"

  def install
    system "cargo", "install", *std_cargo_args(path: "homestar-runtime")
  end

  # Run as a service
  service do
    run [opt_bin/"homestar", "start", "--db", var/"homestar.db"]
    keep_alive true
    log_path var/"log/homestar.log"
    error_log_path var/"log/homestar_error.log"
  end

  test do
    assert_match "homestar #{version}", shell_output("#{bin}/homestar --version")
  end
end
