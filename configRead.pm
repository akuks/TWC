#!/usr/bin/perl

#---------------------------
package configRead;
#---------------------------

####################################################################
# Package Name : configRead.pm
#        Usage : my $conf = configRead->new('conf/conf.conf');
#  Description : This package is used to read the configuration
#                file under conf directory.
#
#       Author : Ashutosh Kukreti
#         Mail : kukreti.ashutosh@gmail.com
#####################################################################

use strict;
use warnings;

# Initialize the object from constructor

sub new {

    my $class = shift;
    my $self = { _fileName => shift, };

    print "Config File : ", $self->{_fileName}, "\n";
    bless $self, $class;

    return $self;
}

#########################################################################
#      Method : getConf
#       Usage : $conf->getConf
# Description : Will return the Hash referecne to the main Programe
#########################################################################

sub getConf {
    my ($self) = @_;

    my %conf;

    if (-e $self->{_fileName}){
	print "File ", $self->{_fileName}, " Exist !!!! \n";
    }else {
	exit;
    }

    open (my $cf, $self->{_fileName}) or die "Can't open File ", 
	   $self->{_fileName}, "\n";

    while(my $line = <$cf>){

	chomp($line);
	my ($var1, $var2) = split / = +/, $line;

	$conf{$var1} = $var2;
    }

    return \%conf;
}

1;
