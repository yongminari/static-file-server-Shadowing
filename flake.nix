{
  description = "C++ Project with Boost on Nix (Clang + Zsh)";

  # Inputs: Sources for packages
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # Development environment configuration
        devShells.default = pkgs.mkShell.override { stdenv = pkgs.clangStdenv; } {
          # Build tools (Clang, CMake, Debugger, Shell)
          nativeBuildInputs = with pkgs; [
            cmake       # Build system
            gdb         # Debugger
            git         # Version control system
            zsh         # Requested shell
          ];

          # Libraries to link against (Boost)
          buildInputs = with pkgs; [
            boost
          ];

          # Shell hook to verify environment and hint about zsh
          shellHook = ''
            echo "Welcome to the Clang + Boost development environment!"
            echo "Compiler: $CXX $(${pkgs.clangStdenv.cc}/bin/clang++ --version | head -n 1)"

            # Automatically switch to Zsh
            export SHELL="${pkgs.zsh}/bin/zsh"
            exec "${pkgs.zsh}/bin/zsh"
          '';
        };
      }
    );
}
