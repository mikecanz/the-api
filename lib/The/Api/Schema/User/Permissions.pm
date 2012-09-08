package The::Api::Schema::User::Permissions;

use Digest::MD5 qw(md5_hex);

use Mongoose::Class;
with 'Mongoose::EmbeddedDocument';

has 'admin' => ( is => 'rw', isa => 'Bool', default => 0 );
#has 'some_other_permission' 	 => (is => 'rw', isa => 'Bool', default => 0);

sub has_permission {
    my $self = shift;
    my $perm = shift;
    return ( $self->{admin} || $self->{$perm} );
}

sub TO_JSON {
    my ( $self, @scope ) = @_;
    my $collapsed = $self->collapse();
    $collapsed->{id} = $self->{_id}->{value};
    delete $collapsed->{_id};
    return $collapsed;
}

no Moose;
__PACKAGE__->meta->make_immutable;
