class Dzen2 < Formula
  desc "General purpose messaging, notification and menuing program"
  homepage "https://github.com/robm/dzen"
  url "https://sites.google.com/site/gotmor/dzen2-0.8.5.tar.gz"
  sha256 "5e4ce96e8ed22a4a0ad6cfafacdde0532d13d049d77744214b196c4b2bcddff9"
  head "https://github.com/robm/dzen.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c82457d84dace67277e655f01ae2c95a65f17fe43b259dfa91589b1843903d85" => :el_capitan
    sha256 "fb37a342a25d69fb2a917e3e4ed0a963f0719facc3ad3735a104c28acdddbccd" => :yosemite
    sha256 "aac47f482d43cf7a7d83f3b2165bddae2073adc90e175aae53941814beecf491" => :mavericks
  end

  depends_on :x11

  def install
    ENV.append "LDFLAGS", "-lX11 -lXinerama -lXpm"
    ENV.append_to_cflags '-DVERSION=\"${VERSION}\" -DDZEN_XINERAMA -DDZEN_XPM'

    inreplace "config.mk" do |s|
      s.change_make_var! "PREFIX", prefix
      s.change_make_var! "CC", ENV.cc
      s.change_make_var! "CFLAGS", ENV.cflags
      s.change_make_var! "LDFLAGS", ENV.ldflags
    end

    system "make", "install"
  end
end
