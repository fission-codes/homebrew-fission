class Homestar < Formula
  desc "IPVM reference implementation"
  homepage "https://fission.codes/ipvm"
  url "https://github.com/ipvm-wg/homestar/archive/33ca93b27a83e6dde28df4046dd5d5d71161cc8a.tar.gz"
  version "0.1.0"
  sha256 "5fb6f521698f19a0febd5195ed7ee56f457c8d38522902b52c5565a10eabfd15"
  license "Apache-2.0"

  head "https://github.com/ipvm-wg/homestar.git", branch: "main"

  depends_on "rust" => :build
  depends_on "ipfs"
  
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
