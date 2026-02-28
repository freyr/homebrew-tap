# typed: false
# frozen_string_literal: true

# This formula will be auto-updated by cargo-dist on release.
class ContextManager < Formula
  desc "A TUI tool for managing CLAUDE.md context files"
  homepage "https://github.com/freyr/claude-manager"
  license "MIT"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/freyr/claude-manager/releases/download/v#{version}/context-manager-aarch64-apple-darwin.tar.xz"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/freyr/claude-manager/releases/download/v#{version}/context-manager-x86_64-apple-darwin.tar.xz"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/freyr/claude-manager/releases/download/v#{version}/context-manager-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/freyr/claude-manager/releases/download/v#{version}/context-manager-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    bin.install "context-manager"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/context-manager --version")
  end
end
