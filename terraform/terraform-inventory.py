#!/usr/bin/env python
# -*- encoding: utf-8 -*-
##
# Copyright 2019 FIWARE Foundation, e.V.
# All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
##

import subprocess
import os
import shutil
import sys


def get_dynamic_inventory():
    cmd = ['/usr/local/bin/terraform', 'output']
    working_directory = os.getcwd()
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, cwd=working_directory)

    output_fixed = '''# Contains the web servers at backend network\n'''

    output_dynamic_name_server = "{}"

    output_dynamic_information_server = "{}    ansible_host={}    ansible_user=ubuntu    ansible_connection=ssh"

    output_main_1 = ''
    output_main_2 = ''

    output_private_1 = ''
    output_private_2 = ''

    output_main = '''[main]'''
    output_private = '''[private]'''

    for line in proc.stdout.readlines():
        data = line.decode("utf-8").split()
        if len(data) == 6 and data[0] != 'Keypair':
            if data[0] == 'Main':
                output_main_1 = output_main_1 + output_dynamic_name_server.format(data[0]) + '\n'
                output_main_2 = output_main_2 + output_dynamic_information_server.format(data[0], data[2]) + '\n'
            else:
                output_private_1 = output_private_1 + output_dynamic_name_server.format(data[0]) + '\n'
                output_private_2 = output_private_2 + output_dynamic_information_server.format(data[0], data[2]) + '\n'

    output_fixed = output_fixed + \
                   output_main + '\n' + output_main_1 + output_main_2 + \
                   '\n' + \
                   output_private + '\n' + output_private_1 + output_private_2

    with open('inventory.ini', 'w') as out:
        out.write(output_fixed + '\n')

    source = './inventory.ini'
    target1 = '../ansible'
    target2 = '../ansible/roles/auto-deploy/templates'

    # adding exception handling
    try:
        shutil.copy(source, target1)
        shutil.copy(source, target2)
        os.rename('../ansible/roles/auto-deploy/templates/inventory.ini',
                  '../ansible/roles/auto-deploy/templates/inventory.ini.j2')
    except IOError as e:
        print("Unable to copy file. %s" % e)
    except:
        print("Unexpected error:", sys.exc_info())


def get_keypair():
    with open("tf_keypair", "w") as f:
        subprocess.check_call(["/usr/local/bin/terraform", "output", "Keypair"], stdout=f)

    os.chmod('tf_keypair', 0o600)

    source = './tf_keypair'
    target1 = '../ansible'
    target2 = '../ansible/roles/auto-deploy/templates'

    # adding exception handling
    try:
        shutil.copy(source, target1)
        shutil.copy(source, target2)
        os.rename('../ansible/roles/auto-deploy/templates/tf_keypair',
                  '../ansible/roles/auto-deploy/templates/tf_keypair.j2')
    except IOError as e:
        print("Unable to copy file. %s" % e)
    except:
        print("Unexpected error:", sys.exc_info())


if __name__ == "__main__":
    get_dynamic_inventory()
    get_keypair()
