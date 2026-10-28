class EasyDocker < Formula
  desc "A fast, lightweight, and modern TUI for managing Docker containers, images, volumes, and networks built in Rust."
  homepage "https://github.com/Brunopaun/easy-docker"
  version "0.1.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Brunopaun/easy-docker/releases/download/v0.1.9/easy-docker-aarch64-apple-darwin.tar.xz"
      sha256 "33ec930a38cdb3a8453e9417301df93a0ec6ea5ed446bbddca466f416be5c2be"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Brunopaun/easy-docker/releases/download/v0.1.9/easy-docker-x86_64-apple-darwin.tar.xz"
      sha256 "03ad543e257a0c4df07d36b380502f7c0b6cec1414190f124068e25498ef0c1e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Brunopaun/easy-docker/releases/download/v0.1.9/easy-docker-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9d0aac0bf226346aa4c83abcf3d122cb3b232d75958be2377e260e6919e9b8be"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Brunopaun/easy-docker/releases/download/v0.1.9/easy-docker-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "90fcf27ab079bd130af9455b49778ecb3efc395cfebdf3b5f583d3eaff13ca29"
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
