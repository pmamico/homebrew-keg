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

  resource "opencv-python" do
    on_macos do
      on_arm do
        url "https://files.pythonhosted.org/packages/fc/6f/5a28fef4c4a382be06afe3938c64cc168223016fa520c5abaf37e8862aa5/opencv_python-4.13.0.92-cp37-abi3-macosx_13_0_arm64.whl"
        sha256 "caf60c071ec391ba51ed00a4a920f996d0b64e3e46068aac1f646b5de0326a19"
      end

      on_intel do
        url "https://files.pythonhosted.org/packages/08/ac/6c98c44c650b8114a0fb901691351cfb3956d502e8e9b5cd27f4ee7fbf2f/opencv_python-4.13.0.92-cp37-abi3-macosx_14_0_x86_64.whl"
        sha256 "5868a8c028a0b37561579bfb8ac1875babdc69546d236249fff296a8c010ccf9"
      end
    end
  end

  def install
    python = Formula["python@3.11"].opt_bin/"python3.11"
    venv = virtualenv_create(libexec, python)

    ENV["PIP_ONLY_BINARY"] = "numpy,opencv-python"

    opencv = resource("opencv-python")
    opencv.fetch
    wheel_path = Pathname.new(opencv.cached_download)
    wheel_copy = buildpath/File.basename(opencv.url)
    cp wheel_path, wheel_copy
    venv.pip_install wheel_copy
    venv.pip_install_and_link buildpath
  end

  test do
    assert_match "matrix-cam", shell_output("#{bin}/matrix-cam --help")
  end
end
