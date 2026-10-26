class Heavy < Formula
  desc "A machine-wide counting semaphore for heavy commands: N slots shared by every checkout and agent on one machine"
  homepage "https://github.com/mokevnin/heavy"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/heavy/releases/download/v0.1.2/heavy-aarch64-apple-darwin.tar.xz"
      sha256 "c528c72e49252b5eb8ea76362e0b932710332b16a2d02621fcf9da746f7d35e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/heavy/releases/download/v0.1.2/heavy-x86_64-apple-darwin.tar.xz"
      sha256 "ac619d4e0bcde49d1110761b5217491e2f4f46b873e3516936e348b7e90beb0d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mokevnin/heavy/releases/download/v0.1.2/heavy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8e71812229f2269dd7bacedf27a384a1dc16cfd2d29db5063f523c09a15117b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mokevnin/heavy/releases/download/v0.1.2/heavy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "93929e20003a47b77a9c3bdd29a57cbeff85a90af536db8fbd8a1ae63e5cc0ca"
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
