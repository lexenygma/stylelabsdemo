# stylelabsdemo

# Redis: 

'''My process for solving this issue was as follows:  I checked the system service to see if it was running at all or completely stopped.  After determining that it was indeed stopped, and would not restart I tailed both the service and system logs in order to find additional information.  The system logs told me there was a permission issue, and the service logs were unavailable.  Running 'systemctl' again showed me that there was indeed a permissions issue relating to where the service wanted to log.  Looking into it further, as well as googling for results matching what I was getting I realized that it was trying to log to the wrong location.  I changed the log location in the redis config, reloaded the service daemon then restarted the service, and it came right back up'''

# Windows Server: 

'''For this issues I looked into the Event Manager for any alerts relating to a service or server component that was not starting up correctly.  Here I found an alert that IIS was not running, and that the service account used for the service did not have the correct permissions.  I then worked my way through to ensure that the account did in fact exist, and had the correct permissions to start the service.  After ensuring that all of these were the case, I then reset the pw for the service account and successfully restarted IIS and verified that you no longer received a 503 error when browsing the localhost via http'''



