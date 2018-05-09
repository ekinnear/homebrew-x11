class Sptk < Formula
  desc "Suite of speech signal processing tools for UNIX environments"
  homepage "http://sp-tk.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/sp-tk/SPTK/SPTK-3.8/SPTK-3.8.tar.gz"
  sha256 "028d6b3230bee73530f3d67d64eafa32cf23eaa987545975d260d0aaf6953f2b"

  bottle do
    sha256 "4bcd3ee3646a117adf8d16bb4b2796c1619cce496cd7651c27089c17b2e89fe8" => :el_capitan
    sha256 "1970957eece7f87d93ffe027492bafff6d15d274e6d87b133628d39e4d4ea8cf" => :yosemite
    sha256 "9e6963a1c30a6a81918da2951bc02589325f4f6b80de05eebb598cdd9e03049b" => :mavericks
  end

  option "with-examples", "Install example data and documentation"

  depends_on :x11

  conflicts_with "libextractor", :because => "both install `extract`"
  conflicts_with "num-utils", :because => "both install `average`"
  conflicts_with "boost-bcp", :because => "both install `bcp`"
  conflicts_with "rcs", :because => "both install `merge`"

  fails_with :gcc do
    cause "Segmentation fault during linking."
  end

  resource "examples-data" do
    url "https://downloads.sourceforge.net/project/sp-tk/SPTK/SPTK-3.8/SPTKexamples-data-3.8.tar.gz"
    sha256 "3f37f279540e63ca55f0630d4aff8ba123203b0062b69fe379a8f1a951fddca9"
  end

  resource "examples-pdf" do
    url "https://downloads.sourceforge.net/project/sp-tk/SPTK/SPTK-3.8/SPTKexamples-3.8.pdf"
    sha256 "3bf21903a13b6b3d57b9684ad3800610c141e9333fcf9ee9df8543b234e567ce"
  end

  def install
    system "./configure", "CC=#{ENV.cc}", "--prefix=#{prefix}"
    system "make", "install"

    if build.with? "examples"
      (doc/"examples").install resource("examples-data"),
                               resource("examples-pdf")
    end
  end

  test do
    system "#{bin}/impulse", "-h"
    system "#{bin}/impulse -n 10 -l 100 | hexdump"
  end
end
