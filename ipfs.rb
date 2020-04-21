class Ipfs < Formula
  desc "Peer-to-peer hypermedia protocol"
  homepage "https://ipfs.io"
  sha256 "28b0fbc270b66271d523267646ae0d4c6c617ba3eccb14d56c852701c0999081"
  url "https://github.com/ipfs/go-ipfs.git",
    :tag      => "v0.5.0-rc2",
    :revision => "b6dfe07237787191e685255aecb1a0be9770e35e"

  depends_on "go" => :build
  
  patch :DATA

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/ipfs/go-ipfs").install buildpath.children
    cd("src/github.com/ipfs/go-ipfs") { system "make", "install" }
    bin.install "bin/ipfs"

    cd("src/github.com/ipfs/go-ipfs") { bash_completion.install "misc/completion/ipfs-completion.bash" }

    if OS.linux?
      cd("src/github.com/ipfs/go-ipfs/misc/systemd") do
        (etc/"systemd/system").mkpath
        (etc/"systemd/system").install "ipfs.service"
        (etc/"systemd/system").install "ipfs-api.socket"
        (etc/"systemd/system").install "ipfs-gateway.socket"
        chmod 664, etc/"systemd/system/ipfs.service"
	      chmod "+x", "install-ipfs-systemd.sh"
	      bin.install "install-ipfs-systemd.sh"
      end
    end
   end

  plist_options :manual => "ipfs daemon"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/ipfs</string>
          <string>daemon</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
      </dict>
      </plist>
    EOS
  end 

  def caveats
    s = ""
    s += "To install ipfs as a systemd service, please run '#{bin}/install-ipfs-systemd.sh'" if OS.linux?
    s
  end

  test do
    assert_match "initializing IPFS node", shell_output(bin/"ipfs init")
    shell_output(etc/"systemd/system/ipfs.service")
  end 
end
__END__
diff --git a/misc/systemd/install-ipfs-systemd.sh b/misc/systemd/install-ipfs-systemd.sh
index e69de29..ae4b87c 100644
--- a/misc/systemd/install-ipfs-systemd.sh
+++ b/misc/systemd/install-ipfs-systemd.sh
@@ -0,0 +1,26 @@
+#!/usr/bin/env bash
+
+set -e
+set -x
+set -o pipefail
+
+[ -z "${XDG_RUNTIME_DIR}" ] && export XDG_RUNTIME_DIR=/run/user/"$(id -u)"
+
+pushd "HOMEBREW_PREFIX"/etc/systemd/system
+
+# ensure ipfs.service points the ipfs binary in the PATH
+ipfs_from_svc_file=$(sudo sed -n "s/ExecStart=\(\S*\)\s*\S*.*$/\1/p" ipfs.service)
+new_ipfs_bin_path=$(command -v ipfs)
+[ -z "${new_ipfs_bin_path}" ] && echo "ipfs not found in PATH" && exit 1
+if [[ "${new_ipfs_bin_path}" != "${ipfs_from_svc_file}" ]]; then
+    sudo sed -i "s;${ipfs_from_svc_file};${new_ipfs_bin_path};" ipfs.service
+fi
+chmod 644 ipfs.service
+for f in ipfs.service ipfs-api.socket ipfs-gateway.socket; do
+    sudo cp ${f} /etc/systemd/system/
+done
+popd
+
+sudo systemctl daemon-reload
+sudo systemctl start ipfs
+
