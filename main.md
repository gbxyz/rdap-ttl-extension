# Introduction

While [@RFC9083] allows RDAP server operators to provide information about the content of the `NS`, `DS`, `A` and `AAAA` record(s) which are published in the DNS for a given registry object (domain or host object), it does not provide a mechanism to allow the Time-To-Live (TTL) values of those records to be included in responses.

This document describes how TTL information can be included in domain and nameserver objects in RDAP responses.

This document is complementary to the EPP TTL extension (reference needed), but registry operators do not need to implement that extension in their EPP server in order to implement this RDAP extension.

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 [RFC2119] [RFC8174] \(reference needed) when, and only when, they appear in all capitals, as shown here.

# RDAP Response Specification

Servers which support this extension **MUST** include a `ttl_values` object in any domain and nameserver objects included in RDAP responses.

The `ttl_values` object is an object in which the property names are DNS record types, and integers representing the corresponding TTL values.

Example domain object:

```
{
    "objectClassName": "domain",
    "ldhName": "example.com",
    "ttl_values": {
        "NS": 3600,
        "DS": 60
    }
}
```

Example nameserver object:

```
{
    "objectClassName": "nameserver",
    "ldhName": "ns1.example.com",
    "ttl_values": {
        "A": 86400,
        "AAAA": 172800
    }
}
```

RDAP servers which implement both this extension and the FRED RDAP extension (reference needed) **MUST** include `ttl_values` objects in any `fred_nsset` and `fred_keyset` objects included in RDAP responses.

## RDAP Conformance

Servers returning responses containing TTL values **MUST** include the string "`ttl`" in the `rdapConformance` array.

# IANA Considerations

**TODO**

Extension identifier: ttl

Registry operator: Any

Published specification: this document

Contact: IETF <iesg@ietf.org>

Intended usage: This extension describes how DNS TTL values can be included in RDAP responses.

# Security Considerations

**TODO**
