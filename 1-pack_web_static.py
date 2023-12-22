#!/usr/bin/python3
"""
Fabric script to genereate tgz archive
execute: fab -f 1-pack_web_static.py do_pack
"""

from datetime import datetime
from fabric.api import *
import os


def do_pack():
    """
    making an archive on web_static folder
    """

    time = datetime.now()
    archive = 'web_static_' + time.strftime("%Y%m%d%H%M%S") + '.' + 'tgz'

    print("Packing web_static to versions/{}".format(archive))

    with lcd(os.path.dirname(os.path.abspath(__file__))):
        local('mkdir -p versions &> /dev/null')
        create = local('tar -cvzf versions/{} --directory=web_static . &> /dev/null'.format(archive))
        if create is not None:

            print("web_static packed: versions/{} -> {}Bytes".format(archive, os.path.getsize('versions/' + archive)))
            return archive
        else:
            return None
