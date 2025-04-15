class Jssl < Formula
  desc "Resolve Java SSL issues like 'PKIX path building failed'"
  homepage "https://github.com/pmamico/jssl"
  url "https://github.com/pmamico/jssl.git", tag: "v2.2"
  license ""
  head "https://github.com/pmamico/jssl.git", branch: "main"

  def install
    bin.install "src/jssl"
  end

  def post_install
    ohai "ℹ️  Make sure JAVA_HOME is set up correctly before using jssl"
  end

  test do
    system "true"
  end
end
