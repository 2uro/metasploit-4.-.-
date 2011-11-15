#!/bin/sh

# Follow links from wherever we were called from (probably /usr/local/bin/)
# back to the install directory.
export LINK=$(which "$0")
export NAME=$(basename "$0")
while [ -L "$LINK" ]; do
	LAST=$LINK
	LINK="$(readlink "$LINK")"
	if [ ! -L "$LINK" ]; then
		break
	fi
done

BASE=$(dirname "$LAST")
BASE=$(dirname "$BASE")
export BASE

# Autogen'd
. ${BASE}/scripts/setenv.sh

export MSF_DATABASE_CONFIG=${BASE}/config/database.yml

# Check for ruby scripts such as msfconsole directly to avoid having to add
# msf3 to the path.
if [ -f "${BASE}/msf3/${NAME}" ]; then
	exec ${BASE}/msf3/${NAME} "$@"
fi

exec ${NAME} "$@"

