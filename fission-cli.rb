class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/releases/download/2.4.2/fission-cli-macos"
  sha256 "b90cefc8d5bdf5b861ff1e0d96ed10b658b54f7ace488f3ebd247785441287da"

  def install
    bin.install "fission-cli-macos"
    mv bin/"fission-cli-macos", bin/"fission"
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
