class Easement < Formula
  desc "Architecture quality gate for polyglot codebases"
  homepage "https://github.com/mokevnin/easement"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/easement/releases/download/v0.5.1/easement-aarch64-apple-darwin.tar.xz"
      sha256 "53644d7f63d7f53dce3f247650da76e5a9d8ab3b2fde4112d98e74069afac592"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/easement/releases/download/v0.5.1/easement-x86_64-apple-darwin.tar.xz"
      sha256 "b846a4a5beac94065f3330688e4dffbe03d7162ab96398551febc0b091c8be60"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/easement/releases/download/v0.5.1/easement-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9b22e516f0c733f68da7b99b55ab030a9425d4da4a771230aab5d808e71cf7a6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/easement/releases/download/v0.5.1/easement-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "72537338eef5b2e710281636b0b92e36d30d71d33175b98e6ce999d59e59a993"
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
