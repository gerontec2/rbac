#!/usr/bin/perl
use Text::ParseWords;
use DBI;
my $host = 'my_windows_server';
my $db = 'DS1';
my $dbh = DBI->connect("dbi:ODBC:Driver={SQL Server};Server=$host;Database=$db;Trusted_Connection=True;") || die "err: $DBI::errstr\n";
my $ts1 = localtime(time());
my $filename = 'd:/tmp/ad_CSVDE1.csv';
my $filename2 = 'd:/tmp/ad_CSVDE2.csv';
my $maxl =0;
my @ret = `C:/Windows/System32/CSVDE -s your_ad_server.net -f $filename -j . -n -r (objectclass=person) -l DN,useraccountcontrol,memberOf,mail,department,company,allianz-OrgGroup`;
foreach(@ret) {
 if (/\d+ entries.+/ ) { print $&; }
}
my $ts2 = localtime(time());
open(F,$filename) || die "can not open $filename\n";
open my $fh, ">:utf8", $filename2 or die "could not open $filename2: $!\n";
while (<F>) {
  chomp;
  s/CN=//g;
  my @col = parse_line(q{,}, 0, $_);
  my $groupline = $col[2];
  my $uac = $col[1];
  my $mail = $col[3];
    my @groups = split(';',$groupline);
  my @userdom = split(',',$col[0]);
  foreach (@groups) {
    my @groupdom = split(',',$_);
	print $fh "$userdom[0],$userdom[4],$uac,$mail,$groupdom[5],$groupdom[0],$col[4],$col[6],$col[5]\n";
  }
}
close $fh;
close F;
my $ts3 = localtime(time());
my $sql = "delete from ad_user_group1";
my $sth = $dbh->prepare($sql) || die "prepare: $DBI::errstr\n";
$sth->execute;
$sql = "insert into ds1.dbo.ad_user_group1 select * from ds1.dbo.ad_user_group";
$sth = $dbh->prepare($sql) || die "prepare: $DBI::errstr\n";
$sth->execute;
my $sql = "delete from ad_user_group";
my $sth = $dbh->prepare($sql) || die "prepare: $DBI::errstr\n";
$sth->execute;
#my $bcp = 'C:/Program Files/Microsoft SQL Server/Client SDK/ODBC/130/Tools/Binn/bcp.exe';
@ret =  `bcp DS1.dbo.ad_user_group IN "d:/tmp/ad_CSVDE2.csv" -f "d:/ad_user_group.xml" -T -e "d:/tmp/bcperr.txt"`;
foreach(@ret) {
 if (/Time.+/ || /.+copied/) { print $_; }
}
$sql = "insert into ds1.dbo.ad_group_grant
         SELECT CONVERT (date, getdate()) ts, username,adgroup from ds1.dbo.ad_user_group
         except SELECT CONVERT (date, getdate()) ts, username,adgroup from ds1.dbo.ad_user_group1";
$sth = $dbh->prepare($sql) || die "prepare: $DBI::errstr\n";
$sth->execute;

$sql = "insert into ds1.dbo.ad_group_revoke
         SELECT CONVERT (date, getdate()) ts, username,adgroup from ds1.dbo.ad_user_group1
         except SELECT CONVERT (date, getdate()) ts, username,adgroup from ds1.dbo.ad_user_group";
$sth = $dbh->prepare($sql) || die "prepare: $DBI::errstr\n";
$sth->execute;
$dbh->disconnect;
$ts = localtime(time());
print "$ts\n";




