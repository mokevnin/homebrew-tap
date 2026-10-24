class Heavy < Formula
  desc "A machine-wide counting semaphore for heavy commands: N slots shared by every checkout and agent on one machine"
  homepage "https://github.com/mokevnin/heavy"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/heavy/releases/download/v0.1.0/heavy-aarch64-apple-darwin.tar.xz"
      sha256 "9e36e9b513a3be20d3012a8d45fc0ee6429e23904a361eeb4743c99614c63d19"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/heavy/releases/download/v0.1.0/heavy-x86_64-apple-darwin.tar.xz"
      sha256 "a367eae444cfaef2dfb0c38b0cc62691c3aa634d4eaa10888687c57d7f6abfed"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/heavy/releases/download/v0.1.0/heavy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "960cc96d9db894e1d327a67effdfe52fa3031ff5eec0713b653b11535bc9fdae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/heavy/releases/download/v0.1.0/heavy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3af36806c6dbe9628505d357b191e58ac05c5651b95833b1838fc62b6be168d3"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
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
      bin.install "heavy"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "heavy"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "heavy"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "heavy"
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
