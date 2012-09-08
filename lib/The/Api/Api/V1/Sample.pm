package The::Api::Api::V1::Sample;

use Dancer ':syntax';
use Dancer::Plugin::REST;

prepare_serializer_for_format;

set serializer => 'JSON';

prefix '/api/v1';

resource 'sample' => get => sub {
    status_ok(
        {
            returned_hash => {
                id   => 12345,
                name => "Ricky Bobby",
            },
        }
    );
  },

  create => sub {
    status_created( { id => params->{id}, } );
  },

  delete => sub {
    status_accepted( { id => params->{id}, } );
  },

  update => sub {
    status_accepted( { id => params->{id}, } );
  };

true;
