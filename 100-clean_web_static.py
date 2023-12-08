#!/usr/bin/python3
<<<<<<< HEAD
# Fabfile to delete out-of-date archives.
import os
from fabric.api import *

env.hosts = ["54.145.238.190", "34.205.65.202"]


def do_clean(number=0):
    """Delete out-of-date archives.
    Args:
        number (int): The number of archives to keep.
    If number is 0 or 1, keeps only the most recent archive. If
    number is 2, keeps the most and second-most recent archives,
    etc.
    """
    number = 1 if int(number) == 0 else int(number)

    archives = sorted(os.listdir("versions"))
    [archives.pop() for i in range(number)]
    with lcd("versions"):
        [local("rm ./{}".format(a)) for a in archives]

    with cd("/data/web_static/releases"):
        archives = run("ls -tr").split()
        archives = [a for a in archives if "web_static_" in a]
        [archives.pop() for i in range(number)]
        [run("rm -rf ./{}".format(a)) for a in archives]
=======
"""
    Fabric script that deletes out-of-date archives.
"""
from fabric.api import cd, env, lcd, local, run

env.hosts = ['35.229.40.200', '35.229.23.118']


def do_clean(number=0):
    """ Function that deletes outdated archives. """

    try:
        number = int(number)
        number >= 0

    except:
        return None

    number = 2 if number <= 1 else number + 1

    with lcd("./versions"):
        local('ls -t | tail -n +{} | xargs rm -rf'.format(number))
    with cd("/data/web_static/releases"):
        run('ls -t | tail -n +{} | xargs rm -rf'.format(number))
>>>>>>> 65edb161fde4681e45545a2fdd50ba5f5ae48df6
