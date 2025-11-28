#!/usr/bin/env bash

echo "<WARNING msg=\"your kitty is unconfigured\">"
echo "  <p pls re-link $HOME/.config/kitty/kittyshell to your preferred shell for kitty to launch with by default. />"
echo "  <p suggested examples include $HOME/.nix-profile/bin/fish , /usr/local/bin/fish , /usr/bin/bash , .... />"
echo "  <p unfortunately this manual configuration is necessary for portability due to macOS GUI invocations of kitty not having fish in their PATH />"
echo ""
echo "  <p YOU WILL NOW BE DUMPED INTO SH. GOOD LUCK. />"
echo "</WARNING>"
echo ""
exit 1
