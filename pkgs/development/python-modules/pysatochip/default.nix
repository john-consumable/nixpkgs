{ lib, buildPythonPackage, fetchPypi, pyscard, ecdsa, pyaes
, pythonOlder }:

buildPythonPackage rec {
  pname = "pysatochip";
  version = "0.12.3";
  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "24db358a65c0402c299c0c62efcfbbfc98e494181cd30d3996949ac667d5b4d4";
  };

  propagatedBuildInputs = [ pyscard ecdsa pyaes ];

  pythonImportsCheck = [ "pysatochip" ];

  meta = with lib; {
    description = "Simple python library to communicate with a Satochip hardware wallet";
    homepage = "https://github.com/Toporin/pysatochip";
    license = licenses.lgpl3Only;
    maintainers = with maintainers; [ oxalica ];
  };
}
