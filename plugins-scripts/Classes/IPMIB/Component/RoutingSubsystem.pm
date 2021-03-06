package Classes::IPMIB::Component::RoutingSubsystem;
our @ISA = qw(GLPlugin::SNMP::Item);
use strict;

sub init {
  my $self = shift;
  $self->{interfaces} = [];
  $self->get_snmp_tables('IP-MIB', [
      ['routes', 'ipRouteTable', 'Classes::IPMIB::Component::RoutingSubsystem::Route' ],
  ]);
}

sub check {
  my $self = shift;
  $self->add_info('checking routes');
  if ($self->mode =~ /device::routes::list/) {
    foreach (@{$self->{routes}}) {
printf "%s\n", Data::Dumper::Dumper($_);
      $_->list();
    }
    $self->add_ok("have fun");
  }
}


package Classes::IPMIB::Component::RoutingSubsystem::Route;
our @ISA = qw(GLPlugin::SNMP::TableItem);

