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
          # Build tools (Clang, CMake, Debugger, bear)
          nativeBuildInputs = with pkgs; [
            cmake       # Build system
            ninja       # High-performance build tool
            gdb         # Debugger
            git         # Version control system
            bear        # Tool to generate compile_commands.json (if not using cmake)
            (writeShellScriptBin "clangd" ''
              # Use the current C++ compiler from the environment as the query driver
              # This ensures clangd can find the correct Nix store paths for headers
              exec ${clang-tools}/bin/clangd --query-driver="$(command -v $CXX)" "$@"
            '')
          ];

          # Libraries to link against (Boost, GTest)
          buildInputs = with pkgs; [
            boost
            gtest
          ];

          # Environment variables setup
          CC = "clang";
          CXX = "clang++";

          # Shell hook to verify environment
          shellHook = ''
            echo "Welcome to the Clang + Boost development environment!"
            echo "Compiler: $CXX $(${pkgs.clangStdenv.cc}/bin/clang++ --version | head -n 1)"
            
            # Automatically create build directory and generate compile_commands.json if it doesn't exist
            if [ ! -f build/compile_commands.json ]; then
              echo "Generating compile_commands.json..."
              mkdir -p build && (cd build && cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON > /dev/null)
            fi
            
            # Symlink compile_commands.json to the root for better LSP support
            if [ ! -f compile_commands.json ]; then
              ln -sf build/compile_commands.json .
            fi
            
            echo "Environment ready for nvim + clangd."
          '';
        };
      }
    );
}
