# 1pass-CLI

A simple Script to install the 1password Password Manager CLI tool on *nix systems

NOTE: Currently pulls version 1.12.2 from 1passwords website, latest version as of October 22 2021. 
      Simply update the URL variable with the updated download URL as needed from here: https://app-updates.agilebits.com/product_history/CLI

====================================================================================

1pass-install.sh <command>

--install : Download the 1password CLI tool and install it

--clean : Remove the temp files created during installation

--uninstall : Uninstall the 1password CLI tool

====================================================================================

Run the command 'op signin <sign_in_address> <email_address> <secret_key>' to sign into your 1password account once installed
