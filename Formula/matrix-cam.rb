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

  resource "numpy" do
    on_macos do
      on_arm do
        url "https://files.pythonhosted.org/packages/b5/7c/c061f3de0630941073d2598dc271ac2f6cbcf5c83c74a5870fea07488333/numpy-2.4.3-cp311-cp311-macosx_11_0_arm64.whl"
        sha256 "8ba7b51e71c05aa1f9bc3641463cd82308eab40ce0d5c7e1fd4038cbf9938147"
      end

      on_intel do
        url "https://files.pythonhosted.org/packages/f9/51/5093a2df15c4dc19da3f79d1021e891f5dcf1d9d1db6ba38891d5590f3fe/numpy-2.4.3-cp311-cp311-macosx_10_9_x86_64.whl"
        sha256 "33b3bf58ee84b172c067f56aeadc7ee9ab6de69c5e800ab5b10295d54c581adb"
      end
    end
  end

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

    install_wheel_resource "numpy", venv
    install_wheel_resource "opencv-python", venv
    venv.pip_install_and_link buildpath
  end

  private

  def install_wheel_resource(name, venv)
    resource = self.resource(name)
    resource.fetch
    wheel_copy = buildpath/File.basename(resource.url)
    cp Pathname.new(resource.cached_download), wheel_copy
    venv.pip_install wheel_copy
  end

  test do
    assert_match "matrix-cam", shell_output("#{bin}/matrix-cam --help")
  end
end
