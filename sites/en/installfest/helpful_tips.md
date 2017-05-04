### Some helpful tips to troubleshoot common issues

**Vagrant SSH**

If you are attempting to connect to the VM with `vagrant ssh` and getting an error try:

   1. $ `vagrant halt` in the terminal

   2. edit the Vagrantfile, right before `end` at the bottom of the file add `config.ssh.insert_key = false`

   3. Open Virtual Box and click on the VM in the left hand column (it should say "powered off")
   If it is not powered off, you can either type vagrant halt again or right click on the VM --> close --> power off

   4. Right click on the powered off VM and click Remove

   5. $ `vagrant up`

   6. $ `vagrant ssh`

**Git Bash for Windows Users**

Windows users should always use the command line through GitBash
 (and NOT GitCMD, PowerShell, Command Prompt or anything else. They will not support the SSH command that we need.)

**If you get an error when running** `vagrant box add railsbridge ./railsbridgevm-2016-06.box`

Make sure the railsbridgevm-2016-06.box file was copied from the Downloads folder to the workspace folder.