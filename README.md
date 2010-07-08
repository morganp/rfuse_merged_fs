rfuse_merged_fs
=================

Relies on fusefs (latest 0.7.0) gem.

This mounts the file system to the first Argument and the all other arguments are folders to be presented as a merged view.

    $ mkdir ~/tmp_fs
    $ rfuse_merged_fs ~/tmp_fs ~/Movies ~/Documents


