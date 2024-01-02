DOC = "draft-brown-rdap-ttl-extension"
VERSION = "00"
XML = "$(DOC)-$(VERSION).xml"

all: build

build:
	./xi.pl "$(XML).in" > "$(XML)"
	xml2rfc --draft-revisions --text "$(XML)"
	xml2rfc --draft-revisions --html "$(XML)"
