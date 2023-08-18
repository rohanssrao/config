function qq
  set TMPFILE (mktemp)
  trap 'rm -f $TMPFILE' EXIT

  if github-copilot-cli what-the-shell $argv --shellout $TMPFILE
      if test -e $TMPFILE
          set FIXED_CMD (cat $TMPFILE)
          eval $FIXED_CMD
      else
          echo "Apologies! Extracting command failed"
      end
  else
      return 1
  end
end
