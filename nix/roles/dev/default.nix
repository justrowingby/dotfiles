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
in
{
  environment.systemPackages = with pkgs; [
    git
    direnv

    gitAndTools.delta

    man-pages
    man-pages-posix

    dtach
    tmux
    gh
    fd
    gdb
    jq
    graphviz
    ctags
    moreutils
    git-lfs

    xxd

    p7zip
    unzip

    (python3.withPackages pyPkgs)

    git-credential-oauth
    git-absorb
    git-revise
    nix-direnv
    nix-doc
    nix-index
    nixpkgs-fmt
    nodePackages.bash-language-server
    rnix-lsp
    nixd
    rustfilt
    shellcheck
    typst-lsp
    typst
    diffoscope

    nix-output-monitor

    simple-http-server
  ];

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
