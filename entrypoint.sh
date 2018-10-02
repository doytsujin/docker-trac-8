#!/bin/sh

#
# Sample entrypoint script for the Trac container.
# Basically, we make sure that our project has been initialized
# before we allow the container to start and turn over control
# to the Trac daemon.
#
# This setup is highly-opinionated; if you would like to
# configure your container differently, please use this as
# merely a guide and modify as you see fit.
#

DB=sqlite:db/trac.db
NAME="My Project"
ROOT=/srv/trac/project

# Create the project if it does not already exist.
# When creating, apply configuration options.
if test ! -d ${ROOT} ; then
    trac-admin ${ROOT} initenv "${NAME}" "${DB}"
    trac-admin ${ROOT} config set logging log_level INFO
    trac-admin ${ROOT} config set logging log_type file
    trac-admin ${ROOT} config set components tracopt.ticket.clone.* enabled
    trac-admin ${ROOT} config set components lightertheme.* enabled
    trac-admin ${ROOT} config set components mastertickets.api.* enabled
    # Requires applying changes to the database
    trac-admin ${ROOT} upgrade
    trac-admin ${ROOT} wiki upgrade
    trac-admin ${ROOT} config set components mastertickets.web_ui.* enabled
    trac-admin ${ROOT} config set components tracnav.* enabled
    trac-admin ${ROOT} config set components tracpygments.* enabled
    trac-admin ${ROOT} config set components tracstats.web_ui.* enabled
    trac-admin ${ROOT} config set components tractags.admin.* enabled
    trac-admin ${ROOT} config set components tractags.api.* enabled
    trac-admin ${ROOT} config set components tractags.db.* enabled
    # Requires applying changes to the database
    trac-admin ${ROOT} upgrade
    trac-admin ${ROOT} wiki upgrade
    trac-admin ${ROOT} config set components tractags.macros.* enabled
    trac-admin ${ROOT} config set components tractags.ticket.* enabled
    trac-admin ${ROOT} config set components tractags.web_ui.* enabled
    trac-admin ${ROOT} config set components tractags.wiki.* enabled
    trac-admin ${ROOT} config set components themeengine.admin.* enabled
    trac-admin ${ROOT} config set components themeengine.api.* enabled
    trac-admin ${ROOT} config set components themeengine.web_ui.* enabled
    trac-admin ${ROOT} config set components ticketgraph.ticketgraph.* enabled
    trac-admin ${ROOT} config set versioncontrol default_repository_type git
    # Remove sample data from the DB
    trac-admin ${ROOT} component remove component1
    trac-admin ${ROOT} component remove component2
    trac-admin ${ROOT} milestone remove milestone1
    trac-admin ${ROOT} milestone remove milestone2
    trac-admin ${ROOT} milestone remove milestone3
    trac-admin ${ROOT} milestone remove milestone4
    trac-admin ${ROOT} version remove 1.0
    trac-admin ${ROOT} version remove 2.0
    # Make sure admin user has administrative rights.
    trac-admin ${ROOT} permission add admin TRAC_ADMIN
fi

# Kick off the Trac daemon to run the container.
exec /usr/local/bin/tracd $@
