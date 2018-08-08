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
