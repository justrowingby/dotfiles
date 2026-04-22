# Workaround for aarch64-darwin codesigning bug (nixpkgs#208951 / #507531):
# fish binaries from the binary cache occasionally have invalid ad-hoc
# signatures on Apple Silicon. Forcing a local rebuild ensures codesigning
# is applied on this machine with a valid signature.
_final: prev: {
  fish = prev.fish.overrideAttrs (_old: {
    # Bust the cache key so fish is always built locally rather than
    # substituted from the binary cache where the signature may be stale.
    NIX_FORCE_LOCAL_REBUILD = "darwin-codesign-fix";
  });
}
