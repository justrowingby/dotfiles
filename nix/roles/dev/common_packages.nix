pkgs:
with pkgs; [
  ## software "currently" in use

  ffmpeg # it's ffmpeg.
  gnutar # the tar that ships on macOS is so unbelievably unusable, use this instead
  yt-dlp # the latterday fork of deceased youtube-dl
  git # you always need git on the CLI
  git-credential-oauth # for OAuthing to common remote locations
  gh # for github actions
  tmux # screen but with nice iterm2 integration on macOS
  unzip # for unzipping.
  /* notably lacking is python3.
    you'll want to be able to get a repl on any system,
    but the way we'd do this with nix (specify all possible packages in advance)
    isn't ideal for meshing w normal installation patterns */


  ## aspirationally included software (software we haven't like, actually used yet)

  moreutils
  rustup # rust toolchain version manager so that we can use whichever required version of rustc to compile other ppl's rust code whose builds aren't managed by nix
  highlight # for rendering code into portable rendered formats like html,pdf,svg
  direnv # gets you pyenv, jenv, etc functionality on the CLI
  nix-direnv # a plugin for direnv which makes it do nix better
  gitAndTools.delta # gets you better git diffing on the CLI, specified by git config
  git-revise # gets you a better workflow for common amend/rebase actions like updating, splitting, rearranging
  git-absorb # for creating a single new commit that automatically rebases to amend/fix up an older commit. useful for doing --amend but on any commit, not just HEAD, w/o going through manual rebase hell
  git-lfs # for versioning large files
  jq # like sed but for JSON data
  fd # find replacement written in rust
  ctags # for indexing source code
  nix-index # you have a regex pattern for a file? you think that file exists in the build of *some* package(s) in nixpkgs but don't have a clue which ones / what their name is? surely you would not regret simply grepping the entire set of files that exists in all of the derivations in nixpkgs
  nix-doc # ctags for nix. also searchable  nix docs.
  nix-output-monitor # pipe nix-build into nom and it creates nice graph visualization of your build progress. wiggles has contributed to this.
  shellcheck # run this on a bash program and it'll tell you what your bash crimes are. like really bully you fr not knowing how to write bash.
  rustfilt # if you get bad rust stacktraces that are "mangled", we're told this helps
  # diffoscope # hardcore two file diff software, whether the files are tarballs, iso images, directories, whatever. will recursively figure out as much diffable structure as possible.
  typst # the typst compiler, for writing markdown-ish w LaTeX-ish in it
  typst-lsp
  nodePackages.bash-language-server # a bash language server
  rnix-lsp # a nix lang server that we've seen be jank in kate on nixOS VM
  nixd # a nix lang server that we're not seen be jank in kate on nixOS VM
  nixpkgs-fmt
  graphviz # for making autogen'd graphs like we've seen in java applets showing data relations in knowledge bases
  p7zip # for when you want lz or whatever
  simple-http-server # minimal http server, written in rust, we're told it's dependable enough to use in demos (unlike the typical python one)

  ## aspirationally included software (software we've used but haven't touched in at least a year)

  # gdb # it's gdb.
  racket-minimal # we might want to grab  a racket repl sometimes
  xxd # for dumping raw hex or bytes, and probably C crimes
]
