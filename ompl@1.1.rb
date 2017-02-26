class OmplAT11 < Formula
  desc "Open Motion Planning Library consists of many motion planning algorithms"
  homepage "http://ompl.kavrakilab.org"
  url "https://codeload.github.com/lloydc99/ompl/zip/1.1.1"
  sha256 "a1f26891e6d80d2ffd46fabccca8e20e2d418c890ddc44117badfd2e0ade6d2a"

#  bottle do
#    sha256 "4a90bb34ebda949327b8873faf73cebc22b2de9e603b0f0b8fbc023935cb46f2" => :sierra
#    sha256 "5f29d3dc453e5f1d294333d250fed884b4a38fa91f0bb1048a14eaa58774b709" => :el_capitan
#    sha256 "ee99c05b5f1084ded43e0cacf7bd3ca0a1d3046bf99c1d5faafd225db2fb3a61" => :yosemite
#    sha256 "ab89e5350fdf56e044503f363c0e36ab689e45ef4f38806cf66f214908720838" => :mavericks
#  end

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "eigen" => :optional
  depends_on "ode" => :optional
  depends_on "flann"
  depends_on "lz4"

  def install
    system "cmake", ".", "-DOMPL_BUILD_DEMOS=OFF", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <ompl/base/spaces/RealVectorBounds.h>
      #include <cassert>
      int main(int argc, char *argv[]) {
        ompl::base::RealVectorBounds bounds(3);
        bounds.setLow(0);
        bounds.setHigh(5);
        assert(bounds.getVolume() == 5 * 5 * 5);
      }
    EOS

    system ENV.cc, "test.cpp", "-L#{lib}", "-lompl", "-lstdc++", "-o", "test"
    system "./test"
  end
end
