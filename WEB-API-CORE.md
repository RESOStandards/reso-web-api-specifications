# RESO Web API Core Specification
**Version 2.0.0**


# Table of Contents
- [Introduction](#introduction)
- [Section 1: Purpose](#section-1-purpose)
- [Section 2: Specification](#section-2-specification)
  - [2.1 Terminology](#21-terminology)
  - [2.2 HTTP Protocol](#22-http-protocol)
    - [2.2.1 Version Header](#221-version-header)
    - [2.2.2 Optional OData Headers](#222-optional-odata-headers)
  - [2.3 URL Formatting](#23-url-formatting)
    - [2.3.1 Hostname](#231-hostname)
    - [2.3.2 URI Conventions](#232-uri-conventions)
    - [2.3.3 Metadata URI Conventions](#233-metadata-uri-conventions)
    - [2.3.4 Resource Endpoint](#234-resource-endpoint)
    - [2.4 Data Types](#24-data-types)
    - [2.5 Query Support](#25-query-support)
      - [2.5.1 Metadata Request](#251-metadata-request)
      - [2.5.2 Service Document Request](#252-service-document-request)
      - [2.5.3 Fetch by Key](#253-fetch-by-key)
      - [2.5.4 $select Operator](#254-$select-operator)
      - [2.5.5 $top Operator](#255-$top-operator)
      - [2.5.6 $count Operator](#256-$count-operator)
      - [2.5.7 $skip Operator](#257-$skip-operator)
      - [2.5.8 $orderby Operator](#258-$orderby-operator)
      - [2.5.9 $filter-Operator](#259-$filter-operator)
        - [2.5.9.1 OData Primitive Types](#2591-odata-primitive-types)
        - [2.5.9.2 Equals](#2592-equals)
        - [2.5.9.3 Not Equals](#2593-not-equals)
        - [2.5.9.4 Greater Than](#2594-greater-than)
        - [2.5.9.5 Greater Than or Equal](#2595-greater-than-or-equal)
        - [2.5.9.6 Less Than](#2596-less-than)
        - [2.5.9.7 Less Than or Equal](#2597-less-than-or-equal)
        - [2.5.9.8 Single Enumerations](#2598-single-enumerations)
        - [2.5.9.9 Multiple Enumerations](#2598-mulitple-enumerations)
  - [2.6 Response Message Bodies]()
  - [2.7 Standard Resources]()
  - [2.8 Core Query Examples]()
  - [2.9 Security]()
- [Section 3: Authors]()
- [Section 4: References]()
- [Section 5: Appendices]()
- [Section 6: Revision List]()

# Introduction
The Web API Core Endorsement provides a subset of functionality from the OASIS OData specification relevant to those who need to perform live queries or replicate data using the RESO Web API. This includes the ability to express metadata and provide query support for primitive OData types and enumerations. This document offers normative examples of what these items should look like, both in the metadata and payload. 

---

# Section 1: Purpose
The RESO Web API defines a standard for creating, updating, reading, or deleting real estate data from web or mobile applications through open standards and JSON Web APIs.

The goals of this specification are to:

* Adopt existing open standards rather than creating new specifications, when possible.
* Leverage existing software toolkits and libraries.
* Favor convention over configuration, which increases predictability by reducing the number of decisions data consumers need to make.

The Web API uses the [Open Data Protocol (OData)](https://www.odata.org/documentation/), which:
* Is an established, existing, open standard.
* Has well-defined functionality that supports significant RESO use cases.
* Has existing open source server and client implementations to promote community adoption.
* Provides extensibility to handle industry-specific use cases, as needed.


Compatible RESO OData Transport client and server applications MUST be implemented according to versions "4.0" or "4.01" of the OData specification. 

All references to the OData specification contained within this document assume version 4.0 of the OData specification by default, unless otherwise specified.

Compatible server and client applications MUST support OData XML Metadata for schema representation and MUST use the JSON response format for non-metadata payloads.

In keeping with OData, both the client and server applications will use standard HTTP methods to perform the operations outlined by this document. RESO will follow the OData standard and extend it, as needed, to fulfill additional industry needs in OData compliant ways. 

RESO Web API servers MUST conform to OData conventions with respect to metadata, query, and response formats as well as HTTP, TLS, and OAuth2 for application layer protocol, transport security, and authorization requirements.

---

# Section 2: Specification
This specification outlines the requirements for the RESO Web API Core Endorsement, which is a subset of the OData 4.0 specification.

The OData specification is divided into three main sections:
* [Protocol](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part1-protocol.html)
* [URL Conventions](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part2-url-conventions.html)
* [Common Schema Definition Language (CSDL)](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part3-csdl.html)

While there is currently no official RESO reference server at this time, reference servers have been provided by vendors and have been certified with RESO’s new testing tools. 

There is also reference material that should be helpful for developers implementing the Web API Core specification:
* [Data Dictionary 1.7 Reference XML Metadata](https://github.com/RESOStandards/web-api-commander/blob/master/src/main/resources/RESODataDictionary-1.7.xml)
* [Data Dictionary 1.7 Common Schema Open API Reference](https://app.swaggerhub.com/apis/darnjo/RESO-Web-API-Common-Schema/1.7)
* [Web API 2.0.0 Core Testing Specification](https://docs.google.com/document/d/1btCduOpWWzeadeMcSviA8M9dclIz23P-bPUGKwcD0NY/edit?usp=sharing)

Please [contact RESO](mailto:dev@reso.org) if you have questions about the Web API Core specification or testing rules.

## 2.1 Terminology
The following terminology is used within this specification:

| Term | Definition |
| --- | --- |
| **REST** | Representational State Transfer.  More information. |
| **Resource** | A resource is an object with a type, associated data, relationships to other resources, and a set of methods that may operate on it. |
| **RESO Data Dictionary** | A uniform set of field names and data type conventions that set a baseline across the real estate industry for how real estate data will be defined. See the Data Dictionary Overview and DD Wiki (v 1.7) for more information. |
| **Standard Resource** | A data source or collection of data that is represented using the resource definitions defined in the RESO Data Dictionary (e.g. Property, Member, Office). |
| **Local Resource** | A data source or collection of data that is represented using resources not defined in the RESO Data Dictionary. This may also be localized data, such as language localization. |
| **Metadata** | Descriptive information about a data set, object, or resource that helps a recipient understand how resources, fields, and lookups are defined, and relationships between resources. This information contains field names, data types, and annotations that help data producers and consumers understand what’s available on a given server. In OData, metadata is always located at the path /$metadata relative to the provider's service root URL. |
| **Payload** | The term “payload” generally refers to the JSON response returned by the server for a given request. The term is also used when creating or updating data, in which case the payload would be the data provided for create or update. |
| **Schema** | A way of logically defining, grouping, organizing and structuring information about data so it may be understood by different systems. The schema defines the payload a given server is expected to support. |
| **Authorization** | Authorization defines a set of protocols and processes for verifying that a given user has server access to one or more server resources. At the time of writing, the RESO Web API uses the OAuth2 Bearer Token and Client Credentials standards for authorization. |
| **Bearer Token** | A type of authorization that provides simple token-based authentication. More information. |
| **Client Credentials** | A type of authorization grant that uses a client_id and client_secret (essentially username and password) as an additional layer of security in order to provide a Bearer Token upon request. This method is more resilient against man-in-the-middle attacks than Bearer Tokens since there is an additional token request step involved, and tokens may be expired and refreshed programmatically using this approach. More information. |
| **MUST** | The given item is an absolute requirement of the specification. A feature that the specification states MUST be implemented is required in an implementation in order to be considered compliant. If the data is available in the system AND the data is presented for search then it MUST be implemented in the manner described in the specification. See Notes (1), below. |
| **SHOULD** | A feature that the specification states SHOULD be implemented is treated for compliance purposes as a feature that may be implemented. There may exist valid reasons in particular circumstances to ignore an item classified as SHOULD, but the full implications should be understood and the case carefully weighed before choosing not to implement the given feature.  See Notes (1), below. |
| **MAY** | This term means that an item is truly optional. A feature that the specification states MAY be implemented need not be implemented in order to be considered compliant. However, if it is implemented, the feature MUST be implemented in accordance with the specification. See Notes (1), below. |
| **Out of Scope** | This statement means that the specific topic has not been addressed in the current specification but may be addressed in future versions. |
| **N/A** | This term means “not applicable” to the scope of this standard and will not be addressed by this standard specification. |

---

## 2.2 HTTP Protocol
A compatible RESO Web API server MUST use HTTPS as the protocol declared by the server URL. 

The version MUST be [HTTP/1.1](https://datatracker.ietf.org/doc/html/rfc2616) or above, which includes [HTTP/2](https://en.wikipedia.org/wiki/HTTP/2) at the time of writing. 

While OData supports HTTP/1.0, there are many limitations in the HTTP/1.0 specification that we want to avoid. Therefore, we are limiting compatible implementations to HTTP/1.1 or above. For specific HTTP references, please see the references section.

Since the RESO Web API requires that [HTTPS](https://en.wikipedia.org/wiki/HTTPS) and the [OAuth2](https://oauth.net/2/) protocols are used, all server implementations MUST implement [Transport Layer Security (TLS)](https://en.wikipedia.org/wiki/Transport_Layer_Security). 

---

### 2.2.1 Version Header
The OData version header is used by the server to communicate the currently supported version of the specification:

`OData-Version: [Version]`

where

`[Version] = MAJOR.MINOR`

Examples

`OData-Version: 4.0`

`OData-Version: 4.01`


From [MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers): 

> HTTP headers let the client and the server pass additional information with an HTTP request or response. An HTTP header consists of its case-insensitive name followed by a colon (`:`), then by its value. 
> [Whitespace before the value is ignored](https://developer.mozilla.org/en-US/docs/Glossary/Whitespace).


This means that `odata-version:     4.0` and `OdAtA-vErSiOn:4.01` are also valid, though not recommended. Those using headers should be prepared to process them accordingly.

Requirements
* *Servers MUST provide an OData-Version header in their responses.*
* *Clients MAY specify a given OData-Version in their requests.*


| Client Request | Result |
| --- | --- |
| **No Version** | Server MUST return the current supported version |
| **Current Version** | Server MUST return the current version |
| **Older Version, Still Supported** | Server MUST return requested version |
| **Older Version, Not Supported** | Server MUST return HTTP 400 Bad Request |
| **Newer Version** | Server MUST return HTTP 400 Bad Request |

See Response Message Bodies for details on expected responses.

---

### 2.2.2 Optional OData Headers
The following optional headers are defined in the specification:

| **Header** | **Functionality** |
| --- | --- |
| `omit=nulls` | It is recommended that that servers fully support this functionality in order to reduce the outbound payload size. |
| `omit=defaults` | It is recommended that servers do not support this functionality in order to ensure that clients get important default values that are integral to the service. |


## 2.3 URL Formatting
The OData transport protocol defines a few standardized URL formatting requirements for ease of use and application interoperability.

---

### 2.3.1 Hostname 
The hostname of the URL is arbitrary and no naming convention is required. 

The following example protocol and hostname are used in the examples in this document. HTTPS is required.

```https://api.reso.org```

---

### 2.3.2 URI Conventions
The OData transport protocol defines the following URI conventions:

| **Item** | **URI** |
| --- | --- |
| **Metadata Path** | `https://api.reso.org/reso/odata/$metadata` |
| **Resource Path** | `https://api.reso.org/reso/odata/Resource` |
| **Service Root** | `https://api.reso.org/reso/odata/` |
| **Singleton Resource Path (String Key)** | `https://api.reso.org/reso/odata/Resource('ID')` |
| **Singleton Resource Path (Numeric Key)** | `https://api.reso.org/reso/odata/Resource(123)` 

RESO uses **TitleCase** for Resources, Fields, OData Lookup Values, and Navigation Properties.

---

### 2.3.3 Metadata URI Conventions
OData offers a [special endpoint](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_AddressingtheModelforaService) for conveying server metadata, located at:

`https://<service root>/$metadata`

The metadata document MUST be located relative to the [OData service root](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_ServiceRootURL), as shown above.

**Example**

Assume the OData service root is located at `https://api.reso.org`

The metadata document MUST be located at `https://api.reso.org/$metadata`

**Example**

Service root definitions MUST not overlap, meaning that one service root cannot be nested in another.  A request to https://api.reso.org/systemA/$metadata would fail if used in conjunction with the service root definition above. 

Vendors who offer multiple endpoints should structure their services accordingly. If there are two systems, systemA and systemB, their service roots would be:

**System A**: `https://api.reso.org/systemA`

**System B**: `https://api.reso.org/systemB`

---

### 2.3.4 Resource Endpoint
Resources are defined by the server’s XML Metadata document, which also defines the URLs used to query those resources. 

In the language of OData, resource definitions use the `EntityType` tag.

**Example**
Assume a given server defines a Property resource as follows, using the XML Metadata example from [section 2.3.3](#233-metadata-uri-conventions):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<edmx:Edmx Version="4.0" xmlns:edmx="http://docs.oasis-open.org/odata/ns/edmx">
  <edmx:DataServices>
    <Schema Namespace="org.reso.metadata" xmlns="http://docs.oasis-open.org/odata/ns/edm">
      <EntityType Name="Property">
        <Key>
          <PropertyRef Name="ListingKey"/>
        </Key>
        <Property MaxLength="255" Name="ListingKey" Type="Edm.String"/>
        <Property Name="ListPrice" Precision="14" Scale="2" Type="Edm.Decimal"/>
        <Property Name="StandardStatus" Type="org.reso.metadata.enums.StandardStatus"/>
        <Property Name="ModificationTimestamp" Precision="27" Type="Edm.DateTimeOffset"/>
      </EntityType>
    </Schema>
    <Schema Namespace="org.reso.metadata.enums" xmlns="http://docs.oasis-open.org/odata/ns/edm">
      <EnumType Name="StandardStatus">
        <Member Name="Active"/>
        <Member Name="Closed"/>
        <Member Name="ComingSoon"/>
        <Member Name="Pending"/>
      </EnumType>
    </Schema>
  </edmx:DataServices>
</edmx:Edmx>
```
This metadata defines the following items:

| **Item** | **XML Schema** | **Data Type** | **Attributes** | **Comments** |
| --- | --- | --- | --- | --- |
| **Property Resource** | EntityType | N/A | Key field of ListingKey | Each entity MUST define a Key property. |
| **ListingKey Field** | Property | `Edm.String` | MaxLength of 255 | MaxLength is an optional attribute. |
| **ListPrice Field** | Property | `Edm.Decimal` | Precision is 14, Scale is 2 | Precision and Scale are optional attributes. |
| **StandardStatus Field** | Property | `org.reso.metadata.enums.StandardStatus` | N/A | The type in an `Edm.EnumType` definition is defined by the namespace and references the StandardStatus EnumType defined on line 16. |
| **ModificationTimestamp Field** | Property | `Edm.DateTimeOffset` | Precision of 27 to support the ISO 8601 format | Supported timestamps in this case would be: `2021-05-21T06:28:34+00:00` OR `2021-05-21T06:28:34Z` either of which MAY have a trailing millisecond component, for example: `2021-05-21T06:28:34+00:00.108` OR `2021-05-21T06:28:34.007Z` |
| **StandardStatus Enumeration** | EnumType | `Edm.EnumType` | N/A | Defines enumerations for: Active, Closed, ComingSoon, and Pending using the SimpleIdentifier format. |

**Request Data from the Property Resource without an OData `$filter` Expression**

```json
GET https://api.reso.org/Property
200 OK

{
  "@odata.context": "https://api.reso.org/Property",
  "value": [
    {
      "ListingKey": "a1",
      "ListPrice": 100000.00,
      "ModificationTimestamp": "2020-04-02T02:02:02.02Z",
      "StandardStatus": "Active"
    },
    {
      "ListingKey": "b2",
      "ListPrice": 100001.00,
      "ModificationTimestamp": "2020-04-03T02:02:02.02Z",
      "StandardStatus": "Pending"
    }
  ]
}
```

**Request Data from the Property Resource using an OData `$filter` Expression**
```json
GET https://api.reso.org/Property?$filter=ListPrice gt 100000.00
200 OK

{
  "@odata.context": "https://api.reso.org/Property?$filter=ListPrice gt 100000.00",
  "value": [
    {
      "ListingKey": "b2",
      "ListPrice": 100001.00,
      "ModificationTimestamp": "2020-04-03T02:02:02.02Z",
      "StandardStatus": "Pending"
    }
  ]
}
```

---


### 2.4 Data Types

This section outlines the standard data types supported by the  Web API Core specification. 

**Data Type Mappings**

The following mappings exist between the RESO Data Dictionary and OData data types, as outlined in RCP-031:

| **Data Dictionary 1.6+** | **Web API 1.0.2+** | **Notes** | 
| --- | --- | --- |
| Boolean | [Edm.Bool](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Boolean) | MUST be one of the literals `true` or `false` (case-sensitive). |
| Collection | [Edm.Collection](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752651) | Only supported for Edm.EnumType in Web API Core, and only for those using Collection(Edm.EnumType) to represent lookups. Vendors MAY use collection data types for their own resources. RESO also has defined standard [NavigationProperty](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Element_edm:NavigationProperty) definitions, which allow expansion between related resources. See [RESO’s reference metadata](https://raw.githubusercontent.com/RESOStandards/web-api-commander/main/src/main/resources/RESODataDictionary-1.7.xml) and search for “NavigationProperty” for normative XML Metadata references. |
| Date | [Edm.Date](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752636) | MUST be in YYYY-MM-DD format according to the [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) date format. | 
| Number | [Edm.Decimal](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752638) OR [Edm.Double](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part3-csdl.html#_Toc453752517) for decimal values; [Edm.Int64](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part3-csdl.html#_Toc453752517) OR [Edm.Int32](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part3-csdl.html#_Toc453752517) OR [Edm.Int16](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part3-csdl.html#_Toc453752517) for integers. | Numbers that require decimal precision MUST use Edm.Decimal or Edm.Double, whose query and payload semantics are the same. Integers MAY be sized accordingly to support the data in a given field. |
| String | [Edm.String](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752644) | MUST be case-sensitive by the OData specification. Field names are also case sensitive when used in the `$select`, `$filter`, and `$orderby` query operators and clients MUST respect case sensitivity defined in the resource metadata. |
| String List, Single | [Edm.EnumType](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_8.1_The_edm:EnumType) OR [Edm.String](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752644) with the [Lookup Resource (RCP-032)](https://reso.atlassian.net/wiki/spaces/RESOWebAPIRCP/pages/2275152879/RCP+-+WEBAPI-032+Lookup+and+RelatedLookup+Resources+for+Lookup+Metadata) | RESO supports either `Edm.EnumType` OR `Edm.String` lookups. The former MUST conform to OData SimpleIdentifier conventions, which essentially means they begin with a letter or underscore, followed by at most 127 letters, underscores or digits. Deprecation Notice applies. See Notes. |
| Sting List, Multi | [Edm.EnumType](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_8.1_The_edm:EnumType) with `IsFlags=true` OR [Collection(Edm.EnumType)]((http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_8.1_The_edm:EnumType)) OR [Collection(Edm.String)](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752644) with the [Lookup Resource (RCP-032)](https://reso.atlassian.net/wiki/spaces/RESOWebAPIRCP/pages/2275152879/RCP+-+WEBAPI-032+Lookup+and+RelatedLookup+Resources+for+Lookup+Metadata) | RESO supports three kinds of multi-valued enumerations at the moment. Deprecation Notice applies. See Notes. |
| Timestamp | [Edm.DateTimeOffset](http://docs.oasis-open.org/odata/odata-csdl-xml/v4.01/csprd02/odata-csdl-xml-v4.01-csprd02.html#sec_DateTimeOffset) | Timestamps also use the [ISO 8601 format](https://en.wikipedia.org/wiki/ISO_8601). Examples: `2021-05-21T16:43:43+00:00` and `2021-05-21T16:43:43Z`. Millisecond precision: `2021-05-21T16:43:43.108+00:00` and `2021-05-21T16:43:43.007Z` |

Notes
* A server MAY return HTTP 413 - Request Entity Too Large if the `$filter` or `$orderby` expressions are too large or complex for the server to process.
* **Deprecation Notice**: OData `Edm.EnumType` definitions will soon be deprecated within RESO standards due to the fact that the `Edm.EnumType` portion usually requires additional knowledge or discovery of vendor-specific namespaces, and human-friendly lookup names are not allowed. RESO is currently migrating to `Edm.String` lookups, and new implementations should use this approach. Please contact RESO with further questions. 
* **Deprecation Notice**: Similar to (2), OData `Edm.EnumType` definitions with `IsFlags=true` will soon be deprecated within RESO standards, with `Collection(Edm.EnumType)` being the current default. However, RESO is currently migrating to `Collection(Edm.String)` for these lookups, which new implementations should use instead. Please contact RESO with further questions. 

---

### 2.5 Query Support
Each OData data type supports query operators relevant to its type. For instance, dates, timestamps, and numbers allow for greater than and less than comparisons. 

Specifics regarding data types and query operators are outlined in the sections that follow.

See the OData specification for further details regarding Query Support.

_The query operators shown in this section are MUST requirements for the Web API Core Endorsement unless otherwise specified._

---

#### 2.5.1 Metadata Request
OData supports both XML and JSON metadata formats. 

Servers MAY support JSON metadata, but RESO requires they MUST support the XML metadata format. 

The [OData format parameter](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#_Toc31361046) allows clients to request a specific format, such as `$format=application/xml` for XML Metadata. 

If no `$format` parameter is passed, the server MUST return the `application/xml` format of the metadata when a request is made to the `/$metadata` endpoint.

**Example**
```xml
GET https://api.reso.org/$metadata?$format=application/xml
HTTP/2 200 OK

<?xml version="1.0" encoding="UTF-8"?>
<edmx:Edmx Version="4.0" xmlns:edmx="http://docs.oasis-open.org/odata/ns/edmx">
  <edmx:DataServices>
    <Schema Namespace="org.reso.metadata" xmlns="http://docs.oasis-open.org/odata/ns/edm">
      <EntityType Name="Property">
        <Key>
          <PropertyRef Name="ListingKey"/>
        </Key>
        <Property MaxLength="255" Name="ListingKey" Type="Edm.String"/>
        <Property Name="ListPrice" Precision="14" Scale="2" Type="Edm.Decimal"/>
        <Property Name="StandardStatus" Type="org.reso.metadata.enums.StandardStatus"/>
        <Property Name="ModificationTimestamp" Precision="27" Type="Edm.DateTimeOffset"/>
      </EntityType>
    </Schema>
    <Schema Namespace="org.reso.metadata.enums" xmlns="http://docs.oasis-open.org/odata/ns/edm">
      <EnumType Name="StandardStatus">
        <Member Name="Active"/>
        <Member Name="Closed"/>
        <Member Name="ComingSoon"/>
        <Member Name="Pending"/>
      </EnumType>
    </Schema>
  </edmx:DataServices>
</edmx:Edmx>
```

** Notes **
* For more information about the XML Metadata format, see the [OData 4.0 Errata 03 Specification](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752500).
* The `edmx:DataServices` element MUST contain one or more [`edm:Schema` elements](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_4.1_The_edm:Schema) which define the schemas exposed by the OData service.
* Each EntityType definition MUST define a Key. [More information](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752555).
* A schema is identified by a [namespace](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Namespace). All `edm:Schema` elements MUST have a namespace defined through a Namespace attribute which MUST be unique within the document, and SHOULD be globally unique. A schema cannot span more than one document. [More information](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752522).
* OData EntityType, Property, and EnumType Member elements MUST conform to OData’s [SimpleIdentifier](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_SimpleIdentifier) naming conventions.
* OASIS publishes [XML Metadata XSD definitions](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/schemas/) that can be used to validate the syntax of an XML Metadata document. 
* RESO offers [reference metadata in XML format](https://raw.githubusercontent.com/RESOStandards/web-api-commander/main/src/main/resources/RESODataDictionary-1.7.xml) which can be used as a guide, and corresponds to RESO Data Dictionary 1.7.
* The above example does not demonstrate the use of annotations, which are outlined in the [reference XML Metadata document](https://raw.githubusercontent.com/RESOStandards/web-api-commander/main/src/main/resources/RESODataDictionary-1.7.xml).

---

#### 2.5.2 Service Document Request
Servers MUST support a service document request, according to the OData Minimal Conformance Rules.

> The service root URL identifies the root of an OData service. A GET request to this URL returns the format-specific service document, see [OData-JSON](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#ODataJSONRef).
> 
> The service root URL MUST terminate in a forward slash.
> 
> The service document enables simple hypermedia-driven clients to enumerate and explore the resources published by the OData service.

RESO validates that the service document request can be made and that it produces a valid JSON response, but does not have any additional requirements about what the document must contain. Data providers may choose which entities they want advertise in their service document according to their business needs.

**Example**
Assuming the metadata in [section 2.5.1](#251-metadata-request),

```json
GET https://api.reso.org/$metadata?$format=application/xml
HTTP/2 200 OK

<?xml version="1.0" encoding="UTF-8"?>
<edmx:Edmx Version="4.0" xmlns:edmx="http://docs.oasis-open.org/odata/ns/edmx">
  <edmx:DataServices>
    <Schema Namespace="org.reso.metadata" xmlns="http://docs.oasis-open.org/odata/ns/edm">
      <EntityType Name="Property">
        <Key>
          <PropertyRef Name="ListingKey"/>
        </Key>
        <Property MaxLength="255" Name="ListingKey" Type="Edm.String"/>
        <Property Name="ListPrice" Precision="14" Scale="2" Type="Edm.Decimal"/>
        <Property Name="StandardStatus" Type="org.reso.metadata.enums.StandardStatus"/>
        <Property Name="ModificationTimestamp" Precision="27" Type="Edm.DateTimeOffset"/>
      </EntityType>
    </Schema>
    <Schema Namespace="org.reso.metadata.enums" xmlns="http://docs.oasis-open.org/odata/ns/edm">
      <EnumType Name="StandardStatus">
        <Member Name="Active"/>
        <Member Name="Closed"/>
        <Member Name="ComingSoon"/>
        <Member Name="Pending"/>
      </EnumType>
    </Schema>
  </edmx:DataServices>
</edmx:Edmx>
```

The Service Document would be as follows:
```json
GET https://api.reso.org
HTTP/2 200 OK

{
  "@odata.context": "$metadata",
  "value": [{
    "name": "Property",
    "url": "Property"
  }]
}
```

#### 2.5.3 Fetch by Key
OData provides a way to access a single record by its key, called a singleton record. 

How the key is referenced depends on its type. 

The following examples assume that a resource called Property is defined. 

Note: unlike requests that return a collection of items in a value array, singleton requests return a instance of the requested type at the top level if a given record exists.

**String Keys**

String keys are surrounded with single quotes when used in an OData key query:
```json
GET https://api.reso.org/Property('abc123')
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property('abc123')",
  "ListingKey": "abc123",
  "BedroomsTotal": 5,
  "ListPrice": 100000.00,
  "StreetName": "Main",
  "ModificationTimestamp": "2020-04-02T02:02:02.02Z",
  "ListingContractDate": "2020-04-02",
  "StandardStatus": "ActiveUnderContract",
  "AccessibilityFeatures": ["AccessibleApproachWithRamp", "AccessibleEntrance", "Visitable"]
}
```

**Numeric Keys**

Numeric keys do not use any special characters:
```json
GET https://api.reso.org/Property(123)
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property(123)",
  "ListingKeyNumeric": 123,
  "BedroomsTotal": 5,
  "ListPrice": 100000.00,
  "StreetName": "Main",
  "ModificationTimestamp": "2020-04-02T02:02:02.02Z",
  "ListingContractDate": "2020-04-02",
  "StandardStatus": "ActiveUnderContract",
  "AccessibilityFeatures": ["AccessibleApproachWithRamp", "AccessibleEntrance", "Visitable"]
}
```

---

#### 2.5.4 `$select` Operator

OData allows clients to specify which fields they would like returned in a given payload through the use of the [$select operator](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#_Toc31361040).

```json
GET https://api.reso.org/Property?$select=ListingKey,ModificationTimestamp
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$select=ListingKey,ModificationTimestamp",
  "value": [
    {
      "ListingKey": "abc123",
      "ModificationTimestamp": "2020-04-02T02:02:02.02Z"
    },
    {
      "ListingKey": "bcd234",
      "ModificationTimestamp": "2020-04-02T02:02:02.007Z"
    }
  ]
}
```
RESO Web API Core servers MUST support the `$select` operator.


---

#### 2.5.5 `$top` Operator

The [OData `$top` operator](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#_Toc31361042) allows clients to specify the number of records they would like to request from a given server.

Servers MAY respond with a page size different than the one requested, and clients should be prepared to respond accordingly.

```json
GET https://api.reso.org/Property?$select=ListingKey,ModificationTimestamp&$top=1
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$select=ListingKey,ModificationTimestamp&$top=1",
  "value": [
    {
      "ListingKey": "abc123",
      "ModificationTimestamp": "2020-04-02T02:02:02.02Z"
    }
  ]
}
```

RESO Web API Core servers MUST support the `$top` operator.

---

#### 2.5.6 `$count` Operator

The [`$count` system query option](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_SystemQueryOptioncount) allows clients to request a count of the matching resources included with the resources in the response. 

The `$count` query option has a Boolean value of `true` or `false`.

The semantics of $count are covered in the [OData-Protocol](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#odata) document.

```json
GET https://api.reso.org/Property?$select=ListingKey,ModificationTimestamp&$top=1&$count=true
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$select=ListingKey,ModificationTimestamp&$top=1&$count=true",
  "@odata.count": 2,
  "value": [
    {
      "ListingKey": "abc123",
      "ModificationTimestamp": "2020-04-02T02:02:02.02Z"
    }
  ]
}
```
RESO Web API Core servers MUST support the `$count` operator.

---

#### 2.5.7 `$skip` Operator
The [`$skip` query option](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#_Toc31361042) requests the number of items in the queried collection that are to be skipped and not included in the result. A client can request a particular page of items by combining `$top` and `$skip`.

The semantics of `$top` and `$skip` are covered in the [OData-Protocol](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#odata) document. The [OData-ABNF](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#ABNF) top and skip syntax rules define the formal grammar of the `$top` and `$skip` query options respectively.

```json
GET https://api.reso.org/Property?$select=ListingKey,ModificationTimestamp&$count=true&$top=1&$skip=1
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$select=ListingKey,ModificationTimestamp&$count=true&$top=1&$skip=1",
  "@odata.count": 2,
  "value": [
    {
      "ListingKey": "bcd234",
      "ModificationTimestamp": "2020-04-02T02:02:02.007Z"
    }
  ]
}
```

 RESO Web API Core servers MUST support the `$skip` operator but providers are allowed to decide for themselves how many records they want to allow skipping over.

 ---

 #### 2.5.8 `$orderby` Operator

 The [`$orderby` system query option](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_SystemQueryOptionorderby) allows clients to request resources in a particular order.

The semantics of `$orderby` are covered in the [OData-Protocol](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#odata) document.

The [OData-ABNF](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#ABNF) orderby syntax rule defines the formal grammar of the `$orderby` query option.

```json
GET https://api.reso.org/Property?$select=ListingKey,ModificationTimestamp&$orderby=ModificationTimestamp asc
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$select=ListingKey,ModificationTimestamp&$orderby=ModificationTimestamp asc",
  "value": [
    {
      "ListingKey": "bcd234",
      "ModificationTimestamp": "2020-04-02T02:02:02.007Z"
    },
     {
      "ListingKey": "abc123",
      "ModificationTimestamp": "2020-04-02T02:02:02.02Z"
    }
  ]
}
```

RESO Web API Core servers MUST support the `$orderby` operator.

---

#### 2.5.9 `$filter` Operator

OData `$filter` expressions provide query support for boolean search expressions. 

This includes logical operators such as AND, OR, and NOT, as well as greater than, greater than or equal, less than, less than or equal, and not equals for OData primitive types, and query support for enumerations.

**OData Primitive Types**

Primitive types are things like integers, decimal numbers, dates, and timestamps.

The RESO Web API Core specification includes $filter support for the following [OData Primitive Types](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752517):
* `Edm.Int16`, `Edm.Int32`, and `Edm.Int64`
* `Edm.Decimal` and `Edm.Double`
* `Edm.Date`
* `Edm.DateTimeOffset`

**Enumerations**

Enumerations define the allowed values in a given lookup field. 

They can either be single enumerations, where only one value is provided, or multiple enumerations, in which case there is a list of values. 

The standard values used in transport are determined by a given lookup field’s underlying [data type](#24-data-types). 

At this document’s time of writing, implementations use Edm.EnumType enumerations since they’ve historically been the only supported lookup data type. As such, the single and multiple enumeration examples contained in this document use `Edm.EnumType` and `Collection(Edm.EnumType)`, respectively.

_**Note**: support for `Edm.String` versions of enumerations, which use human-friendly display names as values, has recently been added and is the preferred approach for new implementations. The RESO community is in the process of moving away from Edm.EnumType lookups to simplify implementations and improve user friendliness. See [RCP-032](https://reso.atlassian.net/wiki/spaces/RESOWebAPIRCP/pages/2275152879) for information about string lookups._

---

##### 2.5.9.1 OData Primitive Types

This section outlines logical operators and query expressions available in Web API Core for the following [OData Primitive Types](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752517):
* Integers: `Edm.Int16`, `Edm.Int32`, and `Edm.Int64`
* Decimals: `Edm.Decimal` and `Edm.Double`
* Dates: `Edm.Date`
* Timestamps: `Edm.DateTimeOffset`

_Note that String query operators are not part of the RESO Web API Core specification at this time._


The quoted descriptions outlined in this document contain excerpts from the [OData 4.01 Specification](http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_QueryOptions). Please see the sections linked to in each of the following sections for the most up-to-date information.

The examples presented here assume that the server is using a subset of [RESO’s reference XML Metadata](https://raw.githubusercontent.com/RESOStandards/web-api-commander/main/src/main/resources/RESODataDictionary-1.7.xml) with the following Primitive Type fields available:
* BedroomsTotal (`Edm.Int64`)
* ListPrice (`Edm.Decimal`)
* ListingContractDate (`Edm.Date`)
* ModificationTimestamp (`Edm.DateTimeOffset`)

Enumerations are also shown in the sample payloads. Queries for enumerations are covered in later sections of this document.

---

##### 2.5.9.2 Equals

[OData Documentation](http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_Equals)
> The `eq` operator returns true if the left operand is equal to the right operand, otherwise it returns `false`.
> 
> When applied to operands of entity types, the `eq` operator returns `true` if both operands represent the same entity, or both operands represent `null`.
> 
> When applied to operands of complex types, the `eq` operator returns `true` if both operands have the same structure and same values, or both operands represent `null`.
> 
> When applied to ordered collections, the `eq` operator returns `true` if both operands have the same cardinality and each member of the left operand is equal to the corresponding member of the right operand.
> 
> For services that support comparing unordered collections, the `eq` operator returns `true` if both operands are equal after applying the same ordering on both collections.
>
>Each of the special values `null`, `-INF`, and `INF` is equal to itself, and only to itself.
>
>The special value `NaN` is not equal to anything, even to itself.

**Example**

_Total number of bedrooms equals 3._

```json
GET https://api.reso.org/Property?$filter=BedroomsTotal eq 3
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$filter=BedroomsTotal eq 3",
  "value": [
    {
      "ListingKey": "a1",
      "BedroomsTotal": 3,
      "ListPrice": 100000.00,
      "StreetName": "Main",
      "ModificationTimestamp": "2020-04-02T02:02:02.02Z",
      "ListingContractDate": "2020-04-02",
      "StandardStatus": "ActiveUnderContract",
      "AccessibilityFeatures": ["AccessibleApproachWithRamp", "AccessibleEntrance", "Visitable"]
    }
  ]
}
```

##### 2.5.9.3 Not Equals

[OData Documentation](http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_NotEquals)
> The `ne` operator returns `true` if the left operand is not equal to the right operand, otherwise it returns `false`.
> 
> When applied to operands of entity types, the `ne` operator returns `true` if the two operands do not represent the same entity.
>
> When applied to operands of complex types, the `ne` operator returns `true` if the operands do not have the same structure and same values.
> 
> When applied to ordered collections, the `ne` operator returns `true` if both operands do not have the same cardinality or any member of the left operand is not equal to the corresponding member of the right operand.
> 
> For services that support comparing unordered collections, the `ne` operator returns `true` if both operands do not have the same cardinality or do not contain the same members, in any order.
> 
> Each of the special values `null`, `-INF`, and `INF` is not equal to any value but itself.
> 
> The special value `NaN` is not equal to anything, even to itself.
> 
> The `null` value is not equal to any value but itself.

**Example**

_Total number of bedrooms does not equal 3._

```json
GET https://api.reso.org/Property?$filter=BedroomsTotal ne 3
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$filter=BedroomsTotal ne 3",
  "value": [
    {
      "ListingKey": "a2",
      "BedroomsTotal": 4,
      "ListPrice": 100000.00,
      "StreetName": "Main",
      "ModificationTimestamp": "2020-05-02T02:02:02.02Z",
      "ListingContractDate": "2020-05-02",
      "StandardStatus": "Active",
      "AccessibilityFeatures": ["AccessibleApproachWithRamp"]
    }
  ]
}
```

---

##### 2.5.9.4 Greater Than

[OData Documentation](http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_GreaterThan)
The `gt` operator returns `true` if the left operand is greater than the right operand, otherwise it returns `false`.

The special value `INF` is greater than any number, and any number is greater than `-INF`.

The Boolean value `true` is greater than `false`.

If any operand is `null`, the operator returns `false`.

**Example**

_List price is greater than $100,000.00._

```json
GET https://api.reso.org/Property?$filter=ListPrice gt 100000.00
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$filter=ListPrice gt 100000.00",
  "value": [
    {
      "ListingKey": "a3",
      "BedroomsTotal": 4,
      "ListPrice": 100000.01,
      "StreetName": "Main",
      "ModificationTimestamp": "2020-06-02T02:02:02.02Z",
      "ListingContractDate": "2020-06-02",
      "StandardStatus": "Closed",
      "AccessibilityFeatures": ["AccessibleApproachWithRamp", "AccessibleEntrance", "Visitable"]
    }
  ]
}
```

---

##### 2.5.9.5 Greater Than or Equal

[OData Documentation](http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_GreaterThanorEqual)
> The `ge` operator returns `true` if the left operand is greater than or equal to the right operand, otherwise it returns `false`.
> 
> See rules for `gt` and `eq` for details.

**Example**

_Modification timestamp is greater than or equal to May 22 2022 at midnight in UTC time._

```json
GET https://api.reso.org/Property?$filter=ModificationTimestamp ge 2021-05-22T00:00:00Z
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$filter=ModificationTimestamp ge 2021-05-22T00:00:00Z",
  "value": [
    {
      "ListingKey": "a4",
      "BedroomsTotal": 4,
      "ListPrice": 100000.01,
      "StreetName": "1st",
      "ModificationTimestamp": "2021-05-22T00:01:01.01.123Z",
      "ListingContractDate": "2021-05-01",
      "StandardStatus": "Active",
      "AccessibilityFeatures": ["Visitable"]
    }
  ]
}
```

---

##### 2.5.9.6 Less Than

[OData Documentation](http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_LessThan)
> The `lt` operator returns `true` if the left operand is less than the right operand, otherwise it returns `false`.
> 
> The special value `-INF` is less than any number, and any number is less than `INF`.
> 
> The Boolean value `false` is less than `true`.
>
>If any operand is `null`, the operator returns `false`.

**Example**

_Listing contract date is less than Jan 1 2021._

```json
GET https://api.reso.org/Property?$filter=ListingContractDate lt 2021-01-01
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$filter=ListingContractDate lt 2021-01-01
  "value": [
    {
      "ListingKey": "a5",
      "BedroomsTotal": 4,
      "ListPrice": 100000.01,
      "StreetName": "1st",
      "ModificationTimestamp": "2020-12-31T00:01:01.01.007Z",
      "ListingContractDate": "2020-12-31",
      "StandardStatus": "Closed",
      "AccessibilityFeatures": []
    }
  ]
}
```

---

##### 2.5.9.7 Less Than or Equal

[OData Documentation](http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_LessThanorEqual)
The `le` operator returns `true` if the left operand is less than or equal to the right operand, otherwise it returns `false`.

See rules for [`lt`](http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_LessThan) and [`eq`](http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_Equals) for details.

**Example**

_Listing contract date is less than or equal to Dec 31 2020._

```json
GET https://api.reso.org/Property?$filter=ListingContractDate le 2020-12-31
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$filter=ListingContractDate le 2020-12-31
  "value": [
    {
      "ListingKey": "a5",
      "BedroomsTotal": 4,
      "ListPrice": 100000.01,
      "StreetName": "1st",
      "ModificationTimestamp": "2020-12-31T00:01:01.01.007Z",
      "ListingContractDate": "2020-12-31",
      "StandardStatus": "Closed",
      "AccessibilityFeatures": []
    }
  ]
}
```

---

##### 2.5.9.8 Single Enumerations

These are single-valued lookups, such as the [StandardStatus](https://ddwiki.reso.org/display/DDW17/StandardStatus+Field) field.

There are two ways to express single enumerations in the RESO Web API Core specification:
* Edm.EnumType
* Edm.String, as outlined in [RCP-032](https://reso.atlassian.net/wiki/spaces/RESOWebAPIRCP/pages/2275152879)

`Edm.EnumType` enumerations are the most prevalent at the time of writing. 

RESO is transitioning to `Edm.String` enumerations and new implementations should follow that path.

---

###### 2.5.9.8.1 `Edm.EnumType` Enumerations
OData provides the `Edm.EnumType` data type to express enumerations. [More information](https://docs.oasis-open.org/odata/odata-csdl-xml/v4.01/odata-csdl-xml-v4.01.html#sec_EnumerationType).

The `Edm.EnumType` data type supports `has`, `eq`, and `ne` queries. 

The StandardStatus field is used in the examples in this section. 

Assume given server has the following XML Metadata:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<edmx:Edmx Version="4.0" xmlns:edmx="http://docs.oasis-open.org/odata/ns/edmx">
  <edmx:DataServices>
    <Schema Namespace="org.reso.metadata" xmlns="http://docs.oasis-open.org/odata/ns/edm">
      <EntityType Name="Property">
        <Key>
          <PropertyRef Name="ListingKey"/>
        </Key>
        <Property MaxLength="255" Name="ListingKey" Type="Edm.String"/>
        <Property Name="ListPrice" Precision="14" Scale="2" Type="Edm.Decimal"/>
        <Property Name="StandardStatus" Type="org.reso.metadata.enums.StandardStatus"/>
        <Property Name="ModificationTimestamp" Precision="27" Type="Edm.DateTimeOffset"/>
      </EntityType>
    </Schema>
    <Schema Namespace="org.reso.metadata.enums" xmlns="http://docs.oasis-open.org/odata/ns/edm">
      <EnumType Name="StandardStatus">
        <Member Name="Active"/>
        <Member Name="Closed"/>
        <Member Name="ComingSoon"/>
        <Member Name="Pending"/>
      </EnumType>
    </Schema>
  </edmx:DataServices>
</edmx:Edmx>
```

**`has` Operator**

The [OData has operator](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#_Toc31360967) is defined for items of `Edm.EnumType` as follows:

> The `has` operator returns `true` if the right operand is an enumeration value whose flag(s) are set on the left operand.
> 
> The `null` value is treated as unknown, so if one operand evaluates to `null`, the has operator returns `null`.

**Example**

_Find listings where StandardStatus is Active._

```json
GET https://api.reso.org/Property?$filter=StandardStatus has org.reso.metadata.enums.StandardStatus'Active'
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$filter=StandardStatus has org.reso.metadata.enums.StandardStatus'Active'",
  "value": [
    {
      "ListingKey": "a1",
      "BedroomsTotal": 2,
      "ListPrice": 100000.01,
      "StreetName": "Main",
      "ModificationTimestamp": "2020-06-02T02:02:02.02Z",
      "ListingContractDate": "2020-06-02",
      "StandardStatus": "Active",
      "AccessibilityFeatures": ["AccessibleEntrance", "Visitable"]
    }
  ]
}
```

_**Note**: one of the drawbacks of the OData `Edm.EnumType` data type is that it’s dependent on the namespace it was defined in. This is the reason the preceding query uses `org.reso.metadata.enums.StandardStatus'Active'` as part of the filter expression. There is no RESO standard for a single namespace to put standard enumerations in, so they vary among implementations. This is one reason RESO is migrating to `Edm.String` values instead, which don’t require a namespace._


**`eq` Operator**
[OData added support](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_PrimitiveLiterals) for the `eq` operator on `Edm.EnumType` in version 4.01. It is included in the Web API Core specification. The syntax is similar to the has operator, and right hand values MUST use the correct namespaces as well.

**Example**

_Find listings where StandardStatus is Active._

```json
GET https://api.reso.org/Property?$filter=StandardStatus eq org.reso.metadata.enums.StandardStatus'Active'
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$filter=StandardStatus eq org.reso.metadata.enums.StandardStatus'Active'",
  "value": [
    {
      "ListingKey": "a1",
      "BedroomsTotal": 2,
      "ListPrice": 100000.01,
      "StreetName": "Main",
      "ModificationTimestamp": "2020-06-02T02:02:02.02Z",
      "ListingContractDate": "2020-06-02",
      "StandardStatus": "Active",
      "AccessibilityFeatures": ["AccessibleEntrance", "Visitable"]
    }
  ]
}
```

**`ne` Operator**

[OData also added support](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_PrimitiveLiterals) for the `ne` operator on `Edm.EnumType` in version 4.01. It is included in the Web API Core specification. This allows consumers to filter on enumerations using `ne` rather than `not (has ...)`.

Right hand values MUST use correct namespaces.

**Example**

_Find listings where StandardStatus is not Active._

```json
GET https://api.reso.org/Property?$filter=StandardStatus ne org.reso.metadata.enums.StandardStatus'Active'
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$filter=StandardStatus ne org.reso.metadata.enums.StandardStatus'Active'",
  "value": [
    {
      "ListingKey": "a2",
      "BedroomsTotal": 3,
      "ListPrice": 100000.00,
      "StreetName": "1st",
      "ModificationTimestamp": "2020-07-02T02:02:02.02Z",
      "ListingContractDate": "2020-07-02",
      "StandardStatus": "ActiveUnderContract",
      "AccessibilityFeatures": []
    }
  ]
}
```

---


###### 2.5.9.8.2 `Edm.String` Enumerations

Support for string-based enumerations was added in Web API Core through the use of the Lookup resource, [as outlined in RCP-032](https://reso.atlassian.net/wiki/spaces/RESOWebAPIRCP/pages/2275152879).

This resource is still in DRAFT status. Please [contact RESO](mailto:dev@reso.org) if you are interested in being certified using `Edm.String` lookups.

---

##### 2.5.9.9 Multiple Enumerations

The Web API Core specification currently offers three ways to express multiple enumerations:
* [`Edm.EnumType`, with or without `IsFlags=true`](#TODO)
* [`Collection(Edm.EnumType)`](#TODO)
* [Collection(Edm.String)](#TODO)

The `IsFlags=true` method is not recommended for current implementations due to size limitations of the underlying data type and will be deprecated in future versions of the Web API. 

Currently, [RESO’s reference XML metadata](https://raw.githubusercontent.com/RESOStandards/web-api-commander/main/src/main/resources/RESODataDictionary-1.7.xml) uses `Collection(Edm.EnumType)` for normative examples of multiple enumerations.

RESO is in the process of transitioning to human-friendly string values using `Collection(Edm.String)` for multiple enumerations, [as outlined in RCP-032](https://reso.atlassian.net/wiki/spaces/RESOWebAPIRCP/pages/2275152879). New implementations are encouraged to take this approach. Please [contact RESO](mailto:dev@reso.org) if you are interested in being certified using string lookups.


---

###### 2.5.9.9.1 OData `IsFlags=true`

In the past, it was common for implementations to use OData IsFlags enumerations. While this type is still supported for backwards compatibility, multiple enumerations should use `Collection(Edm.EnumType)` or `Collection(Edm.String)` instead.

The current [RESO XML reference metadata](https://raw.githubusercontent.com/RESOStandards/web-api-commander/main/src/main/resources/RESODataDictionary-1.7.xml) uses `Collection(Edm.EnumType)`.

One of the main reasons the `IsFlags=true` approach is being deprecated is that if the OData specification were followed strictly, it limits the total number of possible values to 64. 

To understand why this is the case, OData uses an underlying type of at most `Edm.Int64` to represent flag based enumerations. The design of the `IsFlags=true` lookup suggests that bitwise comparisons across multiple entries should be possible using this approach, meaning that if each item in the list is mutually exclusive there are only 64 choices.

The [OData specification](https://docs.oasis-open.org/odata/odata-csdl-xml/v4.01/odata-csdl-xml-v4.01.html#sec_FlagsEnumerationType) shows the following example for Enumeration Types:

```xml
<EnumType Name="Pattern" UnderlyingType="Edm.Int32" IsFlags="true">
  <Member Name="Plain"             Value="0" />
  <Member Name="Red"               Value="1" />
  <Member Name="Blue"              Value="2" />
  <Member Name="Yellow"            Value="4" />
  <Member Name="Solid"             Value="8" />
  <Member Name="Striped"           Value="16" />
  <Member Name="SolidRed"          Value="9" />
  <Member Name="SolidBlue"         Value="10" />
  <Member Name="SolidYellow"       Value="12" />
  <Member Name="RedBlueStriped"    Value="19" />
  <Member Name="RedYellowStriped"  Value="21" />
  <Member Name="BlueYellowStriped" Value="22" />
</EnumType>
```

Notice how Red has a value of 1 (2<sup>0</sup>), Blue has a value of 2 (2<sup>1</sup>), and Striped has a value of 16 (2<sup>4</sup>), which is equivalent to the value of RedBlueStriped, with a value of 19 (0001 0011).

The underlying value in the payload from the example above would be 19, the `Edm.Int64` representation of the value defined in the lookup. This MUST match what’s defined in the server metadata.

RESO does not explicitly validate bitmapped values to ensure that lookup choices do not overlap. 


**`has` Operator**

The [OData `has` operator](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#_Toc31360967) is defined for items of `Edm.EnumType` as follows:

> The `has` operator returns true if the right operand is an enumeration value whose flag(s) are set on the left operand.
> 
> The `null` value is treated as unknown, so if one operand evaluates to `null`, the has operator returns  `null`.

**Example**

__Find listings with AccessibleEntrance in the AccessibilityFeatures field.__

Assume AccessibleEntrance is defined with an underlying value of 4:

```json
GET https://api.reso.org/Property?$filter=AccessibilityFeatures has org.reso.metadata.enums.AccessibilityFeatures'AccessibleEntrance'
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$filter=AccessibilityFeatures has org.reso.metadata.enums.AccessibilityFeatures'AccessibleEntrance'",
  "value": [
    {
      "ListingKey": "a1",
      "BedroomsTotal": 2,
      "ListPrice": 100000.01,
      "StreetName": "Main",
      "ModificationTimestamp": "2020-06-02T02:02:02.02Z",
      "ListingContractDate": "2020-06-02",
      "StandardStatus": "Active",
      "AccessibilityFeatures": "AccessibleBedroom,AccessibleDoors"
    }
  ]
}
```

---

###### 2.5.9.9.2 Collection of `Edm.EnumType`

The RESO Web API Core specification allows for multiple enumerations to be defined in terms of collections of OData `Edm.EnumType` definitions. 

While this approach is not well documented in OData reference material, it is nonetheless valid and was previously offered in order to overcome the [64-value limitation of IsFlags enumerations](#TODO).

Let’s consider the [AccessibilityFeatures](https://ddwiki.reso.org/display/DDW17/AccessibilityFeatures+Field) field, which is defined as follows in the [RESO reference XML metadata](https://raw.githubusercontent.com/RESOStandards/web-api-commander/main/src/main/resources/RESODataDictionary-1.7.xml):

```xml
...
  <EntityType Name="Property">
    ...
    <Property Name="AccessibilityFeatures" Type="Collection(org.reso.metadata.enums.AccessibilityFeatures)" />
    ...
  </EntityType>
  ...
  <EnumType Name="AccessibilityFeatures">
    <Member Name="AccessibleEntrance"/>
    <Member Name="AccessibleFullBath"/>
    <Member Name="AccessibleHallways"/>
    <Member Name="AccessibleKitchen"/>
  </EnumType>
  ...
```

**Collection Queries**

Multiple enumerations with the `Collection(Edm.EnumType)` data type use `any()` and `all()` lambda operators rather than the `has` operator, as outlined in `IsFlags` Enumerations.

Similar to other `Edm.EnumType` definitions, queries rely on namespaces being present, when defined.

From the [OData specification](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#_Toc31361024):

> OData defines two operators that evaluate a Boolean expression on a collection. Both must be prepended with a navigation path that identifies a collection.
> 
> 4.01 Services MUST support case-insensitive lambda operator names. Clients that want to work with 4.0 services MUST use lower case lambda operator names.
> 
> The argument of a lambda operator is a case-sensitive lambda variable name followed by a colon (:) and a Boolean expression that uses the lambda variable name to refer to properties of members of the collection identified by the navigation path.
> 
> If the name chosen for the lambda variable matches a property name of the current resource referenced by the resource path, the lambda variable takes precedence. Clients can prefix properties of the current resource referenced by the resource path with [`$it`](https://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part2-url-conventions.html#sec_it).
> 
> Other path expressions in the Boolean expression neither prefixed with the lambda variable nor $it are evaluated in the scope of the collection instances at the origin of the navigation path prepended to the lambda operator.


**`any()` Operator**

> The any operator applies a Boolean expression to each member of a collection and returns `true` if and only if the expression is true for any member of the collection, otherwise it returns `false`. This implies that the any operator always returns `false` for an empty collection.
> 
> The `any` operator can be used without an argument expression. This short form returns `false` if and only if the collection is empty.

**Example**

_Find listings where AccessibilityFeatures has AccessibleEntrance, including other values:_

```json
GET https://api.reso.org/Property?$filter=AccessibilityFeatures/any(enum:enum eq org.reso.metadata.enums.AccessibilityFeatures'AccessibleEntrance')
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$filter=AccessibilityFeatures/any(enum:enum eq org.reso.metadata.enums.AccessibilityFeatures'AccessibleEntrance')",
  "value": [
    {
      "ListingKey": "a1",
      "BedroomsTotal": 3,
      "ListPrice": 100000.00,
      "StreetName": "Main",
      "ModificationTimestamp": "2020-04-02T02:02:02.02Z",
      "ListingContractDate": "2020-04-02",
      "StandardStatus": "ActiveUnderContract",
      "AccessibilityFeatures": ["AccessibleApproachWithRamp", "AccessibleEntrance", "Visitable"]
    }
  ]
}
```

**`all()` Operator**

> The `all` operator applies a Boolean expression to each member of a collection and returns `true` if the expression is true for all members of the collection, otherwise it returns `false`. This implies that the `all` operator always returns `true` for an empty collection.
> 
> The `all` operator cannot be used without an argument expression.

**Example**

_Find all listings with only the AccessibilityFeatures Visitable flag set:_

```json
GET https://api.reso.org/Property?$filter=AccessibilityFeatures/all(enum:enum eq org.reso.metadata.enums.AccessibilityFeatures'Visitable')
HTTP/2 200 OK

{
  "@odata.context": "https://api.reso.org/Property?$filter=AccessibilityFeatures/all(enum:enum eq org.reso.metadata.enums.AccessibilityFeatures'Visitable')",
  "value": [
    {
      "ListingKey": "a39",
      "BedroomsTotal": 3,
      "ListPrice": 100000.00,
      "StreetName": "Main",
      "ModificationTimestamp": "2020-04-02T02:02:02.02Z",
      "ListingContractDate": "2020-04-02",
      "StandardStatus": "ActiveUnderContract",
      "AccessibilityFeatures": ["Visitable"]
    }
  ]
}
```

---

###### 2.5.9.9.3 Collection of `Edm.String`

Support for string-based enumerations was added in Web API Core through the use of the Lookup resource, [as outlined in RCP-032](https://reso.atlassian.net/wiki/spaces/RESOWebAPIRCP/pages/2275152879).

This resource is still in DRAFT status. Please [contact RESO](mailto:dev@reso.org) if you are interested in being certified using `Edm.String` lookups.

---

### 2.6 Response Message Bodies

TODO

---

### 2.7 Standard Resources

TODO

---

### 2.8 Core Query Examples

TODO

---

### 2.9 Security

TODO

---

## Section 3: Authors

TODO

---

## Section 4: References

TODO

---

## Section 5: Appendices

TODO

---

## Section 6: Revision List

TODO

---



