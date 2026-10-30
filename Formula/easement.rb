class Easement < Formula
  desc "Architecture quality gate for polyglot codebases"
  homepage "https://github.com/mokevnin/easement"
  version "0.3.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/easement/releases/download/v0.3.7/easement-aarch64-apple-darwin.tar.xz"
      sha256 "72fed4dfd750ea170f258bd8f4684fdf181494df69ec86bcdabe433edb20741e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/easement/releases/download/v0.3.7/easement-x86_64-apple-darwin.tar.xz"
      sha256 "49da395eae3fded3b2b3d305d2fd0eb80edf1d62e3dfedfdb04786aeb0de4148"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/easement/releases/download/v0.3.7/easement-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "96a876b33829648a511b99fac998169a9ff461a2d2ac346ae666f4cdd77ced0d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/easement/releases/download/v0.3.7/easement-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a607d669e7645d87e11338d01cb9dfe63ac91e3a6dba921a56ccf7064e38096c"
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
