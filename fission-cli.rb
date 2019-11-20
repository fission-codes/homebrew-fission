class FissionCli < Formula
  desc "Deploy live from your laptop, and other web3 tricks for a web2 world"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/cli/releases/download/1.22.0/macOS-10.14.zip"
  sha256 "ee4bd0404631af6034ba4ed4e95fbfa3a3acd4a76e267641681e8880f4cc248a"

  def install
    bin.install "fission-cli-exe"
    mv bin/"fission-cli-exe", bin/"fission"
    ohai "Please ensure IPFS is running with: brew services start ipfs"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test web-api`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
