#!/usr/bin/perl
#reference aspen SDK
my $wd = `pwd`;
chomp($wd);
my $PLISTBUDDY="/usr/libexec/PlistBuddy";
my $postflight_file=$wd . "/postinstall";
my $plist=$wd . "/StubHelper/stubconfig.plist";
my $payload = "/Applications/Corel Painter 2019/Corel Painter 2019.app";
$cfg_file="$payload/Contents/Resources/WelcomeBook/IPP.CFG";
if (-e $cfg_file)
{
	open(FILE,$cfg_file);
	foreach (map {/CHANNEL=(\S*)/? ($1) : ()} (<FILE>))
	{
		# $_ is now the filename, so process $_
		print "The Channel ID is $_","\n";
		if (-e $postflight_file) {
			print "Updating $postflight_file","\n";
			system "perl -pi -e 's/channel_id=\"(.*)\"/channel_id=\"$_\"/i' $postflight_file";
		}
		if (-e $plist) {
			print "Updating $plist","\n";
			system "$PLISTBUDDY -c \"Set :ChannelID $_\" $plist";

		}
	};
	close(FILE);
}
exit(0);;

