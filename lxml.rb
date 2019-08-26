class Lxml < Formula
  desc "mature binding for libxml2 and libxslt libraries using the ElementTree API"
  homepage "http://lxml.de/"
  url "https://files.pythonhosted.org/packages/c4/43/3f1e7d742e2a7925be180b6af5e0f67d38de2f37560365ac1a0b9a04c015/lxml-4.4.1.tar.gz"
  #sha256 "9c74ca28a7f0c30dca8872281b3c47705e21217c8bc63912d95c9e2a7cac6bdf"

  #bottle do
  #  root_url "https://github.com/danielbair/homebrew-tap/releases/download/bottles/"
  #  cellar :any_skip_relocation
  #  rebuild 1
  #  sha256 "6f7ba8399b2565ae7fce6dc4e537a27d5d6dfa26145f0d2b25f387ea64b41e7c" => :high_sierra
  #end

  depends_on "python" => :recommended
  depends_on "python2" => :optional

  def install
    Language::Python.each_python(build) do |python, version|
      dest_path = lib/"python#{version}/site-packages"
      dest_path.mkpath
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  def caveats
    if build.with?("python") && !Formula["python"].installed?
      homebrew_site_packages = Language::Python.homebrew_site_packages
      user_site_packages = Language::Python.user_site_packages "python"
      <<-EOS.undent
        If you use system python (that comes - depending on the OS X version -
        with older versions of numpy, scipy and matplotlib), you may need to
        ensure that the brewed packages come earlier in Python's sys.path with:
          mkdir -p #{user_site_packages}
          echo 'import sys; sys.path.insert(1, "#{homebrew_site_packages}")' >> #{user_site_packages}/homebrew.pth
      EOS
    end
  end

  test do
    # printf result
  end
end
