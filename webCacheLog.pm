#!/usr/bin/perl

#--------------------
package webCacheLog;
#-------------------

use strict;
use warnings;

require Exporter;

my @ISA = qw(Exporter);

=head NAME

    Package : webCacheLog
    
=head Description
    
        webCacheLog Package is to enable the logging for the cache for troubleshooting and information,
          of the cache stored, returned to the main programe.

             There are basically three levels of logging in this cache application:
         1. Info     -> Logs the basic information like web url requested under the logs directory mentioned in the conf file.
         2. Critical -> Logs critical information like cache size full or any other fault which might harm the application.
         3. Error    -> Logs the Error in the cache and exit the application.
         4. Debug    -> For troubleshooting purpose. This needs to be enable in the conf file.
        
=head Author

    Ashutosh Kukreti (kukreti.ashutosh@gmail.com)

=cut

my $LEVEL = 0;
my $fh;


sub new {
    my ($class, %args) = @_;

    my $self = { _logdir => shift };

    my %desc = (
                 _reload    => 0,
                 _logdir    => shift,
                 _infoFile  => "info.logs",
                 _loglevel  => $LEVEL,
                 _errorFile => "error.logs",
                 _debugFile => "debug.logs"
               );

    # Instantiate object.
    my $me = bless \%desc, ref ($class) || $class;

##      ...
    
    $me
}

###################################################

sub reload {
    shift->_reload ++
}

sub critical {
    my $self = shift ;
    print "@_\n" ;
}

sub info {
    my $self = shift ;
    
    $fh = _fileOpen($self, "infoFile");

    print $fh "@_\n" ;

}

sub error {
    my $self = shift;
    print "@_\n";
}

sub debug {
    my $self = shift;
    my ($dbg, $msg) = @_;
    print $dbg $msg, "\n";
}

sub _fileOpen {
   my ($self, $type) = @_;

   my $fkey = '_'.$type; 

   #print Data::Dumper::Dumper($self);

   my $file = $self->{'_logdir'}.'/'.
                      $self->{"$fkey"};
   open (my $fh, ">>", $file) or die "Can't open $file $! \n";

   return $fh;

}

sub _fileClosed {
    my $fh = shift;

    close($fh);
}


1;

__END__
