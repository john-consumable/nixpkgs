{ lib, buildPythonPackage, fetchPypi, toml, tomli }:

buildPythonPackage rec {
  pname = "setuptools-scm";
  version = "6.1.0";

  src = fetchPypi {
    pname = "setuptools_scm";
    inherit version;
    sha256 = "0e9fc7ca3f15657941d352ee2be5901d1606294577213e0f4c26cef20978e819";
  };

  # TODO: figure out why both toml and tomli are needed when only tomli is listed in setuptools-scm
  # if not both are listed some packages like zipp silently fallback to a 0.0.0 version number and break version pins in other packages
  propagatedBuildInputs = [ toml tomli ];

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
