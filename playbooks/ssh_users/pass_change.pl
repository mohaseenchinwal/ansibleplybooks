#!/usr/bin/perl
use strict;
use warnings;
use Net::SSH::Expect;
use Text::Table;
#
my @host_array1 = ("10.6.100.10", "10.6.100.20", "10.6.100.30", "10.6.101.10", "10.6.101.11", "10.6.101.20");
my @host_array2 = ("qapr-mgmt1.qapr.local", "qapr-mgmt2.qapr.local", "qadr-mgmt1.qadr.local", "qapr-db1.qapr.local", "qapr-db2.
qapr.local", "10.206.10.6");
my @host_array3 = ("qadr-db1.qadr.local", "qapr-epp1.qapr.local", "qapr-epp2.qapr.local", "qadr-epp1.qadr.local", "qapr-ote1.qa
pr.local", "qapr-ote2.qapr.local");
my @host_array4 = ("qadr-web1.qadr.local", "qadr-whois1.qadr.local", "qapr-web1.qapr.local", "qapr-web2.qapr.local", "qapr-whoi
s1.qapr.local", "qapr-whois2.qapr.local");
my @host_array5 = ("qapr-syslog1.qapr.local");

  open(FH, '>', '/home/mohsin/exp_out.txt') or die "cannot open file";
   select FH;
   process(@host_array1);
   #process(@host_array2);
   #process(@host_array3);
   #process(@host_array4);
   #process(@host_array5);
  close FH;  # in the end

#system('mail -s "Linux_systems_Password_Expiry_details" mchinwal\@cra.gov.qa < /home/mohsin/exp_out.txt');








sub   process {
                           my @host_array = @_;
                           my $i;
                           my $username='root';
                           my $password='as12AS!@';
                           my $tb = Text::Table->new("USER", "HOST", "PASSWORD-EXPIRY-DATE");
                           my $chage1;
                           my $chage2;                      #this module helps to creat etxtual tables with crossesponding colu
ms

                    foreach ($i=0;$i<=$#host_array;$i++) {
                                                        my $ssh = Net::SSH::Expect->new(
                                                        user => $username,                #login into the host with respective
field end ":" in the file hosts.txt
                                                        host => $host_array[$i],
                                                        password => $password,
                                                        raw_pty => 1,
                                                        timeout => 6
                                                        );
                                                        my $cmd1 = "export HISTCONTROL=ignorespace";
                                                        my $cmd2 = " echo as12AS!@ |  passwd shamseer | echo as12AS!\@
 | echo pleasechangeme";
                                                        my $login_output = $ssh->login();
                                                        $chage1 = $ssh->exec($cmd1);
                                                        $chage2 = $ssh->exec($cmd2);
                                                        print $chage1;
                                                        print $chage2;
                                                        $ssh->send("sudo -S passwd");
                                                        $ssh->waitfor ('[sudo] password for root\s*', 10);
                                                        $ssh->send("as12AS!\@");
                                                       # my $ls = $ssh->exec("ls -l");
                                                       # print($ls);
                                                        #$ssh->send("find /");
                                                        #my $line;
                                                        #while ( defined ($line = $ssh->read_line()) ) {
                                                        #         print $line . "\n";
                                                        #      }
                                                        print $ssh->peek(0);
                                                        $ssh->eat($ssh->peek(0));
                                                        #$ssh->send ("find /home/mohsin");
                                                        my $chunk;
                                                        #while ($chunk = $ssh->peek(1)) { # grabs chunks of output each 1 second
                                                         #        print $ssh->eat($chunk);
                                                         #     }
                                                        $ssh->send("sudo -S passwd shamseer");
                                                        $ssh->waitfor('[sudo] password for mohsin\s*', 5);
                                                        print $ssh->peek(5);
                                                        $ssh->send("Yash\@123");
                                                        $ssh->waitfor('password:\s*\z', 5);
                                                        print $ssh->peek(5);
                                                        $ssh->send("changeme123!");
                                                        print $ssh->peek(5);
                                                        $ssh->waitfor('password:\s*\z', 5);
                                                        #$ssh->eat($ssh->peek(0));
                                                        $ssh->send("changeme123!");
                                                        print $ssh->peek(5);
                                                        my ($before_match, $match) = $ssh->waitfor('>\s*\z', 1);
                                                        $chage1 = $ssh->exec("uname -a");
                                                        print $chage1;
                                                        $login_output = $ssh->close();
                                                        #my @data = split "\n", $chage;
                                                        #my @newdata = split(/:/,$data[2]);
                                                        #$tb->load([ 'mohsin', $host_array[$i], $newdata[1] ]);     #load the v
alues in txtual table all the time with number hosts in host file
                                                        #system('mail -s "Acoount_Expiry_details" mchinwal\@cra.gov.qa < /home/
mohsin/exp_out.txt');
                                                        }


                                                #print $chage;


}
