{ lib, stdenv
, buildPythonPackage
, fetchPypi
, pytest
, glibcLocales
, libarchive
, mock
}:

buildPythonPackage rec {
  pname = "libarchive-c";
  version = "3.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "618a7ecfbfb58ca15e11e3138d4a636498da3b6bc212811af158298530fbb87e";
  };

  checkInputs = [ mock pytest glibcLocales ];

  LC_ALL="en_US.UTF-8";

  postPatch = ''
    substituteInPlace libarchive/ffi.py --replace \
      "find_library('archive')" "'${libarchive.lib}/lib/libarchive${stdenv.hostPlatform.extensions.sharedLibrary}'"
  '';

  checkPhase = ''
    py.test tests -k 'not test_check_archiveentry_with_unicode_entries_and_name_zip and not test_check_archiveentry_using_python_testtar'
  '';

  meta = with lib; {
    homepage = "https://github.com/Changaco/python-libarchive-c";
    description = "Python interface to libarchive";
    license = licenses.cc0;
  };

}
