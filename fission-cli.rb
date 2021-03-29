class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/releases/download/2.10.0/fission-cli-macos"
  sha256 "67c99b2a9ebbf6edd728a355d7b625b4d0a4e510df2f13b1d50c812825f74402"

  def install
    bin.install "fission-cli-macos"
    mv bin/"fission-cli-macos", bin/"fission"
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
