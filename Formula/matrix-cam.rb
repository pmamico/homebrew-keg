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
    if OS.mac? && Hardware::CPU.arm?
      url "https://files.pythonhosted.org/packages/75/5b/ca6c8bd14007e5ca171c7c03102d17b4f4e0ceb53957e8c44343a9546dcc/numpy-1.26.4-cp312-cp312-macosx_11_0_arm64.whl"
      sha256 "03a8c78d01d9781b28a6989f6fa1bb2c4f2d51201cf99d3dd875df6fbd96b23b"
    elsif OS.mac? && Hardware::CPU.intel?
      url "https://files.pythonhosted.org/packages/95/12/8f2020a8e8b8383ac0177dc9570aad031a3beb12e38847f7129bacd96228/numpy-1.26.4-cp312-cp312-macosx_10_9_x86_64.whl"
      sha256 "b3ce300f3644fb06443ee2222c2201dd3a89ea6040541412b8fa189341847218"
    elsif Hardware::CPU.arm?
      url "https://files.pythonhosted.org/packages/79/f8/97f10e6755e2a7d027ca783f63044d5b1bc1ae7acb12afe6a9b4286eac17/numpy-1.26.4-cp312-cp312-manylinux_2_17_aarch64.manylinux2014_aarch64.whl"
      sha256 "9fad7dcb1aac3c7f0584a5a8133e3a43eeb2fe127f47e3632d43d677c66c102b"
    else
      url "https://files.pythonhosted.org/packages/0f/50/de23fde84e45f5c4fda2488c759b69990fd4512387a8632860f3ac9cd225/numpy-1.26.4-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
      sha256 "675d61ffbfa78604709862923189bad94014bef562cc35cf61d3a07bba02a7ed"
    end
  end

  resource "opencv-python" do
    if OS.mac? && Hardware::CPU.arm?
      url "https://files.pythonhosted.org/packages/77/df/b56175c3fb5bc058774bdcf35f5a71cf9c3c5b909f98a1c688eb71cd3b1f/opencv_python-4.9.0.80-cp37-abi3-macosx_11_0_arm64.whl"
      sha256 "71dfb9555ccccdd77305fc3dcca5897fbf0cf28b297c51ee55e079c065d812a3"
    elsif OS.mac? && Hardware::CPU.intel?
      url "https://files.pythonhosted.org/packages/35/69/b657974ddcbba54d59d7d62b01e60a8b815e35f415b996e4d355be0ac7b4/opencv_python-4.9.0.80-cp37-abi3-macosx_10_16_x86_64.whl"
      sha256 "7e5f7aa4486651a6ebfa8ed4b594b65bd2d2f41beeb4241a3e4b1b85acbbbadb"
    elsif Hardware::CPU.arm?
      url "https://files.pythonhosted.org/packages/52/00/2adf376707c7965bb4569f28f73fafe303c404d01047b10e3b52761be086/opencv_python-4.9.0.80-cp37-abi3-manylinux_2_17_aarch64.manylinux2014_aarch64.whl"
      sha256 "7b34a52e9da36dda8c151c6394aed602e4b17fa041df0b9f5b93ae10b0fcca2a"
    else
      url "https://files.pythonhosted.org/packages/d9/64/7fdfb9386511cd6805451e012c537073a79a958a58795c4e602e538c388c/opencv_python-4.9.0.80-cp37-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
      sha256 "e4088cab82b66a3b37ffc452976b14a3c599269c247895ae9ceb4066d8188a57"
    end
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
