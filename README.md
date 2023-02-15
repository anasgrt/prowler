## Authors
Module is maintained by [Anas AL Hamd] (https://github.com/anasnedtech).

## General Notes:
1- Make sure that Cloudwatch(Event Bridge) default bus is in /STARTED/ state in /Schema discovery/)
since the Cloudwatch scheduling is workable only in the default event bus, so it is not possible
to create a new event bus in this code and associate it with this scheduling.

2- Prowler STABLE release version has to be selected "https://github.com/prowler-cloud/prowler/releases", latest version is usually NOT stable and after testing some problems emerged with region filtering in prowler command "prowler aws -f $default_region".

3- Prowler needs (access_key_id , secret_key , default_region) varibles in this terraform code to execute its command in the buildspec.yml (buildcode), so these variables should be modified upon code usage; to be applicable with the account we want to security inspect.

4- Schedule timing in this module is in (UTC) timing.
