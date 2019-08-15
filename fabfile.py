#!/usr/bin/env python
#coding=utf-8

from fabric.api import *
from fabric.contrib.files import append
import time
import time
import os
import json
import copy
import pdb

env.hosts = ["oceanstore-wuxingyi-node-241", "oceanstore-wuxingyi-node-242", "oceanstore-wuxingyi-node-245", "oceanstore-wuxingyi-node-246"]

def pwd():
    run('pwd')

def trunc():
    run('truncate -s 0 /var/log/rbd-target-api/rbd-target-api.log')

def startapi():
    run('systemctl start tcmu-runner')
    run('systemctl start rbd-target-api')

def stopapi():
    run('systemctl reset-failed rbd-target-api.service')
    run('systemctl stop rbd-target-api')
    run('systemctl stop tcmu-runner')

def clear():
    run('targetctl clear')

def restartapi():
    run('systemctl restart rbd-target-api')

def gwcli():
    run('gwcli ls')

def targetcli():
    run('targetcli ls')

def ipmi():
    run('systemctl disable nfs-ganesha')
    run('systemctl disable smb')
    run('systemctl stop nfs-ganesha')
    run('systemctl stop smb')
