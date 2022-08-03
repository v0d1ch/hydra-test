{
  pkgs ?
    import ( # nixpkgs 22.05
      builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/ce6aa13369b667ac2542593170993504932eb836.tar.gz"
    ) {},
  haskellCompiler ? "ghc8107"
}:
with pkgs; let
  haskellEnv = with haskell.packages.${haskellCompiler}; [
    ghc
    cabal-install
    (fourmolu_0_6_0_0.override {
      Cabal = Cabal_3_6_3_0;
      ghc-lib-parser = ghc-lib-parser_9_2_2_20220307;
    })
    hlint
    haskell-language-server
  ];
  libraries = [
    zlib
  ];
in
  mkShell {
    name = "hydra-test";
    buildInputs = haskellEnv ++ libraries;
  }
