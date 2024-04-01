# shell.nix

{ pkgs ? import <nixpkgs> {
    config = {
      allowUnfree = true;
    };
  } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    terraform
  ];
  shellHook = ''
    # Run terraform init upon entering the shell
    terraform init
  '';
}

