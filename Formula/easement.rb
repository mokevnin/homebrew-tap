class Easement < Formula
  desc "Architecture quality gate for polyglot codebases"
  homepage "https://github.com/mokevnin/easement"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/easement/releases/download/v0.10.0/easement-aarch64-apple-darwin.tar.xz"
      sha256 "b435ea3d8e3ff9345cd5e65e6eda86594e193b11debcd98fb6518e371d63ffbb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/easement/releases/download/v0.10.0/easement-x86_64-apple-darwin.tar.xz"
      sha256 "1feb4bc0db7c4acb87dd157f4e8faaf7b382f8e8ccb106c07e1e35a5456f60a3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/easement/releases/download/v0.10.0/easement-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "25eebb9538fc55dae6a18a087dbbb3faf6ab2a70130d6c98596e7d30ece8304c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/easement/releases/download/v0.10.0/easement-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d16e58aab08bde6e3fe5ed5892bf800e54784580459ac09916f774426da44813"
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
