import subprocess
import os
import shutil
import sys

cmd = ["terraform", "output"]
working_directory = os.getcwd()
proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, cwd=working_directory)

output_fixed = '''
# Contains the web servers at backend network
'''

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

print(output_fixed)

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

with open("tf_keypair", "w") as f:
    subprocess.check_call(["terraform", "output", "Keypair"], stdout=f)

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
