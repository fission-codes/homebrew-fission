class FissionCli < Formula
  desc "Deploy and run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/releases/download/2.3.0/fission-cli-macos"
  sha256 "73e855493316a18f66963313824daf57271b4afecb267ebb5a2b7fc56938b2a4"

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
