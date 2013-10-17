package MT::Plugin::Shorthand;

use strict;
use warnings;

use Data::Dumper;
use MT::Util;

sub hdlr_d {
    my ( $ctx, $args ) = @_;

    foreach my $k ( keys %$args ) {
        next if $k eq '@';
        my $v = $ctx->var($k);
        next if defined($v) && length($v) > 0;
        $ctx->var($k, $args->{$k});
    }

    '';
}

sub hdlr_s {
    my ( $ctx, $args ) = @_;

    foreach my $k ( keys %$args ) {
        next if $k eq '@';
        $ctx->var($k, $args->{$k});
    }

    '';
}

sub hdlr_v {
    my $ctx = shift;
    my ( $args ) = @_;

    my $name = delete $args->{name} // delete $args->{n};
    $args->{name} = $name;

    my $res = $ctx->invoke_handler( 'var', @_ );
    $res;
}

sub hdlr_h {
    my ( $ctx, $args ) = @_;

    $args->{escape} = 'html';
    hdlr_v(@_);
}

sub hdlr_dump {
    my ( $ctx, $args ) = @_;
    my $name = delete $args->{n} // delete $args->{name};

    my $value = $ctx->var($name);

    '<pre>' . Dumper($value) . '</pre>';
}

sub hdlr_sb {
    my $ctx = shift;
    my ( $args ) = @_;
    
    my $name = delete $args->{n} // delete $args->{name};
    $args->{name} = $name;

    $ctx->invoke_handler( 'setvarblock', @_ );
}

sub hdlr_jsonv {
    my ( $ctx, $args, $cond ) = @_;
    my $name = delete $args->{n} // delete $args->{name};

    my $builder = $ctx->stash('builder');
    my $tokens = $ctx->stash('tokens');

    defined ( my $out = $builder->build($ctx, $tokens) )
        or return;

    my $json = eval { MT::Util::from_json($out) };
    $ctx->var( $name, $json );

    '';
}

1;