class Jigolo < Formula
  desc "A TUI tool for managing CLAUDE.md context files"
  homepage "https://github.com/freyr/jigolo"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freyr/jigolo/releases/download/v0.4.0/jigolo-aarch64-apple-darwin.tar.xz"
      sha256 "34253f27d6eb080222bed9a5ab62027623082e16424f4f7301dfcbc50ad6c798"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freyr/jigolo/releases/download/v0.4.0/jigolo-x86_64-apple-darwin.tar.xz"
      sha256 "36499fcc32ddd25756eb5ba4b3feb739852ab0b8fcac1651d7ec5c4559294cd7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freyr/jigolo/releases/download/v0.4.0/jigolo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7ec9aeedfecc470f33657d62c89c9541ef8c1f983307f3f32a7ec6e3963d8609"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freyr/jigolo/releases/download/v0.4.0/jigolo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "02ac113da310c7a7ed10914509ace4463acb28388f3a6c21fb8ca515312a9ec5"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
    bin.install "jigolo" if OS.mac? && Hardware::CPU.arm?
    bin.install "jigolo" if OS.mac? && Hardware::CPU.intel?
    bin.install "jigolo" if OS.linux? && Hardware::CPU.arm?
    bin.install "jigolo" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
