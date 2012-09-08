package The::Api;
use Dancer ':syntax';

use Dancer::Session::YAML;
use Data::Dumper;

use The::Api::Api::V1::Sample;

our $VERSION = '0.1';
my $template_data;

# Mark the prefix as undef since we might set it
# in some of the SG::Constable::THINGS that we include
prefix undef;

hook before => sub {

    #debug Dumper session;

    # These are api paths that require no auth like logging in
    return if ( request->path_info =~ m{^/api/v1/user/[A-Za-z0-9_\.]*/login} );
    return if ( request->path_info =~ m{^/api/v1/sample} );

    # If there is user data then the user is logged in and we return.
    my $user_data = session->{'user_data'};

    if ( $user_data->{'email'} ) {
        $template_data->{logged_in_user}     = $user_data->{email};
        $template_data->{logged_in_username} = $user_data->{username};
        $template_data->{logged_in_realname} =
          $user_data->{first_name} . " " . $user_data->{last_name};
        $template_data->{logged_in_customer_filter} =
          $user_data->{customer_filter};
        $template_data->{permissions} = $user_data->{permissions};
        return;
    }

    # If all other checks fail then we boot them to login.
    unless ( request->path_info =~ m{^/login} ) {
        request->path_info('/login');
        redirect '/login';
    }
};

get '/' => sub {
    template 'index';
};

true;
