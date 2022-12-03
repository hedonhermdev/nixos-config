# Binary cache

{
  environment.variables = {
    MARS_CACHIX_TOKEN_PATH = "/proj/redshift-PG0/mars-research.cachix.org.token";
  };

  nix.binaryCaches = [
    "https://mars-research.cachix.org"
  ];
  nix.binaryCachePublicKeys = [
    "mars-research.cachix.org-1:9UnGa9aK3fIGNdQI7DDLKf4t7eSWhec+NyGeAS6+A3U="
  ];
}
