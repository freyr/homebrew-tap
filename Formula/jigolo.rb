class Jigolo < Formula
  desc "A TUI tool for managing CLAUDE.md context files"
  homepage "https://github.com/freyr/jigolo"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freyr/jigolo/releases/download/v0.3.0/jigolo-aarch64-apple-darwin.tar.xz"
      sha256 "3dc1a8788a548b504d84f1783f24db47727ab5d5ed59a22d5551344c978137a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freyr/jigolo/releases/download/v0.3.0/jigolo-x86_64-apple-darwin.tar.xz"
      sha256 "7a72b59b6c9f981ee3333d5ef5ab6cc64b69092fbdfe0fddbc66208540a93e9d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freyr/jigolo/releases/download/v0.3.0/jigolo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4e735d7a26685600f32331d6608d44b4e6cfaa6fe80ef6590a6b3325ea23a571"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freyr/jigolo/releases/download/v0.3.0/jigolo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f6f9f1323ce189c02d535a791e695b202baa07dbe3642fcc9400d50fef98746a"
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
