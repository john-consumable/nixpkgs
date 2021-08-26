{ lib, buildPythonPackage, fetchPypi, toml }:

buildPythonPackage rec {
  pname = "setuptools_scm";
  version = "6.1.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0e9fc7ca3f15657941d352ee2be5901d1606294577213e0f4c26cef20978e819";
  };

  propagatedBuildInputs = [ toml ];

  # Requires pytest, circular dependency
  doCheck = false;
  pythonImportsCheck = [ "setuptools_scm" ];

  meta = with lib; {
    homepage = "https://github.com/pypa/setuptools_scm/";
    description = "Handles managing your python package versions in scm metadata";
    license = licenses.mit;
    maintainers = with maintainers; [ SuperSandro2000 ];
  };
}
