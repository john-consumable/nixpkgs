{ lib
, buildPythonPackage
, fetchPypi
, traitlets
, jupyter_core
, pyzmq
, python-dateutil
, isPyPy
, py
, tornado
}:

buildPythonPackage rec {
  pname = "jupyter_client";
  version = "7.0.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "48822a93d9d75daa5fde235c35cf7a92fc979384735962501d4eb60b197fb43a";
  };

  propagatedBuildInputs = [
    traitlets
    jupyter_core
    pyzmq
    python-dateutil
    tornado
  ] ++ lib.optional isPyPy py;

  # Circular dependency with ipykernel
  doCheck = false;

  meta = {
    description = "Jupyter protocol implementation and client libraries";
    homepage = "https://jupyter.org/";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ fridh ];
  };
}
