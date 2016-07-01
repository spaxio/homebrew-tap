class Libespeak < Formula
  desc "Static library for the eSpeak text to speech, software speech synthesizer"
  homepage "http://espeak.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/espeak/espeak/espeak-1.48/espeak-1.48.04-source.zip"
  sha256 "bf9a17673adffcc28ff7ea18764f06136547e97bbd9edf2ec612f09b207f0659"

  depends_on "portaudio"
  depends_on "espeak"

  patch do
      url "https://github.com/danielbair/homebrew-tap/raw/master/libespeak/espeak-osx.patch"
      sha256 "58b769e7e7f6f3904e2eee221f733029681184b8da654eb211bf90120abcab6b"
  end

  def install
    #share.install "espeak-data"
    cd "src" do
      rm "portaudio.h"
      system "make", "libespeak.so", "DATADIR=#{share}/espeak-data", "PREFIX=#{prefix}"
      system "make", "libespeak.a", "DATADIR=#{share}/espeak-data", "PREFIX=#{prefix}"
      lib.install "libespeak.so.1.1.48" => "libespeak.so.1.1.48"
      lib.install "libespeak.so.1" => "libespeak.so.1"
      lib.install "libespeak.so" => "libespeak.so"
      lib.install "libespeak.a" => "libespeak.a"
    end
  end

end
