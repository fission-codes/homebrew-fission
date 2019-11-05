class FissionCli < Formula
  desc "Deploy live from your laptop, and other web3 tricks for a web2 world"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/cli/releases/download/1.20.0/macos-cli"
  sha256 "82d4e19211c27dab590f1701b39841a1fbd945fd9670eba9fd9c23000cae8e04"

  depends_on "ipfs"

  def install
    bin.install "macos-cli"
    mv bin/"macos-cli", bin/"fission"
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
