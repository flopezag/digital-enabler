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
import argparse
from jinja2 import Template
from config.settings import USERNAME, TENANT_NAME, PASSWORD, AUTH_URL, REGION, DOMAIN_NAME, FLAVOR


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


def cli():
    # create parser
    parser = argparse.ArgumentParser()

    # add arguments to the parser
    parser.add_argument('option',
                        help='''\
                        (volumes) Get the OpenStack Volume IDs and complete the terraform.tfvars files.
                        (instances) Generate the inventory.ini file and the corresponding Keypair.
                        (init) Init the terraform.tfvars files''')

    # parse the arguments
    args = parser.parse_args()

    if args.option is None:
        parser.print_help()
    elif args.option != "volumes" and args.option != "instances" and args.option != "init":
        parser.print_help()
    else:
        return args.option


def generate_tfvars():
    if os.path.exists('terraform.tfvars.j2.init'):
        os.chdir('./volumes')
        cmd = ['/usr/local/bin/terraform', 'output']
        output, error = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()

        dict_ids = get_dict_id(output.decode("utf-8").split())

        os.chdir('..')
        with open('terraform.tfvars.j2.init', 'r') as out:
            template = out.read()

        tm = Template(template)
        msg = tm.render(Main_Volume="\"{}\"".format(dict_ids["Main_Volume"]),
                        Beaver_Volume="\"{}\"".format(dict_ids["Beaver_Volume"]),
                        VM_2_Volume="\"{}\"".format(dict_ids["VM_2_Volume"]),
                        VM_1_Volume="\"{}\"".format(dict_ids["VM_1_Volume"]),
                        VM_1_2_Volume="\"{}\"".format(dict_ids["VM_1_2_Volume"]),
                        VM_3_Volume="\"{}\"".format(dict_ids["VM_3_Volume"]),
                        VM_4_Volume="\"{}\"".format(dict_ids["VM_4_Volume"]),
                        VM_5_Volume="\"{}\"".format(dict_ids["VM_5_Volume"]),
                        VM_6_Volume="\"{}\"".format(dict_ids["VM_6_Volume"]),
                        VM_7_Volume="\"{}\"".format(dict_ids["VM_7_Volume"]),
                        VM_7_2_Volume="\"{}\"".format(dict_ids["VM_7_2_Volume"]))

        with open('terraform.tfvars', 'w') as out:
            out.write(msg)
    else:
        print(os.getcwd())
        print('Unable to find terraform.tfvars.j2.init temporal file. '
              'You must to execute firstly terraform-inventory init')


def init_tfvars():
    with open('terraform.tfvars.j2', 'r') as out:
        template = out.read()

    tm = Template(template)
    msg = tm.render(USERNAME=USERNAME,
                    TENANT_NAME=TENANT_NAME,
                    PASSWORD=PASSWORD,
                    AUTH_URL=AUTH_URL,
                    REGION=REGION,
                    DOMAIN_NAME=DOMAIN_NAME,
                    FLAVOR=FLAVOR
    )

    with open('terraform.tfvars.j2.init', 'w') as out:
        out.write(msg)

    # Delete the last lines
    with open('terraform.tfvars.j2.init') as oldfile, open('./volumes/terraform.tfvars', 'w') as newfile:
        for line in oldfile:
            if 'volume_id' not in line:
                newfile.write(line)

    os.chdir('./volumes')


def get_dict_id(text):
    out_dict = dict()

    # Check if we have values
    if len(text) % 3 == 0:
        for i in range(0, int(len(text)/3)):
            out_dict[text[i * 3]] = text[i * 3 + 2]

    return out_dict


if __name__ == "__main__":
    option = cli()

    if option == 'instances':
        get_dynamic_inventory()
        get_keypair()
    elif option == 'volumes':
        generate_tfvars()
    elif option == 'init':
        init_tfvars()
