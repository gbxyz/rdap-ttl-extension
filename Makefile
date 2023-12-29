VERSION = "00"
DOC = "draft-brown-rdap-ttl-extension"
SRC = "rdap-ttl-extension.md"
XML = "$(DOC)-$(VERSION).xml"

all: build

build:
	mmark "$(SRC)" > "$(XML)"

	xml2rfc --v3 --text "$(XML)"
	xml2rfc --v3 --html "$(XML)"
