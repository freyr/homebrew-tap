class Jigolo < Formula
  desc "A TUI tool for managing CLAUDE.md context files"
  homepage "https://github.com/freyr/jigolo"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/freyr/jigolo/releases/download/v0.3.1/jigolo-aarch64-apple-darwin.tar.xz"
      sha256 "c00dd334346d1adfc8ba04a4503b0b9cec18b2bc7f612a12748dfd1964480b1f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freyr/jigolo/releases/download/v0.3.1/jigolo-x86_64-apple-darwin.tar.xz"
      sha256 "a8be762488688beb62080bf2106a75478857583a74830b8a1ef3354ba15ff684"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/freyr/jigolo/releases/download/v0.3.1/jigolo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9a94a55538e55317098d1e2293f9a6fbcd62bcdda2d3a8a4cf57b1732b2877ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/freyr/jigolo/releases/download/v0.3.1/jigolo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dc04125cf7eef0db8fd95ef0561232679ded7eb948e1196347c5aee0963ac55e"
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
