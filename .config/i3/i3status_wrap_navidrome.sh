. "$HOME/.config/i3/navidrome.env"

now_playing() {
  RESULT=$(curl -s --max-time 3 -G "$NAVIDROME_API/getNowPlaying.view" \
      --data-urlencode "u=$NAVIDROME_USER" \
      --data-urlencode "p=$NAVIDROME_PASS" \
      --data-urlencode "v=1.16.1" \
      --data-urlencode "c=i3status" \
      --data-urlencode "f=json" | \
      jq -r '.["subsonic-response"].nowPlaying.entry[0] // empty | "\(.artist) - \(.title)"' 2>/dev/null)

  if [ -z "$RESULT" ]; then
      echo " "
  else
      echo "$RESULT"
  fi
}

i3status | while :; do
  read -r line
  case $line in
      '{'*|'[')
          echo "$line"
          continue
          ;;
  esac

  NOWPLAYING=$(now_playing)

  prefix="${line#,}"
  if [ "$prefix" != "$line" ]; then comma=","; else comma=""; fi

  NEWLINE=$(echo "$prefix" | jq -c --arg text "$NOWPLAYING" \
      '[{"name":"navidrome","full_text":$text}] + .')

  echo "$comma$NEWLINE"
done
