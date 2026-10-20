class EasyDocker < Formula
  desc "A fast, lightweight, and modern TUI for managing Docker containers, images, volumes, and networks built in Rust."
  homepage "https://github.com/brunopassosaun/easy-docker"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brunopassosaun/easy-docker/releases/download/v0.1.7/easy-docker-aarch64-apple-darwin.tar.xz"
      sha256 "19305ee32f21fa763921f24bd7d1c27dd3d0e7c93d48eaba3c48ef3a29047943"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunopassosaun/easy-docker/releases/download/v0.1.7/easy-docker-x86_64-apple-darwin.tar.xz"
      sha256 "071379c820c048d05d2f5c7143ec4c80ae1b6e32cb888cc6ba3d0e479c692d79"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brunopassosaun/easy-docker/releases/download/v0.1.7/easy-docker-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6f3cca4b758fb5660e34ed65bf14b42a031966c8151ffbe633e327f7f7ead17f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brunopassosaun/easy-docker/releases/download/v0.1.7/easy-docker-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "21efc458c37d7e7a79531b591a54e3d1d95160071f25d1c6cc8d045f2fc58d23"
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
