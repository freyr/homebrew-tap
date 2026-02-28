class Jigolo < Formula
  desc "A TUI tool for managing CLAUDE.md context files"
  homepage "https://github.com/freyr/jigolo"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freyr/jigolo/releases/download/v0.1.0/jigolo-aarch64-apple-darwin.tar.xz"
      sha256 "e06d916ab56d7a95ff702f8e893ba0819e1dcddb15144ceddff81c53cf2f382a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freyr/jigolo/releases/download/v0.1.0/jigolo-x86_64-apple-darwin.tar.xz"
      sha256 "a635ce3a52f15a480d793652a3e1cb477f11e462b14d1af59ab3db10a086ca71"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freyr/jigolo/releases/download/v0.1.0/jigolo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "feb3626022d6325ba470b8232eb82cc0aa96d4b268d193202ac7f960a98a06ca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freyr/jigolo/releases/download/v0.1.0/jigolo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "20b5afff460dc8492673869f4acf614f3cf11d12a4aa1fec83ff6901a9d24fb2"
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
