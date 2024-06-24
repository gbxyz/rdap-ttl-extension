VERSION=01
DOC = "draft-brown-rdap-ttl-extension-$(VERSION)"
XML = "$(DOC).xml"

all: build

build:
	@cp draft.xml "$(XML)"
	@xmlstarlet edit --inplace --update '//rfc/@docName' --value "$(DOC)" "$(XML)"
	@xml2rfc --draft-revisions --html "$(XML)"
