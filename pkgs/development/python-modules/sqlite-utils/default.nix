{ lib
, buildPythonPackage
, fetchPypi
, pythonOlder
, click
, click-default-group
, sqlite-fts4
, tabulate
, pytestCheckHook
, pytest-runner
, black
, hypothesis
, sqlite
}:

buildPythonPackage rec {
  pname = "sqlite-utils";
  version = "3.17";
  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "77acd202aa568a1f6888c5d8879f306bb3f8acedc82df0df98eb615caa491abb";
  };

  propagatedBuildInputs = [
    click
    click-default-group
    sqlite-fts4
    tabulate
  ];

  checkInputs = [
    pytestCheckHook
    pytest-runner
    black
    hypothesis
  ];

  meta = with lib; {
    description = "Python CLI utility and library for manipulating SQLite databases";
    homepage = "https://github.com/simonw/sqlite-utils";
    license = licenses.asl20;
    maintainers = with maintainers; [ meatcar ];
  };

}
