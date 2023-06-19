BASEDIR=$(realpath "$(dirname "$0")")

for file in ${BASEDIR}/*; do
  if [[ $file != *"fish"* && $file != *"_aliasindex_bash"* ]]; then
    source $file
  fi
done
