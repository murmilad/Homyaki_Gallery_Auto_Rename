#!/usr/bin/perl 
#===============================================================================
#
#         FILE: rollback_rename.pl
#
#        USAGE: ./rollback_rename.pl  
#
#  DESCRIPTION: Rollback Auto-Rename task changes by log messages 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Alexey Kosarev (murmilad), 
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 30.04.2012 01:18:45
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

my $log_messages_list = `grep -P 'Апр 30 .* 2012] Gallery_Unic_Name: Change name from /home/alex/Share/Photo/.* to /home/alex/Share/Photo/.*' /var/log/homyaki.log`;

foreach my $log_message (split("\n", $log_messages_list)) {
	if ($log_message =~ /Change name from (\/home\/alex\/Share\/Photo\/.*) to (\/home\/alex\/Share\/Photo\/.*)$/){
		print "mv $2 $1\n";
		print `mv $2 $1`;
	}
}
