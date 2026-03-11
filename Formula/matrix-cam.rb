require "language/python"

class MatrixCam < Formula
  include Language::Python::Virtualenv

  desc "Curses-based ASCII camera viewer for macOS terminals"
  homepage "https://github.com/pmamico/matrix-cam"
  url "https://github.com/pmamico/matrix-cam/archive/97772c40b98808c434a1b5ae178b75c6fb30ec06.tar.gz"
  sha256 "c482e752d90fba74daf63525007b3fcb8d84a85d74a08bfc8e5997834d9cce32"
  license :cannot_represent
  version "0.1.1"

  head "https://github.com/pmamico/matrix-cam.git", branch: "main"

  depends_on "python@3.11"

  def install
    python = Formula["python@3.11"].opt_bin/"python3.11"
    venv = virtualenv_create(libexec, python)

    ENV["PIP_ONLY_BINARY"] = "numpy,opencv-python"

    venv.pip_install "opencv-python"
    venv.pip_install_and_link buildpath
  end

  test do
    assert_match "matrix-cam", shell_output("#{bin}/matrix-cam --help")
  end
end
