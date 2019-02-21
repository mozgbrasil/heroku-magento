import "querystring@1.3.0"

build() {
  date > build-time.txt
}

handler() {
  local path
  local query

  path="$(jq -r '.path' < "$REQUEST")"
  query="$(querystring "$path")"

  echo ""
  echo "Querystring is: $query"
  echo ""

  echo ""
  echo "Build time:   $(cat build-time.txt)"
  echo "Current time: $(date)"
  echo ""

  echo ""
  echo "$ pwd && ls -lah"
  pwd && ls -lah
  echo ""
  echo "$ cd .. && pwd && ls -lah && composer update"
  cd .. && ls -lah && composer update
  echo ""


  echo "$ compgen -A function -abck"
  compgen -A function -abck

}
