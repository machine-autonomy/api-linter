{
  description = "buf-plugin-google-api - Buf lint plugin wrapping the Google API Linter";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          buf-plugin-google-api = pkgs.buildGoModule {
            pname = "buf-plugin-google-api";
            version = "0.1.0";

            src = ./.;

            subPackages = [ "cmd/buf-plugin-google-api" ];

            vendorHash = "sha256-kd0F6H3/HByVdPHCz30FHg1dQNV/shA2sNMnXqIri3c=";

            env.CGO_ENABLED = "0";

            ldflags = [ "-s" "-w" ];

            meta = with pkgs.lib; {
              description = "Buf lint plugin wrapping the Google API Linter";
              homepage = "https://github.com/googleapis/api-linter";
              license = licenses.asl20;
              mainProgram = "buf-plugin-google-api";
            };
          };

          default = self.packages.${system}.buf-plugin-google-api;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go
            gopls
            buf
          ];
        };
      }
    );
}
