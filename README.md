# kubernetes-the-alta3-way
Kubernetes Installation


### bryfry audit

hname.nodename -- this variable is already available in gathered facts -- deleted
ip.nodename    -- this variable is already available in gathered facts -- deleted

#### makecerts role

main changes were to make all the commands work no matter where they run,
previously this role expected to be run on localhost.  This may not be the 
end goal and all the commands/shells may need to run on a remote host.
This mostly impacted the src and dest of many of the config files used
to generate the certs.

#### other roles
Mostly all I did was move stuff around into other roles where appropriate 
(e.g. move all the local\_action tasks into a localhost role.
I also made extensive changes to variable files.  There is still more to do on
this front, there are lots of hardcoded values in files and templates. Leaving
that as a TODO for later.

#### TODO:

 * This playbook needs handlers.  If any file that is used in a service is modified, call the restart service handler to make sure that the services all get the freshness updates.
 * move the rbac yaml runners out of master_install, put it on beachhead-only playbook
 * add beachhead routes to pod cidrs --> beachhead only playbook
