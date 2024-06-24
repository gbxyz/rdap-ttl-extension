DOC=draft-brown-rdap-ttl-extension
VERSION=01
XML=$(DOC)-$(VERSION).xml

all: build

build:
	@./xi.pl "draft.xml.in" > "$(XML)"
	@xmlstarlet edit --inplace --update '//rfc/front/seriesInfo/@docName' --value "$(DOC)" "$(XML)"
	@xml2rfc --draft-revisions --html "$(XML)"
