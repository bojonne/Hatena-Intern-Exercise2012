use strict;
use warnings;
use utf8;
use FindBin::libs;

use TemplateEngine;

my $template = TemplateEngine->new( file => 'templates/main.html' );

print $template->render({
  month   => '8',
  year => '2012',
}); 

