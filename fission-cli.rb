class FissionCli < Formula
  desc "Deploy & run sites live from your laptop"
  homepage "https://fission.codes"
  url "https://github.com/fission-suite/fission/releases/download/2.10.2/fission-cli-macos"
  sha256 "871acb13ae4a3676b67bbeb2ae3681764505e99fdd68bfb4a1e0854967848dc5"

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
