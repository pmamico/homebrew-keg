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

  depends_on "numpy"
  depends_on "opencv"
  depends_on "python@3.12"

  def install
    python = Formula["python@3.12"].opt_bin/"python3.12"
    venv = virtualenv_create(libexec, python)
    ENV["PIP_NO_DEPS"] = "1"
    venv.pip_install_and_link buildpath

    site_packages = venv.site_packages
    python_site_suffix = Language::Python.site_packages("python3.12")

    numpy_site = Formula["numpy"].opt_prefix/python_site_suffix
    (site_packages/"homebrew-numpy.pth").write "#{numpy_site}\n"

    opencv_site = Formula["opencv"].opt_prefix/python_site_suffix
    (site_packages/"homebrew-opencv.pth").write "#{opencv_site}\n"
  end

  test do
    system bin/"matrix-cam", "--help"
  end
end
