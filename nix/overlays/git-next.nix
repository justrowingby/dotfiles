final: prev: {
  git-next = prev.git.overrideAttrs (old: {
    version = "next";
    src = final.fetchFromGitHub {
      owner = "git";
      repo = "git";
      rev = "346d391aac0a243ed73bad8a0e30123f5381affe";
      hash = "sha256-0dLVdxfdpcCP1zK+YK19m7b5PAIPAT3W6BTkAhaGQyo=";
    };
    nativeBuildInputs = old.nativeBuildInputs ++ [ final.autoreconfHook ];
  });
}
