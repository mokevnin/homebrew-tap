class Easement < Formula
  desc "Architecture quality gate for polyglot codebases"
  homepage "https://github.com/mokevnin/easement"
  version "0.4.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/easement/releases/download/v0.4.11/easement-aarch64-apple-darwin.tar.xz"
      sha256 "edea146819a79dd3b1d80e22ea5acdf40196630101f2923ba498b9e2b4298849"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/easement/releases/download/v0.4.11/easement-x86_64-apple-darwin.tar.xz"
      sha256 "dc07e8399a57bce57846aa667a950cff80a6f81755001fb4d2b4ab30774dac30"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/easement/releases/download/v0.4.11/easement-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eb893435ce6f30c56d81bec5671e019c9931465728570582833eee8168c892e8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/easement/releases/download/v0.4.11/easement-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1596ffcb16396c661c7483281efa738c6b4b40bb15ab1751105634227eee9431"
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
