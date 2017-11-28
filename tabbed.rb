class Tabbed < Formula
  desc "Simple generic tabbed fronted to xembed aware applications"
  homepage "http://tools.suckless.org/tabbed"
  url "http://dl.suckless.org/tools/tabbed-0.6.tar.gz"
  sha256 "7651ea3acbec5d6a25469e8665da7fc70aba2b4fa61a2a6a5449eafdfd641c42"

  head "http://git.suckless.org/tabbed", :using => :git

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "d8cae93e79574d26ebeecb138c1b249920e9e30d77eae614695ebacdc96b8562" => :el_capitan
    sha256 "ced60eb28e2793135d0a3cf99593fc92e961228e0846bf1fcf14fbddf13de3f4" => :yosemite
    sha256 "eba76e91f5d758721dbdda08f00017473d43884ced7be84877338ed0b05d2b63" => :mavericks
  end

  depends_on :x11

  def install
    inreplace "config.mk", "LIBS = -L/usr/lib -lc -lX11", "LIBS = -L#{MacOS::X11.lib} -lc -lX11"
    system "make", "PREFIX=#{prefix}", "install"
  end
end
