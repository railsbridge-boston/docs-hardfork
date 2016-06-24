# Introduction to the Command Line

Peter Degen-Portnoy<br>
RailsBridge Boston<br>
June 24, 2016

# Foundation Skills

This is about the part of the computer we normally do NOT see

* The Structure of the data
  * Files
  * Folders

This *hidden structure* is the **skeletal system** of the computer

# Nested Folders

**Folders and files** : *It's turtles all the way down!*

<img src='/img/gui_tree.png' style="float:right; margin-right: 80px;" />

* Really, really deep nesting possible
* Store files
* Store folders

**Top Folder == Apex**

* Can't go higer

# Smoke and Mirrors, Really

What if we looked at this in a slightly different way?

<img src='/img/text_tree.png' style="float:right; margin-right: 80px;" />

Same idea, but no pretty pictures

This is what is inside.  Inside the Explorer or the Finder. Under the pretty GUI

# Getting Started

* **On Macs:** In Finder, start Applications > Utilities > Terminal
  or find the Terminal application through Spotlight (click the magnifying glass in the top right of the screen and start typing 'Terminal')"
* **On Windows:** open up Git Shell from your desktop or All Programs menu.
* **On Linux:** press Ctrl + Alt + T or Find Terminal under the Accessories category of your applications menu.
* **On Chromebook:** From the [boxes page](https://www.nitrous.io/app#/boxes), click the "IDE" button. The command line window should appear at the bottom of the screen under the "Console" tab.
* If you want to follow along, please go to: http://docs.railsbridgeboston.org/ruby/command_line_2016

# Different Terminals

* If you have successfully installed VirtualBox, Vagrant, and the RailsBridge Box:

Get thee to a terminal. *(Hint: don't type the "$")*

     $ cd workspace
     $ vagrant up
     $ vagrant ssh

* If you have not:
  * Do Not Panic.
  * You should be at a command prompt already.  All is good

# 20 Minute Goal

* Describe the command line
* Gain usage of basic commands
* Be able to navigate directories, create and remove directories, list files

# Key Ideas

* The command line is a character interface to the computer.
  * Instead of single or double clicking, we type a command and press "Enter" ("Return")
* **Know where we are** -- Print Working Directory: `pwd`
* **See what is here** -- List contents: `ls`
* **Go where we want** -- Change Directory: `cd`

# I Like to Move It, Move, It

1. `pwd` *print working directory == where are we?*
  * `/home/vagrant/workspace`
1. `cd` *change directory (no arguments) == go home*
1. `pwd` *We've moved! (unless you are not in a VM)*
  * `/home/vagrant`
1. `ls` *list contents == see what's here*
  * `workspace`
1. `cd workspace` *change directory (with an argument) == go there*
   1. `cd <some directory>` *directories are often a different color or bolded on a modern terminal*
1. `pwd` *We've moved again!*
  * `/home/vagrant/workspace`

**Who did it perfectly?**


# Whoa

* Note the difference: `cd` versus `cd workspace`
* Relative Path: relates to where we currently are
  * `cd workspace` uses an *relative* path.  "change to the workspace directory from here"
* Absolute Page: fully specified from the top (apex) on down
  * `/home/vagrant/workspace` is an *absolute* path.  
  * It starts at root (`/`) and descends through `home`, `vagrant`, and into `workspace`
  
# More Key Ideas

* **Make a new folder** -- Make Directory: `mkdir`
* **See *details* about what is here** -- List contents, long format: `ls -l`
* **Create an empty file** -- Touch the file: `touch <filename>`

# Let's Make Some Stuff
*This works regardless of your OS or whether you are in a VM or not*

*If this doesn't go smoothly, it isn't a problem*

1. `cd` *Go to our home directory*
1. `mkdir dir_1` *Make a new directory*
1. `mkdir dir_2` *Make another new directory*
1. `cd dir_1` *Step into directory 1*
1. `touch file_1` *Touch a file to create it*
1. `mkdir dir_1.1` _Make another directory **right here!**_
1. `cd ..` *Go up one directory (happens to be home)*
1. `cd dir_2` *Step into directory 2 (not directory 1)*
1. `touch file_2` *Touch a file to create it*
1. `cd ..` *Go up one directory again (once again, it's home)*

# Breath.  Slowly and steadily

All is well.  

We've created some structure with which we can now play

![The New Tree](/img/home_tree.png)

* Notes:
  * `.` is the current directory _(No matter where you go, there you are)_
  * `..` is the **parent** directory -- one directory **up**
  * There is **no** corresponding symbol for "child" directory, because there can be many children
  * `~` is the **tilde** _(upper left key on most US keyboards)_

# Unstructured Play

*Try doing these things (Answers on next slide!)*

* How do you get to your home directory?
* How do you know you're there?
* How do you see what is in the current directory?
* How do you go **up** one directory?
* Test: find the directory that has `dir_1`, `dir_2`, and `suggestotron` (if you've created the app) directories in it
* Test: find the directory that has `file_2` in it

# Answers

* How do you get to your home directory?
  * `cd` or `cd ~`
* How do you know you're there?
  * `pwd`
* How do you see what is in the current directory?
  * `ls` or `ls -l`
* Test: find the directory that has `dir_1`, `dir_2`, and `suggestotron` (if you've created the app) directories in it
  * `cd`
  * `ls -l`
* Test: find the directory that has `file_2` in it
  * `cd`
  * `cd dir_2`
  * `ls -l`

**Anyone get this all correctly the first time through?**

# A bit about what we see

     RailsBridge-VM:~/workspace$

* This is the **command line prompt**. 
  * It can be customized (advanced topic), but you should know that you are in control of the computer.
* The first part, "RailsBrige-VM" is the name of the machine
  * Remember, a Virtual Machine, VM, thinks it's a real computer and acts like one
* The `:` is simply a spacer
* The `~` is a shortcut that refers to your home directory
* The `/` (or `\` if you're on Windows) is a directory separator
* The `$` is the prompt -- the final character after which you can type

# A bit about file listings

`ls -l` reveals some interesting things, nicht wahr?

    RailsBridge-VM:~$ ls -l
    total 8
    drwxrwxr-x 3 vagrant vagrant 4096 Apr  1 00:31 dir_1
    drwxrwxr-x 2 vagrant vagrant 4096 Apr  1 00:31 dir_2
    lrwxrwxrwx 1 vagrant vagrant    8 Jun 23  2015 workspace -> /vagrant

* `d` is a **directory**
* `l` is a **link** (advanced topic)
* Permissions are specified for Read, Write, and Execute
* The first _3_ letters are the **owners** permissions
* The next _3_ letters are the **group** permissions
* The last _3_ letters are the **world** permissions (everyone else)
* A _dash_ (`-`) means **no permission**
* Then comes the name of the user and the group, the size of the file (or directory *block*)
* Then comes the date it was created and, finally, the name of the file

_If you step into a directory with a file, what does the `ls -l` show?_

# Clean Up
**Kinda like The Cat In The Hat**

* `cd ~/dir_2` *This is actually **absolute** because `~` is our home*
* `rm file_2` *Remove the file*
* `cd ..` *Change to the parent directory*
* `rmdir dir_2` *Remove dir_2*
* `rm -r dir_1` *Remove dir_1 and everything inside of it* **-r** == recurse into all sub directories

**Yeah, this can be dangerous** One can accidentally and irrevocably delete one's work

# CD Review

* `cd` Changes Directories.  With no argument, it takes you **home**
* `cd dir_1/dir_1.1` Takes you that **relative** directory. It has to be visible with `ls` to change into it
* `cd /home/vagrant/dir_2` Takes you to that **absolute** directory _regardless from where you start_
* `cd ..` takes you up one directory *(To the parent directory)*

# LS Review

* `ls` Shows the contents of the current directory
* `ls -l` Shows the *long listing* of the current directory
* `ls dir_2` Shows the contents of the identified **relative** directory (`dir_2`)
* `ls /home/vagrant/dir_1` Shows the contents of the identified **absolute** directory *(Regardless of where you are)*
* `ls -l dir_1/dir_1.1` Shows the *long listing* of the indentified **relative** directory (`dir_1.1`)

**Question:** How to show the *long listing* of an **absolute** directory path?

# Other Commands

* `pwd` Print Working Directory
* `mkdir` Make a Directory
* `rm` Remove a file (or recursively remove **everything** with the `-r` switch)
* `rmdir` Remove a Directory (must be empty)
* `man <command>` Show the manual for the command
  * Example: `man ls`
* `touch` Change a file's timestamp **and create it if it doesn't exist**



# Well Done!

Questions?
