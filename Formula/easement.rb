class Easement < Formula
  desc "Architecture quality gate for polyglot codebases"
  homepage "https://github.com/mokevnin/easement"
  version "0.6.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/easement/releases/download/v0.6.4/easement-aarch64-apple-darwin.tar.xz"
      sha256 "c28c4a2796f1f5c91dc020408b27687a1b93dcc86c9dadc04e74ab7c05e29438"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/easement/releases/download/v0.6.4/easement-x86_64-apple-darwin.tar.xz"
      sha256 "401a9f0354769b92fd72db321edb046e2c6768024bf670c7554a68a296cb5267"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/easement/releases/download/v0.6.4/easement-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5075b1b32f022ce12e55deaac2da2e13f2f7237a1cfb2a6b4b3c1523b980d70e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/easement/releases/download/v0.6.4/easement-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bd78f0d176785ef81581dc40f24a70a54460ef750b387eaa178c56fda1d0167e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "easement"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "easement"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "easement"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "easement"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
