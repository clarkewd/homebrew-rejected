class SblimSfcc < Formula
  version  "2.2.7"
  homepage 'https://sourceforge.net/projects/sblim/'
  url      'http://downloads.sourceforge.net/project/sblim/sblim-sfcc/sblim-sfcc-2.2.7.tar.bz2'
  sha1     '487f30a06fe599ca17340d2ecfd3c32644c96c67'
  depends_on :libtool
  depends_on :autoconf
  depends_on :automake
  depends_on "openssl"

  def install
    system "./configure","--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end

  def test


  # based on the test at
  test do
    (testpath/"test.xml").write <<-EOS.undent
      <?xml version="1.0" ?>
      <Hello>World</Hello>
    EOS
    (testpath/"test.cpp").write <<-EOS.undent
      #include <tinyxml.h>
      int main()
      {
        TiXmlDocument doc ("test.xml");
        doc.LoadFile();
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-ltinyxml", "-o", "test"
    system "./test"
  end


  end

end


