package Acme::Free::Public::APIs;

use strict;
use warnings;

our $VERSION = '1.0.0';

use HTTP::Tiny;
use JSON            qw/decode_json/;
use Util::H2O::More qw/baptise d2o ddd HTTPTiny2h2o/;

use constant {
    BASEURL => "https://www.freepublicapis.com/api/",
};

sub new {
    my $pkg  = shift;
    my $self = baptise { ua => HTTP::Tiny->new }, $pkg;
    return $self;
}

# https://www.freepublicapis.com/api/apis
# https://www.freepublicapis.com/api/apis/275

sub apis {
    my $self   = shift;
    my $params = d2o -autoundef, { @_ };
    my $URL    = sprintf "%s/apis", BASEURL;

    if ($params->id) {
      $URL = sprintf "%s/%d", $URL, $params->id;
    }

    my $resp = HTTPTiny2h2o $self->ua->get($URL);
    return $resp->content;
}


sub random {
    my $self = shift;
    my $URL  = sprintf "%s/random", BASEURL;
    my $resp = HTTPTiny2h2o $self->ua->get($URL);
    return $resp->content;
}

1;

__END__

=head1 NAME

Acme::Free::Public::APIs - Perl API client for ...

This module provides the client, "freeapis", that is available via C<PATH> after install.

=head1 SYNOPSIS

  #!/usr/bin/env perl
    
  use strict;
  use warnings;
  
  use Acme::Free::Public::APIs qw//;

  my $api     = Acme::Free::Public::APIs->new->random;
  my $out     = <<EOAPI;
  id:            %d
  title:         %s%s
  site URL:      %s
  methods:       %s 
  health:        %d 
  documentation: %s
  description:   %s
  EOAPI
  printf $out, $api->id, ($api->emoji) ? sprintf("(%s) ",$api->emoji) : "",, $api->title, $api->source, $api->methods, $api->health, $api->documentation, $api->source;

=head2 C<freeapis> Commandline Client

After installing this module, simply run the command C<freeapis> without any arguments, and it will print
a random Kanfreeapis Rest quote to C<STDOUT>.

  shell> freeapis
  id:            156
  title:         (🔑) KeyVal API
  site URL:      https://freepublicapis.com/keyval-api
  methods:       2 
  health:        90 
  documentation: https://keyval.org
  description:   https://freepublicapis.com/keyval-api
  shell>

=head1 ENVIRONMENT

Nothing special required.

=head1 AUTHOR

Brett Estrade L<< <oodler@cpan.org> >>

=head1 BUGS

Please report.

=head1 LICENSE AND COPYRIGHT

Same as Perl/perl.
