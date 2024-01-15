{ config, pkgs, lib, ... }:
let
  pyPkgs = ppkgs: with ppkgs; [
    ipython
    requests
    tkinter
    pyperclip

    pip
    yapf

    numpy
  ];
  commonPkgs = import ./common_packages.nix;
in
{
  environment.systemPackages = with pkgs; ((commonPkgs pkgs) ++ [
    man-pages # linux man pages for nixOS installs
    man-pages-posix # posix man pages for nixOS installs
    dtach # tmux's persistent sessions w/o the multiplexing window manager we only use via iterm2integration
    (python3.withPackages pyPkgs)
  ]);

  nix.settings = lib.mkMerge [
    (lib.mkIf pkgs.stdenv.isLinux {
      plugin-files = "${pkgs.nix-doc}/lib/libnix_doc_plugin.so";
    })
    (lib.mkIf pkgs.stdenv.isDarwin {
      plugin-files = "${pkgs.nix-doc}/lib/libnix_doc_plugin.dylib";
    })
    {
      # nix-direnv
      keep-outputs = true;
      keep-derivations = true;
    }
  ];

}
