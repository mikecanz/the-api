package The::Api::Schema::User;

use Digest::MD5 qw(md5_hex);
use The::Api::Schema::User::Permissions;

use Moose;
with 'Mongoose::Document';

has 'username'     => ( is => 'rw', isa => 'Str', required => 1 );
has 'first_name'   => ( is => 'rw', isa => 'Str', required => 0 );
has 'last_name'    => ( is => 'rw', isa => 'Str', required => 0 );
has 'email'        => ( is => 'rw', isa => 'Str', required => 0 );
has 'password'     => ( is => 'rw', isa => 'Str', required => 0 );
has 'created_by'   => ( is => 'rw', isa => 'Str', required => 1 );
has 'status'       => ( is => 'rw', isa => 'Str', default  => 'ACTIVE' );
has 'time_created' => ( is => 'rw', isa => 'Int', default  => sub { time() } );
has 'last_login'   => ( is => 'rw', isa => 'Int', default  => sub { time() } );
has 'permissions' => (
    is       => 'rw',
    isa      => 'The::Api::Schema::User::Permissions',
    required => 1,
    default  => sub { The::Api::Schema::User::Permissions->new }
);

sub has_permission {
    my $self = shift;
    my $perm = shift;
    return $self->{permissions}->has_permission($perm);
}

sub TO_JSON {
    my ( $self, @scope ) = @_;
    my $collapsed = $self->collapse();
    $collapsed->{'id'} = $self->{_id}->{value};
    delete $collapsed->{password};
    return $collapsed;
}

no Moose;
__PACKAGE__->meta->make_immutable;

