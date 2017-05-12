#!/bin/sh

REMOTE=kfish

SOURCE=src/Main.elm
TARGET=target/elm.js

git push ${REMOTE} master
if [ -e ${TARGET} ]; then
	git add -f ${TARGET}
	git commit -m "Update ${TARGET}"
	git push --force ${REMOTE} HEAD:gh-pages
	git reset --hard HEAD^
else
	echo "Please build ${TARGET} with:"
        echo
	echo "    elm-make ${SOURCE} --output ${TARGET}"
        echo
fi
