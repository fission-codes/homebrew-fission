class Homestar < Formula
  desc "IPVM reference implementation"
  homepage "https://fission.codes/ipvm"
  url "https://github.com/ipvm-wg/homestar/archive/refs/tags/homestar-runtime-v0.3.0.tar.gz"
  sha256 "6bf60fb789f44935095d99b397e40961d44cfd07672c3b58d2e68524c3d327ac"
  license "Apache-2.0"

  head "https://github.com/ipvm-wg/homestar.git", branch: "main"

  bottle do
    root_url "https://github.com/fission-codes/homebrew-fission/releases/download/homestar-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bf35e30a8e52929fc8daa570f01561b65be03bef86a16dac9e0e52f6e058b131"
    sha256 cellar: :any_skip_relocation, monterey:      "853f3a08b240482b6b2614898bad8c821cbb9273610412527c449a1080083fce"
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
    assert_match "homestar #{version}", shell_output("#{bin}/homestar --version")
  end
end
