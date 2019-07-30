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

def stopapi():
    run('systemctl stop rbd-target-api')

def startapi():
    run('systemctl start rbd-target-api')

def gwcli():
    run('gwcli ls')

def targetcli():
    run('targetcli ls')
