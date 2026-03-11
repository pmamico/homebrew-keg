require "language/python"

class MatrixCam < Formula
  include Language::Python::Virtualenv

  desc "Matrix-style ASCII camera viewer for macOS terminals"
  homepage "https://github.com/pmamico/matrix-cam"
  url "https://github.com/pmamico/matrix-cam.git",
      revision: "1be3ac12bc4835c42c5d0375c205c7b459a32fc9"
  version "0.1.0"
  license ""
  head "https://github.com/pmamico/matrix-cam.git", branch: "main"

  depends_on "python@3.12"

  resource "numpy" do
    url "https://files.pythonhosted.org/packages/65/6e/09db70a523a96d25e115e71cc56a6f9031e7b8cd166c1ac8438307c14058/numpy-1.26.4.tar.gz"
    sha256 "2a02aba9ed12e4ac4eb3ea9421c420301a0c6460d9830d74a9df87efa4912010"
  end

  resource "opencv-python" do
    url "https://files.pythonhosted.org/packages/25/72/da7c69a3542071bf1e8f65336721b8b2659194425438d988f79bc14ed9cc/opencv-python-4.9.0.80.tar.gz"
    sha256 "1a9f0e6267de3a1a1db0c54213d022c7c8b5b9ca4b580e80bdc58516c922c9e1"
  end

  def install
    python = Formula["python@3.12"].opt_bin/"python3.12"
    venv = virtualenv_create(libexec, python)

    venv.pip_install resource("numpy")
    venv.pip_install resource("opencv-python")
    venv.pip_install_and_link buildpath
  end

  test do
    system bin/"matrix-cam", "--help"
  end
end
