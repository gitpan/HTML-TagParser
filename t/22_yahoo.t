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

    my $mapimg = $html->getElementsByAttribute('usemap','#Map');
    is( $mapimg->getAttribute('alt'), 'Yahoo! JAPAN', 'Map' );

    my $title = $html->getElementsByTagName('title');
    like( $title->innerText(), qr/^Yahoo!/i, 'title' );

    my @script = $html->getElementsByAttribute('language','javascript');
    is( scalar @script, 3, 'script language javascript' );

    my $body = $html->getElementsByTagName('body');
    is( $body->getAttribute('onLoad'), 'document.sf1.p.focus()', 'body onLoad' );

    my $sbox = $html->getElementById('sbox');
    is( $sbox->tagName(), 'div', 'sbox' );

    my $sf1 = $html->getElementsByName('sf1');
    is( $sf1->tagName(), 'form', 'form sf1' );

    my @spacer = $html->getElementsByClassName('spacer');
    ok( scalar @spacer, 'class spacer' );

    my @small = $html->getElementsByTagName('small');
    my $small = pop( @small );
    like( $small->innerText, qr/Copyright/i, 'small' );
}
# ----------------------------------------------------------------
;1;
# ----------------------------------------------------------------
