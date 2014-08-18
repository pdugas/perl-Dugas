# =============================================================================
# Perl-Dugas - The Dugas Family of Perl Modules
# =============================================================================
# @file     lib/Dugas.pm
# @brief    Top-level module
# @author   Paul Dugas <paul@dugas.cc>
# =============================================================================

package Dugas;

use 5.006;
use strict;
use warnings FATAL => 'all';

=head1 NAME

Dugas - The Dugas Family of Perl Modules

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

The B<Dugas> module is a catch-all for definitions and utility subroutines that
don't fit any better elsewhere.

    use Dugas;

    my $dhms = sec2dhms($secs);

=head1 EXPORT

The following are automatically exported:
  * sec2dhms()

=head1 CONSTANTS

(none)

=head1 SUBROUTINES

=head2 $dhms = sec2dhms(SECS)

Convert a timespan in seconds to a string containing the corresponding numbers
of days, hours, minutes, and seconds. 

i.e. sec2dhms(1234567.89) returns "14 days 06:56:07.89"

=cut

sub sec2dhms($) {
  # Implementation taken directly from Net::SNMP::Message::asn1_ticks_to_time()
  # and copied here to eliminate the dependency on the Net::SNMP module where
  # possible.
  my $ticks = (shift || 0) * 100;

  my $days = int($ticks / (24 * 60 * 60 * 100));
  $ticks %= (24 * 60 * 60 * 100);

  my $hours = int($ticks / (60 * 60 * 100));
  $ticks %= (60 * 60 * 100);

  my $minutes = int($ticks / (60 * 100));
  $ticks %= (60 * 100);

  my $seconds = ($ticks / 100);

  if ($days != 0){
      return sprintf '%d day%s %02d:%02d:%05.02f', $days,
      ($days == 1 ? q{} : 's'), $hours, $minutes, $seconds;
  } elsif ($hours != 0) {
      return sprintf '%d hour%s %02d:%05.02f', $hours,
      ($hours == 1 ? q{} : 's'), $minutes, $seconds;
  } elsif ($minutes != 0) {
      return sprintf '%d minute%s %05.02f', $minutes,
      ($minutes == 1 ? q{} : 's'), $seconds;
  } else {
      return sprintf '%04.02f second%s', $seconds, ($seconds == 1 ? q{} : 's');
  }
} # sec2dhms()

=head1 AUTHOR

Paul Dugas, <paul@dugas.cc>

=head1 BUGS

Please report any bugs or feature requests using the project page at
L<http://github.com/pdugas/Perl-Dugas>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Dugas

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2013-2014 Paul Dugas

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
Street, Fifth Floor, Boston, MA 02110-1301 USA.

Paul Dugas may be contacted at the addresses below:

  Paul Dugas                   paul@dugas.cc
  522 Black Canyon Park        http://paul.dugas.cc/
  Canton, GA 30114 USA

=cut

1; # End of Dugas

# =============================================================================
# vim: set et sw=4 ts=4 :