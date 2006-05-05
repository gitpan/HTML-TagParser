# ----------------------------------------------------------------
    use strict;
    use Test::More tests => 10;
    BEGIN { use_ok('HTML::TagParser') };
# ----------------------------------------------------------------
    my $FILE = "t/sample/yahoo.html";
# ----------------------------------------------------------------
SKIP: {
    if ( $] < 5.008 ) {
        local $@;
        eval { require Jcode; };
        skip( "Jcode is not loaded.", 9 ) if $@;
    }
    &test_main();
}
# ----------------------------------------------------------------
sub test_main {
    my $html = HTML::TagParser->new( $FILE );
    ok( ref $html, "open by new()" );

    my $cache = $html->getElementsByAttribute('http-equiv','Cache-Control');
    is( $cache->getAttribute('content'), 'no-cache', 'meta Cache-Control' );

    my $title = $html->getElementsByTagName('title');
    like( $title->innerText(), qr/^Yahoo!/i, 'title' );

    my @script = $html->getElementsByAttribute('language','javascript');
    is( scalar @script, 2, 'script language javascript' );

    my $body = $html->getElementsByTagName('body');
    is( $body->getAttribute('class'), 'bg', 'body class' );

    my $pf_img = $html->getElementById('pf_img');
    is( $pf_img->tagName(), 'img', 'pf_img' );

    my $profile = $html->getElementsByName('id_profile');
    is( $profile->tagName(), 'img', 'id_profile' );

    my @global = $html->getElementsByClassName('global');
    ok( scalar @global, 'class global' );

    my $small = $html->getElementsByTagName('small');
    like( $small->innerText, qr/Copyright/i, 'small' );
}
# ----------------------------------------------------------------
;1;
# ----------------------------------------------------------------
