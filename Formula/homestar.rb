class Homestar < Formula
  desc "IPVM reference implementation"
  homepage "https://fission.codes/ipvm"
  url "https://github.com/ipvm-wg/homestar/archive/e7b2debd2fce7665f5cc9647d337fb52aaadac69.tar.gz"
  version "0.1.0-2"
  sha256 "5ef5ed854b1d3d7256f1bd401b99aafe761cd590c36f7b7b8260c6e7a1709fad"
  license "Apache-2.0"

  head "https://github.com/ipvm-wg/homestar.git", branch: "main"

  bottle do
    root_url "https://github.com/fission-codes/homebrew-fission/releases/download/homestar-0.1.0-2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a8a410c505b82a1e9cbe573fe9a8dc2ae5e7b1cdd736a29da623838ca5d30633"
    sha256 cellar: :any_skip_relocation, monterey:      "205dfebca6ca857cf8b38529c805c2ee1728305bad26d471ad1d87880b297bc4"
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
