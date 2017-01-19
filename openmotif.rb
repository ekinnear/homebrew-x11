class Openmotif < Formula
  desc "LGPL release of the Motif toolkit"
  homepage "https://motif.ics.com/motif"
  url "https://downloads.sourceforge.net/project/motif/Motif%202.3.6%20Source%20Code/motif-2.3.6.tar.gz"
  sha256 "fa810e6bedeca0f5a2eb8216f42129bcf6bd23919068d433e386b7bfc05d58cf"
  revision 1

  bottle do
    sha256 "2dd57d34c84a5b2fcd67259668ce2b341ce83fd13c21f30e78593f3bf6b20f81" => :sierra
    sha256 "c7902c20cadf8a380ac74996130e9daca5ce13edcdb65eb785edbb6b5084c99a" => :el_capitan
    sha256 "a466184205f076ee0b06960908f5c311efc7afa9d301064d2c2cd0322c3067a9" => :yosemite
  end

  option :universal

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "jpeg" => :optional
  depends_on "libpng" => :optional
  depends_on :x11

  if build.universal?
    depends_on "flex" => [:build, :universal]
  end

  conflicts_with "lesstif",
    :because => "Lesstif and Openmotif are complete replacements for each other"

  # Removes a flag clang doesn't recognise/accept as valid
  # From https://trac.macports.org/browser/trunk/dports/x11/openmotif/files/patch-configure.ac.diff
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/b10858b/openmotif/patch-configure.ac.diff"
    sha256 "0cfff42cb7f37d4bd14fe778ba3d85e418586636b185b0c90e9e3c7d0a35feef"
  end

  # "Only weak aliases are supported on darwin"
  # Adapted from https://trac.macports.org/browser/trunk/dports/x11/openmotif/files/patch-lib-XmP.h.diff
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/b10858b/openmotif/patch-lib-XmP.h.diff"
    sha256 "320754bd0c1fa520c7576f3c7a22249a9b741c12f29606652add4a7a62c75d3f"
  end

  # Fixes "malloc.h not found" (reported upstream via email)
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/b10858b/openmotif/patch-demos-xrmLib.c.diff"
    sha256 "047f7b4cac522f3374990a3a2fcfb49259750104488b8a43cccfb3109ac5c8e0"
  end

  # Fix VendorShell reference for XQuartz 2.7.9+
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/b10858b/openmotif/patch-lib-VendorS.c.diff"
    sha256 "71b0573aea2d53cc304f206e2d68e5fa7922782cc21cc404b72739b01bfc8034"
  end

  def install
    ENV.universal_binary if build.universal?

    # https://trac.macports.org/browser/trunk/dports/x11/openmotif/Portfile#L59
    # Compile breaks if these three files are present.
    %w[demos/lib/Exm/String.h demos/lib/Exm/StringP.h demos/lib/Exm/String.c].each do |f|
      rm_rf f
    end

    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    args << "--disable-jpeg" if build.without? "jpeg"
    args << "--disable-png" if build.without? "libpng"

    system "./configure", *args
    system "make"
    system "make", "install"

    # Avoid conflict with Perl
    mv man3/"Core.3", man3/"openmotif-Core.3"
  end

  test do
    assert_match /no source file specified/, pipe_output("#{bin}/uil 2>&1")
  end
end
