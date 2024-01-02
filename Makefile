DOC = "draft-brown-rdap-ttl-extension"
VERSION = "00"
XML = "$(DOC)-$(VERSION).xml"

all: build

build:
	./xi.pl "draft.xml.in" > "$(XML)"
	xml2rfc --draft-revisions --text "$(XML)"
	xml2rfc --draft-revisions --html "$(XML)"
