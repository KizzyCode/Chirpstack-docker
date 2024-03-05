#!/bin/bash
set -euo pipefail

# Initialize postgres with a predefined database export if necessary
if ! test -f /var/postgres/PG_VERSION; then
    echo "*> Initializing database..."
    tar --directory=/ --extract --file=/var/postgres-init.tar.gz
fi

# Repair postgres permissions
chown -R postgres /var/postgres

# Become supervisord
exec supervisord -c /etc/supervisord.conf
