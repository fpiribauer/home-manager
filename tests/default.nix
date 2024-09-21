# Execute with nix eval .#tests
{ ... }@inputs:
let
  myutils = import ../myutils.nix inputs;
in
{
  colors = myutils.colors;
}
