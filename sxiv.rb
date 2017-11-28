class Sxiv < Formula
  desc "Simple X Image Viewer"
  homepage "https://github.com/muennich/sxiv"
  url "https://github.com/muennich/sxiv/archive/v1.3.2.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/s/sxiv/sxiv_1.3.2.orig.tar.gz"
  sha256 "9f5368de8f0f57e78ebe02cb531a31107a993f2769cec51bcc8d70f5c668b653"

  head "https://github.com/muennich/sxiv.git"

  bottle do
    cellar :any
    sha256 "3d08780acdf39c80dda46bfdd90f22d2c71dbbd8eca06d09520637bb6900238a" => :sierra
    sha256 "e60cfd9810466255b8e7e1a6569b99c911ded33ad6a944a34cc86328d8b56f75" => :el_capitan
    sha256 "bc44a8b794c2451f8048ac6a83996d0901b052823ff536b87ccdee8b44a151df" => :yosemite
  end

  depends_on :x11
  depends_on "imlib2"
  depends_on "giflib"
  depends_on "libexif"

  def install
    system "make", "config.h"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system "#{bin}/sxiv", "-v"
  end
end
