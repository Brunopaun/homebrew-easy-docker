class EasyDocker < Formula
  desc "A fast, lightweight, and modern TUI for managing Docker containers, images, volumes, and networks built in Rust."
  homepage "https://github.com/brunopassosaun/easy-docker"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brunopassosaun/easy-docker/releases/download/v0.1.8/easy-docker-aarch64-apple-darwin.tar.xz"
      sha256 "e0c6789a806388c5e95811f07c59c0215559f7fdba020b1492fa4f87e3dbe5f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunopassosaun/easy-docker/releases/download/v0.1.8/easy-docker-x86_64-apple-darwin.tar.xz"
      sha256 "b50298f97612e715696eec703775c7895b04d2c122f86d7c4158a5d0b4a35dc3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brunopassosaun/easy-docker/releases/download/v0.1.8/easy-docker-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e6a52df7a6fda21aa101a50f54d3128ce09d5239bc13a83fb7ea6a451ad171d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunopassosaun/easy-docker/releases/download/v0.1.8/easy-docker-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "88b434f23f80a4a86fc08dcc45ffb97c6352deebcaa4b79ff8bb4ef5e44e7ac5"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "easy-docker"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "easy-docker"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "easy-docker"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "easy-docker"
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
