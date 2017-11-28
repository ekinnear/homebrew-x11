class I3status < Formula
  desc "Status bar for i3"
  homepage "http://i3wm.org/i3status"
  head "https://github.com/i3/i3status.git"

  stable do
    url "http://i3wm.org/i3status/i3status-2.10.tar.bz2"
    sha256 "daf5d07611b054a43da1a3d28850b05e2dbdbd6d25fd5e25ede98bb1b66e2791"

    # NOTE: Remove the patches on the next release, since they have been reported and merged upstream
    # Add ifdef to compile wireless_info on Mac
    patch do
      url "https://github.com/i3/i3status/commit/0a2d4d8a04dcfa71f9e8cecb2bd2772df989b228.patch"
      sha256 "f183f05f9295d420a13dee0afbb7a9781216da13c88c8568e49dbfdadf958b64"
    end
  end

  bottle do
    cellar :any
    sha256 "3a930293246d899fb3078cc123af7870b82e7c6a2b2c7b3a407c961eb6a94b3e" => :el_capitan
    sha256 "ecbb9dab95edf2b228170e5ea520f6749170be8f71cd7746e0efb40475e2d134" => :yosemite
    sha256 "147a259d6e44000606874c284df121e1e0939bb74a9dcdb952128eca4bc901fb" => :mavericks
  end

  depends_on :x11
  depends_on "yajl"
  depends_on "confuse"
  depends_on "pulseaudio"
  depends_on "asciidoc" => :build
  depends_on "i3" => :recommended

  def install
    system "make", "A2X_FLAGS=--no-xmllint"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    result = shell_output("#{bin}/i3status -v")
    result.force_encoding("UTF-8") if result.respond_to?(:force_encoding)
    assert_match version.to_s, result
  end
end
