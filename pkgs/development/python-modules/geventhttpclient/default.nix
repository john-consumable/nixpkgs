{ lib
, buildPythonPackage
, fetchPypi
, pytest
, gevent
, certifi
, six
, backports_ssl_match_hostname
, pythonOlder
}:

buildPythonPackage rec {
  pname = "geventhttpclient";
  version = "1.5.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "4aead64253d2769a6528544f7812ce8d71ae13551d079f2d9a3533d72818f2e0";
  };

  buildInputs = [ pytest ];
  propagatedBuildInputs = [ gevent certifi six ]
    ++ lib.optionals (pythonOlder "3.7") [ backports_ssl_match_hostname ];

  # Several tests fail that require network
  doCheck = false;
  checkPhase = ''
    py.test $out
  '';

  meta = with lib; {
    homepage = "https://github.com/gwik/geventhttpclient";
    description = "HTTP client library for gevent";
    license = licenses.mit;
    maintainers = with maintainers; [ koral ];
  };

}
