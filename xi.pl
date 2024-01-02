#!/usr/bin/env perl
# this script implements a minimal implementation of XInclude
use File::Slurp;
use LWP::UserAgent;
use URI;
use XML::LibXML;
use constant XURI => 'http://www.w3.org/2001/XInclude';
use strict;
use warnings;

my $ua = LWP::UserAgent->new;

my $doc = XML::LibXML->load_xml('location' => $ARGV[0]);

while (1) {
    my $list = $doc->getElementsByTagNameNS(XURI, 'include');
    last if ($list->size < 1);

    my $xi          = $list->shift;
    my $fallback    = $xi->getElementsByTagName('fallback')->shift;
    my $parse       = $xi->getAttribute('parse') || 'xml';

    my $replacement;
    if ($xi->hasAttribute('href')) {
        my $uri = URI->new_abs(
            $xi->getAttribute('href'),
            $ARGV[0],
        );

        my $content;
        if (!$uri->scheme) {
            $content = read_file($uri->as_string);

        } else {
            my $result = $ua->get($uri);
            die(sprintf('%s: %s', $uri->as_string, $result->status_line)) if ($result->is_error);

            $content = $result->decoded_content;
        }

        if ('xml' eq $parse) {
            $replacement = $doc->importNode(XML::LibXML->load_xml('string' => $content)->firstChild);

        } else {
            $replacement = $doc->createTextNode($content);

        }
    }

    if ($replacement) {
        $xi->parentNode->replaceChild($replacement, $xi);

    } elsif ($fallback) {
        $xi->removeChild($fallback);
        $xi->parentNode->replaceChild($fallback, $xi);

    } else {
        $xi->parentNode->removeChild($xi);

    }
}

print $doc->toString;
