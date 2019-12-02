import subprocess
import os

cmd = ["terraform", "output"]
working_directory = os.getcwd()
proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, cwd=working_directory)

output_fixed = '''
# Contains the web servers at backend network
[servers]
'''

output_dynamic_name_server = "{}"

output_dynamic_information_server = "{}    ansible_host={}    ansible_user=ubuntu    ansible_connection=ssh"

output1 = ''
output2 = ''

for line in proc.stdout.readlines():
    data = line.decode("utf-8").split()
    output1 = output1 + output_dynamic_name_server.format(data[0]) + '\n'
    output2 = output2 + output_dynamic_information_server.format(data[0], data[2]) + '\n'

output_fixed = output_fixed + output1 + '\n' + output2

print(output_fixed)

with open('inventory.ini', 'w') as out:
    out.write(output_fixed + '\n')
