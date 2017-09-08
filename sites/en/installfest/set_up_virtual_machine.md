## Creating a folder to work in

Your first task is to create a folder that will hold everything you create
during the workshop.

This folder will be shared between the virtual machine and your computer. Like sharing files between two real computers with Dropbox or Google Docs, files need to be saved in a place that both your computer and the virtual machine can see. Save all your work in the hands-on exercises here so they can be run in the virtual machine.

How you will create this folder will depend on whether or not you downloaded
the Installfest files before the workshop.

*If you were unable to download the VM ahead of time, we have copies on USB drives.*

*Please choose the one of the next two sections that applies to you!*

#### If You're Using a USB Drive at the Workshop

Drag the `railsbridge` folder from the USB drive to your desktop.

#### If You Downloaded the Files Already

Create a new folder on your desktop by right-clicking and selecting "New
Folder". Name it `railsbridge`.

*Note that the name `railsbridge` should be lowercase.*

In File Explorer or Finder, drag and drop "railsbridgevm-2017-09.box" from
your Downloads folder to your new `railsbridge` folder.

## Set up the virtual machine

*This is a one-time step to create the virtual machine for the workshop.*

Open your computer's command line. (Windows users, open Git Bash.) See the [Command Line page](command_line) for instructions on how to open it.

<!-- INSTRUCTORS: please remember to update all occurrences of the box -->
<!-- filename everywhere when the VM version changes. -->

Go to your new `railsbridge` directory:

    cd ~/Desktop/railsbridge

*If you've been to a workshop before, please ask a TA for help removing your old VM image before proceeding.*

Type this:

    vagrant box add railsbridge ./railsbridgevm-2017-09.box

Then type:

    vagrant init railsbridge

Here is what you should see (approximately):

    Your-Computer:railsbridge$ vagrant init railsbridge
    A `Vagrantfile` has been placed in this directory. You are now
    ready to `vagrant up` your first virtual environment! Please read
    the comments in the Vagrantfile as well as documentation on
    `vagrantup.com` for more information on using Vagrant.

Type this to list all the files you've made:

    ls

Look at the `railsbridge` folder in Finder or File Explorer. You'll notice it
now contains a file called `Vagrantfile`.  This contains configuration
information that Vagrant needs to start and connect to the new virtual
machine.  We have to have a command line open and be in this folder when we
start or connect to the vm so Vagrant can read the configuration information.

Leave this Finder or File Explorer window open for the next step.

## Starting the Virtual Machine

The virtual machine has to be "powered up" in order to use it.

*This is how you will start up and shut down your VM every time you use it.*

If you closed your command line, open it again and type `cd
~/Desktop/railsbridge` to return to your folder.  This folder contains the
file Vagrantfile, which has the configuration settings needed to start the vm.

From the command line type:

    vagrant up

It will do something like this:

    Your-Computer:railsbridge$ vagrant up
    Bringing machine 'default' up with 'virtualbox' provider...
    [default] Importing base box 'railsbridge'...
    [default] Matching MAC address for NAT networking...
    [default] Setting the name of the VM...
    [default] Clearing any previously set forwarded ports...
    [default] Creating shared folders metadata...
    [default] Clearing any previously set network interfaces...
    [default] Preparing network interfaces based on configuration...
    [default] Forwarding ports...
    [default] -- 22 => 2222 (adapter 1)
    [default] -- 3000 => 3000 (adapter 1)
    [default] Booting VM...
    [default] Waiting for VM to boot. This can take a few minutes.
    [default] VM booted and ready for use!
    [default] Configuring and enabling network interfaces...
    [default] Mounting shared folders...
    [default] -- /vagrant

*If you're using Windows and the system firewall asks you about allowing
connections here, tell it to allow connections on private or local networks,
but not on public networks.*

To use the virtual machine, you must connect to it.  From the command line, type

    vagrant ssh

to connect to the virtual machine.

You will see a welcome message something like this:

    Your-Computer:railsbridge$ vagrant ssh
    Welcome to Ubuntu 14.04 LTS (GNU/Linux 3.13.0-24-generic i686)
    * Documentation:  https://help.ubuntu.com/

    Welcome to the RailsBridge Boston virtual machine!
    ...

    RailsBridge-VM:/vagrant$

## Disconnect from the virtual machine (turning it on and off)

When you're done working in the virtual machine, type

    exit

to disconnect from the virtual machine. To stop the virtual machine, type

    vagrant halt

from the command line.

And close the command line window.

When you want to use the virtual machine (tomorrow morning, for instance),
start your machine. Open the command line, then:

    cd ~/Desktop/railsbridge
    vagrant up
    vagrant ssh

## Reminders

* Run `vagrant halt` from the command line when you're done with the virtual machine.
* Run `vagrant up` from the command line to restart the machine after you've rebooted or halted it.
* Run `vagrant ssh` from the command line every time you connect to the virtual machine.

To open an extra command line
on the virtual machine, open another command line window, then type:

    cd ~/Desktop/railsbridge
    vagrant ssh

Note: you can also get to your `railsbridge` directory this way, if `~` is
inconvenient to get to on your keyboard:

    cd
    cd Desktop
    cd railsbridge

## Next Step

Now that you've got your VM, it's time to [Try Your Text
Editor](/installfest/install_a_text_editor).
