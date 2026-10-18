class EasyDocker < Formula
  desc "A fast, lightweight, and modern TUI for managing Docker containers, images, volumes, and networks"
  homepage "https://github.com/Brunopaun/easy-docker"
  version "0.1.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Brunopaun/easy-docker/releases/download/v0.1.6/easy-docker-aarch64-apple-darwin.tar.gz"
      sha256 "adfad506ea7b1a594afb764a18e7b51e4877848429845c4de53a7396e5d168c0"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/Brunopaun/easy-docker/releases/download/v0.1.6/easy-docker-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c8f3e88f5ba18c40a8ae0cc18ef1908da10d30ca8bebe8543cd4ae417e3d6a22"
    end
  end

  def install
    bin.install "easy-docker"
  end

  test do
    system "#{bin}/easy-docker", "--version"
  end
end
