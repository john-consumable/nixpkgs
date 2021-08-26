{ lib, buildPythonPackage, fetchPypi, isPy3k
, pytest, pytest-runner, pbr, glibcLocales , pytest-cov
, requests, requests_oauthlib, requests-toolbelt, defusedxml
, ipython
}:

buildPythonPackage rec {
  pname = "jira";
  version = "3.0.1";

  PBR_VERSION = version;

  src = fetchPypi {
    inherit pname version;
    sha256 = "5bd8f4199632bf91fcfb4ba25ad2226991d403923b75f7cd2b051b4571492831";
  };

  buildInputs = [ glibcLocales pytest pytest-cov pytest-runner pbr ];
  propagatedBuildInputs = [ requests requests_oauthlib requests-toolbelt defusedxml pbr ipython ];

  # impure tests because of connectivity attempts to jira servers
  doCheck = false;

  patches = [ ./sphinx-fix.patch ];

  LC_ALL = "en_US.utf8";

  disabled = !isPy3k;

  meta = with lib; {
    description = "This library eases the use of the JIRA REST API from Python.";
    license = licenses.bsd2;
    maintainers = with maintainers; [ globin ];
  };
}
