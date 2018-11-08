Performance optimized SQL-Database to import millions of Active Directory records.
One feature is, that you can collect historical-data every day because an import of 3.000.000 records takes only 8 minutes.

Tested with Microsoft SQL-Server!

1.) execute create_table.sql

2.) execute ad_group.pl

3.) select * from dbo.ad_user_group;

4.) SELECT * FROM dbo.ad_group_grant;

5.) SELECT * FROM dbo.ad_group_revoke;

Read also:

https://support.microsoft.com/de-de/help/305144/how-to-use-the-useraccountcontrol-flags-to-manipulate-user-account-pro
