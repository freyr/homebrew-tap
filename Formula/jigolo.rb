class Jigolo < Formula
  desc "A TUI tool for managing CLAUDE.md context files"
  homepage "https://github.com/freyr/jigolo"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freyr/jigolo/releases/download/v0.2.0/jigolo-aarch64-apple-darwin.tar.xz"
      sha256 "8b44a1183b9ec38fca730f0363c88b458b089e8c25d21299c93c27ef0c61f04b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freyr/jigolo/releases/download/v0.2.0/jigolo-x86_64-apple-darwin.tar.xz"
      sha256 "6eb52480af03f4611ab1bb139a1eed07b57d1ed9aadfc85097c6daf6ddb8fc87"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freyr/jigolo/releases/download/v0.2.0/jigolo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eec4278c5fbcb6bcee611212dafada471a304adc2a2b194334643b3a6ed39c81"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freyr/jigolo/releases/download/v0.2.0/jigolo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8c503ad0222d8fc23343f5e49c3c79af816389e509a03e6a4d8bf6620ba6c595"
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
