#!/usr/bin/env python
#-*- coding: utf-8  mode: python-*-
#
# Written by Florian Diesch <devel@florian-diesch.de>
#
# Updates may be available at
# <http://www.florian-diesch.de/software/python-scripts/>
#
# This script is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# You are free to do with it what ever you want.
#


import sys, os, os.path, gtk


data = {
  "mime_type": 'text/plain',
  "app_name": 'xdg-open',
  "app_exec": 'xdg-open %F',
}

if len(sys.argv) < 2:
    print "Adds a given URI to the list of recently used files"
    print "  Syntax:  addtorecent URI [MIME-type] [app] [cmd]"
    print "  Defaults:   MIME-type: %(mime_type)s \n" \
          "              app:       %(app_name)s\n" \
          "              cmd:       %(app_exec)s\n"%data

    sys.exit(1)

newuri = sys.argv[1]
if not newuri.startswith('file://'):
    if not newuri.startswith('/'):
        newuri = os.path.join(os.getcwd(), newuri)
    newuri = 'file://%s'%newuri

try:
    data['mime-type'] = sys.argv[2]
    data['app_name'] = sys.argv[3]
    data['app_exec'] = sys.argv[4]
except IndexError:
    pass


manager = gtk.recent_manager_get_default()
manager.add_full(newuri, data)
