#!/bin/bash +e

url="https://cache.agilebits.com/dist/1P/op/pkg/v1.12.2/op_linux_amd64_v1.12.2.zip"
tmpdir="/tmp/1pass"
tmpzip="1pass.zip"
tmppath="$tmpdir/$tmpzip"
unzipdir="$tmpdir"
installdir="/usr/local/bin"
installfile="op"
installpath="$unzipdir/$installfile"

function errorCheck {
  sleep 3
  #echo "Errorcode: $1"
  if [ "$1" != 0 ]; then
    echo ""
    echo "Error [$1] encountered with \"$2\", exiting..."
    echo ""
    exit 1
  fi
}
function install1pass {
  curl "$url" --output "$tmppath" &
  wait "$!"
  errorCheck "$?" "curl"
  if [ -e "$tmppath" ]; then
    unzip "$tmppath" -d "$unzipdir" &
    wait "$!"
    errorCheck "$?" "unzip"
    sudo cp "$installpath" "$installdir/" &
    wait "$!"
    errorCheck "$?" "cp"
    if [ -e "$installpath" ]; then
      echo "Successfully installed 1password CLI Tool."
    else
      echo "ERROR: Binary file not found, assuming installation failed and previous error as not caught"
    fi
  else
    echo ""
  fi
}
function cleanup {
  if [ -d "$tmpdir" ]; then
    echo -n "Cleaning up temp files..."
    rm -r "$tmpdir"
    if [ -e "$tmpdir" ]; then
      echo "FAILED"
      echo "ERROR: Failed to remove temp dir \"$tmpdir\""
    else
      echo "DONE"
    fi
  else
    echo "Temp files not found, assuming already clean"
  fi
}
function uninstall1pass {
  if [ -e "$installpath" ]; then
    echo -n "Uninstalling 1password CLI tool..."
    sudo rm "$installpath"
    if [ -e "$installpath" ]; then
      echo "FAILED"
      echo "ERROR: Failed to remove binary file \"$installpath\""
    else
      echo "DONE"
    fi
  else
    echo "Binary file not found, assuming already uninstalled"
  fi
}
function initChecks {
  if [ -d "$tmpdir" ]; then
    echo "Temp dir found"
    install1pass
  else
    echo -n "Creating temp dir..."
    mkdir "$tmpdir"
    if [ -d "$tmpdir" ]; then
      echo "DONE"
      install1pass
    else
      echo "FAILED"
      echo "Error: failed to create tmpdir \"$tmpdir\""
      exit 1
    fi
  fi
}
function help {
  echo ""
  echo "$0"
  echo "========================================"
  echo "--install : Download the 1password CLI tool and install it"
  echo "--clean : Remove the temp files created during installation"
  echo "--uninstall : Uninstall the 1password CLI tool"
  echo ""
}

case $1 in
  '--install')
    cleanup
    initChecks
    ;;
  '--clean')
    cleanup
    ;;
  '--uninstall')
    uninstall1pass
    cleanup
    ;;
  *)
    help
    ;;
esac
