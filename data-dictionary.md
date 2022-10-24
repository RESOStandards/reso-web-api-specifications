# RESO Data Dictionary Endorsement

| **RCP** | 36 |
| :--- | :--- |
| **Version** | 1.7 |
| **Authors** | [Joshua Darnell](https://github.com/darnjo) ([RESO](mailto:josh@reso.org)) |
| **Status** | **RATIFIED** |
| **Written** | June 2020 |
| **Ratified** | December 2020 |
| **Dependencies** | [Web API Core 2.0.0+](./web-api-core.md) |
| **Related Links** | [DD Wiki 1.7](https://ddwiki.reso.org/display/DDW17/RESO+Data+Dictionary+1.7)<br />[Data Dictionary 1.7 Spreadsheet](https://docs.google.com/spreadsheets/d/1_59Iqr7AQ51rEFa7p0ND-YhJjEru8gY-D_HM1yy5c6w/edit?usp=sharing) |

The Data Dictionary endorsement defines models for use in the RESO domain. These include Resources, Fields, Lookups, and Relationships between Resources. The Data Dictionary may use the RESO Web API or RESO's Common Schema JSON format for transport.


<br /><br />

# RESO End User License Agreement (EULA)

This End User License Agreement (the "EULA") is entered into by and between the Real Estate Standards Organization ("RESO") and the person or entity ("End User") that is downloading or otherwise obtaining the product associated with this EULA ("RESO Product"). This EULA governs End Users use of the RESO Product and End User agrees to the terms of this EULA by downloading or otherwise obtaining or using the RESO Product.

<br /><br />

# Table of Contents
- [Summary of Changes](#summary-of-changes)
- [Introduction](#introduction)
- [Section 1: Purpose](#section-1-purpose)
- [Section 2: Specification](#section-2-specification)
- [Section 3: Certification](#section-3-certification)
- [Section 4: Contributors](#section-4-contributors)
- [Section 5: References](#section-5-references)
- [Section 6: Appendices](#section-6-appendices)
- [Section 7: License](#section-7-license)

<br /><br />

# Summary of Changes

The majority of the Data Dictionary 1.7 Specification was unchanged since initially ratified. 

A summary of the changes from the previous testing rules is as follows:
* **Data Type Mappings**: A specification ([RCP-031](https://members.reso.org/display/RESOWebAPIRCP/RCP+-+WEBAPI-031+Data+Dictionary+Representation+in+the+Web+API)) was created to normalize Data Dictionary type mappings in the Web API, as [described here](https://members.reso.org/pages/viewpage.action?pageId=67962918#RCP-WEBAPI-031DataDictionaryRepresentationintheWebAPI-2.6.1DictionaryandTransportTypeMappingsandAttributes) and summarized in [this table](https://members.reso.org/pages/viewpage.action?pageId=67962918#RCP-WEBAPI-031DataDictionaryRepresentationintheWebAPI-DataTypeMappings.1). This was done to improve the predictability of data formats during transport. _See the section on [*Data Type mappings*](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.ytsgiaioc8hv) for more information_.
* **IDX Payload Nomenclature**: Previously, terminology included _IDX_Must_, _IDX_Optional_, etc., which have all been consolidated under the IDX label. In general, Payloads have been streamlined and now [each field indicates which payloads it belongs to](https://docs.google.com/spreadsheets/d/1SZ0b6T4_lz6ti6qB2Je7NSz_9iNOaV_v9dbfhPwWgXA/edit#gid=16571180&range=R:R) in a binary fashion, such as *IDX* or *BBO*. 
* **Data Sampling**: As of August 31, 2021, data sampling is also part of the Data Dictionary 1.7 Endorsement to ensure that what's available on a given server matches what's advertised and that the data conforms to the Data Dictionary specification, where applicable. 

<br /><br />

# Introduction
The RESO Data Dictionary defines the set of data elements available within RESO's domain. These consist of _resources_, _fields_, and _enumerations_, also known as _lookups_.

This document outlines what the Data Dictionary is and how it maps to the RESO Web API transport layer.

<br /><br />

# Section 1: Purpose
The primary goal of the RESO Data Dictionary is interoperability through the consistent use of standard data elements. 

While the Web API Server specification ensures that servers can talk to each other in a uniform manner, if they are using different fields to represent the same data, it causes additional effort where mapping is concerned. This means products that need to interoperate between systems will be slow to market and complex. 

The point of the RESO Data Dictionary is to give data consumers and producers a common language to exchange data with.

<br /><br />

# Section 2: Specification
## Overview 
The RESO Data Dictionary consists of three main sets of data elements:
* **Resources**: coarse-grained groupings where data is kept. For example, the Property resource contains information about a given property, including its listings when present. Resources contain _fields_ and _lookups_.
* **Fields**: data elements where atomic values can exist. ListPrice is a field within the Property resource where a given listing's price would exist if it were available in the data set. Fields have data types such as Strings or Timestamps. 
* **Lookups**: pre-defined values a given field can have as part of its definition. StandardStatus has allowed values of Active and Pending. These are also called enumerations, which can be closed or open with or without values defined. Closed enumerations MUST only contain their defined values. Others are open to extension if a similar value isn't already defined.

## Data Dictionary Spreadsheet

The Data Dictionary specification is defined [as a spreadsheet](https://docs.google.com/spreadsheets/d/1SZ0b6T4_lz6ti6qB2Je7NSz_9iNOaV_v9dbfhPwWgXA/edit?usp=sharing), where each newly adopted version produces its own spreadsheet when ratified.

This worksheet is divided into three main sections:
* **Resource Sheets**: define each given resource in the Data Dictionary, such as Property, Member, Office, or Media. These contain field definitions, which have data types and other attributes.
* **Lookup Fields and Values**: this sheet is a one-to-many collection of all the lookups defined in the Data Dictionary, referred to by their "Lookup Field" (which is really their grouping). There are two kinds of fields that use these lookups from the other resource sheets, those with Simple Data Types of _String List, Single_ and _String List, Multi_.
* **Standard Relationships**: define nested relationships a given resource might have. These relationships affect a payload's data shape when related resources are joined together. These can either be one-to-one relationships where a single item is expanded into another, such as the case of Member expanded into Property as BuyerAgent, or they can be one-to-many relationships such as Media expanded into a Property record to show all of a given listing's photos. 

<br /><br />

# Section 3: Certification
[Link to Original Document](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit)

When standards are approved for the RESO Data Dictionary, those changes are stored in a format that allows their corresponding testing rules to be generated automatically, which ensures consistency with Data Dictionary and Web API specifications. This also allows for new versions of the testing tool to be created almost immediately when Data Dictionary standards are passed.

Robust statistics are created through the use of the RESO Data Dictionary application, which are then ingested into a real-time analytics framework that lets users see industry-wide statistics about resources, fields, and enumerations. This information can be used to inform decisions about standardization and data mapping between RESO certified servers.

## Background

The RESO Data Dictionary testing tool ensures compliance with RESO Data Dictionary definitions of resources, fields, and enumerations. Nonstandard or "local" data elements are also allowed, provided Data Dictionary resources are used whenever present on a given server and when metadata for any additional items are in a supported and valid transport format.
Resources are top-level containers in the RESO ecosystem. Some examples are [*Property*](https://ddwiki.reso.org/display/DDW17/Property+Resource), [*Member*](https://ddwiki.reso.org/display/DDW17/Member+Resource), [*Office*](https://ddwiki.reso.org/display/DDW17/Office+Resource), [*Media*](https://ddwiki.reso.org/display/DDW17/Media+Resource)*, and* [*OpenHouse*](https://ddwiki.reso.org/display/DDW17/OpenHouse+Resource). 
Fields exist within a given resource and have name and type definitions that must be adhered to in order to be considered compliant. In the case of [*Property*](https://ddwiki.reso.org/display/DDW17/Property+Resource), examples of fields are [*ListPrice*](https://ddwiki.reso.org/display/DDW17/ListPrice+Field), [*ModificationTimestamp*](https://ddwiki.reso.org/display/DDW17/ModificationTimestamp+Field), etc. Fields don't exist on their own in the metadata. They will always be contained within a top-level resource definition that MUST match RESO Standard Resource definitions when they exist.

## Testing Framework

Data Dictionary Certification is provided by the [RESO Commander](https://github.com/RESOStandards/web-api-commander). 
The RESO Commander is an open source, cross-platform Java library created by RESO that uses established community libraries, such as the Apache Olingo OData Client, XML parsers, and JSON Schema Validators, to provide a testing API.


Acceptance tests define the requirements applicants are expected to meet in order to achieve certification. Data Dictionary acceptance tests are written in a high-level language (DSL) called [Gherkin](https://cucumber.io/docs/gherkin/reference/). This is part of a [Behavior Driven Development](https://en.wikipedia.org/wiki/Behavior-driven_development) (BDD) platform called [Cucumber](https://cucumber.io/), which allows for the expression of testing workflows using a natural language that is intended to be accessible to business analysts and QA testers in addition to programmers. 

Acceptance tests are automatically generated from the adopted Data Dictionary spreadsheet for each given version of the specification, and can target any version of the Data Dictionary from 1.0 onwards. 

The benefit of this strategy is that when a new Data Dictionary version is ratified, the tests may be generated and testing can begin right away, significantly reducing tool development time and adoption of the standard.

A command-line interface (CLI) has been provided for local testing. This provides the environment to be used for certification and self-assessment, as well as that needed to run the automated testing tools in a continuous integration and deployment (CI/CD) pipeline, on platforms such as [GitHub CI](https://help.github.com/en/actions/language-and-framework-guides/building-and-testing-java-with-gradle), [Jenkins](https://cucumber.io/docs/guides/continuous-integration/), [Travis](https://docs.travis-ci.com/user/languages/java/), or [CircleCI](https://circleci.com/blog/getting-started-with-cucumber-on-circleci/), to help prevent regressions in a RESO-certified codebase.

A graphical user interface (GUI) is also available through popular and free Integrated Development Environment (IDE) plugins for [IntelliJ](https://www.jetbrains.com/help/idea/enabling-cucumber-support-in-project.html) and [Eclipse](https://cucumber.github.io/cucumber-eclipse/). IDEs provide an enhanced testing experience, with better informational messages and the ability to easily run and debug each test step, when needed. The availability of plugins saves significant time in testing, development, and certification. The level of community support is one of the reasons open source tools were chosen as a testing platform.

## Testing Methodology

RESO Data Dictionary certification is based on adherence to: a) Resource, Field, and Lookup definitions outlined in each approved RESO Data Dictionary spreadsheet ([1.7 at the time of publication](https://docs.google.com/spreadsheets/d/1SZ0b6T4_lz6ti6qB2Je7NSz_9iNOaV_v9dbfhPwWgXA/edit?usp=sharing)), b) Transport requirements regarding [authentication](https://members.reso.org/display/RESOWebAPIRCP/RCP+-++WEBAPI-026+Change+Default+Certification+Testing+to+Bearer+Token) and OData conformance, and c) conformance with Data Dictionary to Web API data mappings [outlined later in this document](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.ytsgiaioc8hv), as well as in [RCP-031](https://members.reso.org/display/RESOWebAPIRCP/RCP+-+WEBAPI-031+Data+Dictionary+Representation+in+the+Web+API) (RESO login required).

### Configuring the Test Client

The starting point is for applicants to create a configuration file in RESOScript (XML) format which contains credentials and a server's RESO Web API endpoint. A sample RESOScript file and instructions for how to use it will be provided with the initial release of the testing tool.

<br />

### Metadata Request Using RESO Standard Authentication

When testing begins, an HTTP request is made to an applicant's given service location with either OAuth2 [Bearer Tokens](https://oauth.net/2/bearer-tokens/) or [Client Credentials](https://oauth.net/2/grant-types/client-credentials/). Both of these authentication strategies allow for data consumption to be machine automated so that additional interaction from a user isn't necessary during the authentication process. As such, the RESO Data Dictionary Commander can be used for automated testing. 
The metadata request is expected to function according to the OData specification in terms of [request](http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part1-protocol.html#_Toc31358863) and [response](http://docs.oasis-open.org/odata/odata/v4.01/odata-v4.01-part1-protocol.html#_Toc31358882) headers and response formats. RESO specifically uses an [XML version of OData metadata](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752500), which contains an Entity Data Model (EDM) and model definitions, and is often referred to as EDMX.

### OData Metadata Validation

#### Syntax Checking

Metadata returned from a RESO Web API server are checked for XML validity as well as validated against Entity Data Model (EDM) and EDMX [definitions published by OASIS](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/schemas/), the creators of the OData specification. If metadata are invalid for any reason, Data Dictionary testing will halt.

#### Semantic Checking

After metadata syntax has been validated, declared data models are checked for correctness. For example, if a given server declares support for the RESO *Property* resource, then the RESO Commander will look for an OData EntityType definition for *Property*. If the underlying data model is not found, metadata validation will fail with a diagnostic message to help users understand why a given error occurred. Once the model is found, its field and enumeration definitions will be checked for correctness as well.
Another aspect of semantic checking is ensuring that all models have keys so they can be indexed, meaning that a data request can be made to the server by key. This is a basic requirement for fetching data from a server.

### RESO Certification

Several requirements must be met during Data Dictionary testing to ensure conformance with RESO Certification rules.

#### Conformance with the RESO Standard Data Model

In this step, tests that have been generated from a given adopted RESO Data Dictionary version are run to locate and verify resources, fields, and enumerations contained within a server's metadata. This phase of testing is designed to test that items declared in the metadata using RESO Standard Field Names are consistent with the Data Dictionary definitions for those items.

#### Resources

Standard Resources MUST be expressed using RESO Standard Resource Names. For instance, *Property* would be used rather than *Properties* otherwise they will not be counted. These will be verified during the certification process. 

For each RESO Standard Resource found, its standard fields and lookups will be verified. Normative resource names for any Standard Resource can be found in the [RESO DDWiki](https://ddwiki.reso.org/display/DDW17/).

#### Fields

Fields have both [naming](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.194xc45smnwr) and [data type mapping](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.ytsgiaioc8hv) requirements. 

Implementers are allowed to commingle their own fields and data types alongside RESO standard fields, but standard fields MUST match their [Data Dictionary type definition mappings](https://members.reso.org/pages/viewpage.action?pageId=67962918#RCP-WEBAPI-031DataDictionaryRepresentationintheWebAPI-2.6.1DictionaryandTransportTypeMappingsandAttributes).

#### Standard Field Names

RESO Standard Fields MUST be named in accordance with the Data Dictionary definitions of those fields when present on a given server instance..

For example, if a server presents a [*Property*](https://ddwiki.reso.org/display/DDW17/Property+Resource) resource and list price field data are present, they MUST be conveyed as *ListPrice*. Local fields SHOULD use the same naming conventions, when practical. There may be reasons to use nonstandard field names, such as for backwards compatibility, but they MUST pass [OData validation](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752675).

Variations such as *Price* or any Data Dictionary synonym of the ListPrice field such as *AskingPrice* will fail. 

Various techniques are used to find potential matches with Data Dictionary definitions of resources, fields, and enumerations that don't conform to the RESO Definitions of these items. *See* [*Additional Compliance Checking*](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.yuwj1yg0uj1n) *for more information*.

Additional requirements for Standard Fields are [outlined in section on Data Type Mappings](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.ytsgiaioc8hv).

#### Standard Display Names

**Note:** _RESO Standard Display Names are not being tested at the current time. They had previously been tested but were not meant to have been a standard way to convey information about *which field* *or lookup* is intended at the transport level. [Standard Field Names](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.194xc45smnwr) and [Lookup Values](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.k0yrypywv6ms) MUST be used for this purpose instead._

There is a proposal in progress in the RESO Data Dictionary and Transport workgroups to add further testing requirements for Display Names, which will most likely have its own Endorsement. 

[There is a MAY specification](https://members.reso.org/display/API2/2.4.8+Annotations) (RESO login required) for both *StandardName* and *MlsName* annotations that supports special characters, since OData fields and enumerations don't allow them. *Vendors may still use existing display name annotations as long as they pass the* [*metadata validation process*](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.evm2d6urqz93)*.*

#### Lookups

Underlying OData enumerations for Data Dictionary lookups MUST adhere to the naming conventions outlined in the [OData specification](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752675) and map to the correct types, as outlined in the [Data Type Mappings section](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.ytsgiaioc8hv).

Standard LookupValues are provided [in the Data Dictionary 1.7 Spreadsheet](https://docs.google.com/spreadsheets/d/1SZ0b6T4_lz6ti6qB2Je7NSz_9iNOaV_v9dbfhPwWgXA/edit#gid=585857157&range=B:B). They are not required, but are intended to serve as a guide for those using OData. 

**DEPRECATION NOTICE**: RESO will eventually be deprecating OData `IsFlags` enumerations in favor of the Lookup resource in a future version of the Data Dictionary. This change will come with a major version bump, and perhaps be part of Data Dictionary 2.0, TBD. See [RCP-032](https://members.reso.org/display/RESOWebAPIRCP/RCP+-+WEBAPI-032++Lookup+and+RelatedLookup+Resources+for+Lookup+Metadata) for more information.

### Data Type Mappings

The following mappings apply to the RESO Data Dictionary and Web API specifications. 
Data Dictionary data types shown in the following table are contained in the *SimpleDataType* column of the adopted Data Dictionary 1.7 spreadsheet, for instance [those for the Property Resource](https://docs.google.com/spreadsheets/d/1SZ0b6T4_lz6ti6qB2Je7NSz_9iNOaV_v9dbfhPwWgXA/edit#gid=16571180&range=E:E).

| Data Dictionary (1.6+) | Web API Core (1.0.2+)                                        |
| ---------------------- | ------------------------------------------------------------ |
| Boolean                | Edm.Bool                                                     |
| Collection             | Related Resource Expansion, e.g. PropertyRooms or Units expanded into the Property resource. **Requires $expand Endorsement.** |
| Date                   | Edm.Date                                                     |
| Number                 | Edm.Decimal **OR** Edm.Double for decimal values; Edm.Int64 **OR** Edm.Int32 **OR** Edm.Int16 for integers. |
| String                 | Edm.String                                                   |
| String List, Single    | **EITHER** Edm.EnumType **OR** Edm.String                            |
| Sting List, Multi      | **EITHER** Collection(Edm.EnumType) **OR** Edm.EnumType with IsFlags="true" **OR** Collection(Edm.String) |
| Timestamp              | Edm.DateTimeOffset                                           |

Each data type mapping has a corresponding Cucumber BDD acceptance test template that enforces the rules of a given type.

### Acceptance Test Templates

#### Boolean

Boolean values are mapped to the [Edm.Bool](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752635) data type and MUST contain a literal value of "true" or "false" when returned in a payload for a given Boolean field, which is enforced by the RESO Commander. Boolean fields MAY be null as any OData field is nullable. Null values are interpreted as "false."

**Sample Test**

```gherkin
  Scenario: AdditionalParcelsYN
    When "AvailabilityDate" exists in the "Property" metadata
    Then "AvailabilityDate" MUST be "Date" data type
```

#### Collection

**Note**: *Collections are not yet supported in the Data Dictionary or Web API Specifications for types other than Edm.EnumType. Collections in the Data Dictionary mean expanded resources, which will not be tested until the $expand Endorsement has been created.*

Collection data types are used in the Data Dictionary to indicate *possible expansions*, which use the OData [Edm.Collection type](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752651) to present a collection of instances of a given type, such as Media items related to a Property record.

RESO will not be certifying this data type for related Data Dictionary Resources and until the Expand Endorsement has been created. Vendors MAY use OData $expand functionality on their servers as long as server metadata pass OData validation. 

Standard Relationships have been provided in the adopted [Data Dictionary spreadsheet](https://docs.google.com/spreadsheets/d/1SZ0b6T4_lz6ti6qB2Je7NSz_9iNOaV_v9dbfhPwWgXA/edit#gid=266511010) to and [reference metadata](https://github.com/RESOStandards/web-api-commander/blob/58485cc04f24e464c6c1313d25428d43835d7668/src/main/resources/DDv1.7-StandardAndDisplayNames-20200922210930847.edmx) to guide vendors in the meantime. It's also worth noting that If a property definition for a Collection is nullable, it means that collection members are nullable. If there are no items in a given collection, the field would return an empty collection, but the field itself may not be null (by the OData specification).

#### Date

Date data types use the OData [Edm.Date](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752636) data type. Dates are expected to be in the format "yyyy-mm-dd" and should not include time zone offsets. For dates with time zone support, see [Timestamp](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.hhsogyonctqf).

**Sample Test**

```gherkin
  Scenario: AvailabilityDate
    When "AvailabilityDate" exists in the "Property" metadata
    Then "AvailabilityDate" MUST be "Date" data type
```

#### Number

Numbers may either be Integers or Decimals. 

##### Integers

Numbers without Scale and Precision are treated as Integers in the Data Dictionary.

Integers are expected to be expressed using the OData [Edm.Int](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752643) data type and MUST NOT contain length, precision, or scale attributes.

**Sample Test**

```gherkin
  Scenario: BathroomsFull
    Given that the following synonyms for "BathroomsFull" DO NOT exist in the "Property" metadata
      | FullBaths |
    When "BathroomsFull" exists in the "Property" metadata
    Then "BathroomsFull" MUST be "Integer" data type
```

***Note**:* *Synonyms testing is shown in the last line of the above example and is discussed further in a* [*subsequent section*](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.tcs2aspdfr41)*.*

##### Decimals

Decimals are expected to be [Edm.Decimal or Edm.Double](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752517) according to the [Data Dictionary Type Mappings](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.ytsgiaioc8hv). They MAY contain Precision and Scale attributes, as described by the entity data model type definition, which also MAY be omitted. 

If the vendor declares Precision and Scale attributes, they SHOULD match those defined by the Data Dictionary but this is not an absolute requirement. Suggested values are provided in the Data Dictionary specification but they are not mandatory at this time. This is reflected in the BDD acceptance tests.

**Sample Test**

```gherkin
  Scenario: BuildingAreaTotal
    When "BuildingAreaTotal" exists in the "Property" metadata
    Then "BuildingAreaTotal" MUST be "Decimal" data type
    And "BuildingAreaTotal" precision SHOULD be equal to the RESO Suggested Max Precision of 14
    And "BuildingAreaTotal" scale SHOULD be equal to the RESO Suggested Max Scale of 2
```

**Note:** *The Data Dictionary contains* [*references to Length and Precision*](https://ddwiki.reso.org/display/DDW17/Data+Dictionary+Terms+and+Meta+Definitions#DataDictionaryTermsandMetaDefinitions-SugMaxLength) *which have been found to be inaccurate with respect to standard definitions of decimal numbers. It uses Length and Precision to mean Precision and Scale, respectively. These items have been corrected in the code generation for decimal acceptance tests.*

##### String

String values use the OData [Edm.String](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752644) data type. These strings represent a sequence of UTF-8 characters. String data types MAY specify a length attribute that specifies the length of a string a given server supports. The length property is not required by OData and may be omitted.

RESO provides recommended best practices for these lengths, and applicants will be informed when their length definitions don't match the RESO definitions, but will not fail certification in these cases.

**Sample Test**

```gherkin
  Scenario: AboveGradeFinishedArea
    When "AboveGradeFinishedArea" exists in the "Property" metadata
    Then "AboveGradeFinishedArea" MUST be "Decimal" data type
    And "AboveGradeFinishedArea" precision SHOULD be equal to the RESO Suggested Max Precision of 14
    And "AboveGradeFinishedArea" scale SHOULD be equal to the RESO Suggested Max Scale of 2
```

#### String List, Single

The current RESO Web API specification uses the OData [Edm.EnumType](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752566) for single enumerations. As such, Data Dictionary items use this data type as well.

These items are similar to fields in that they MUST follow [OData field naming conventions](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752675). Enumerations not following these conventions will fail certification in the [metadata validation step](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.wmz1dhpkgqg5).

**Sample Test**

```gherkin
  Scenario: AboveGradeFinishedAreaSource
    When "AboveGradeFinishedAreaSource" exists in the "Property" metadata
    Then "AboveGradeFinishedAreaSource" MUST be "Single Enumeration" data type
```

#### String List, Multi

As of Web API 1.0.2 Core, there are two formats allowed for String List, Multi. 

#### Edm.EnumType with IsFlags="true"

The Web API Server Core 1.0.2 specification [outlines the use](https://members.reso.org/display/API2/2.4.10+Multi-Valued+Lookups) of the OData [Edm.EnumType](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752566) data type with the [IsFlags="true"](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752569) attribute set to signify that a given field supports multivalued enumerations. Applicants using this format will still be able to be certified.

#### Collection(Edm.EnumType)

As there are limitations to the IsFlags approach in cases where multi-select items contain more than 64 distinct values, support for Collections(Edm.EnumType) was added to the [Data Dictionary Type Mappings](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.ytsgiaioc8hv) and backported to the Web API 1.0.2 Core specification to be used instead. 

The following sample test covers both representations:

**Sample Test**

```gherkin
Scenario: CommonWalls
    When "CommonWalls" exists in the "Property" metadata
    Then "CommonWalls" MUST be "Multiple Enumeration" data type
```

#### Timestamp

Timestamps are expected to use the OData [edm:DateTimeOffset](http://docs.oasis-open.org/odata/odata/v4.0/errata03/os/complete/part3-csdl/odata-v4.0-errata03-os-part3-csdl-complete.html#_Toc453752637) data type. This represents an [ISO 8601 compliant](https://en.wikipedia.org/wiki/ISO_8601) date that includes support for both fractional seconds and time zones. The edm:DateTimeOffset doesn't have any additional length, precision, or scale attributes. Data conveyed using this format is expected to match the [date timestamp data type in the W3C specification](https://www.w3.org/TR/xmlschema11-2/#dateTimeStamp).

**Sample Test**

```gherkin
  Scenario: ModificationTimestamp
    Given that the following synonyms for "ModificationTimestamp" DO NOT exist in the "Property" metadata
      | ModificationDateTime |
      | DateTimeModified |
      | ModDate |
      | DateMod |
      | UpdateDate |
      | UpdateTimestamp |
    When "ModificationTimestamp" exists in the "Property" metadata
    Then "ModificationTimestamp" MUST be "Timestamp" data type
```

### Lookups Resource and Location-Based Fields

After further discussion in the Transport and Certification subgroups, certain lookups will allowed to be Edm.String for String List, Single, or Collection(Edm.String) for String List, Multi, pending further discussion of Lookups, as outlined in [RCP-032](https://members.reso.org/display/RESOWebAPIRCP/RCP+-+WEBAPI-032++Lookups+Resource+for+Enumeration+Metadata). 

Note that RCP-032 started off as being specifically for location-based lookups, such as City and CountyOrParish, and has potentially been expanded to include any Lookup. 

Testing requirements will be added pending approval of a Lookups Resource by the Certification Subgroup and Transport Workgroup. This has also been noted in the section on [Data Type Mappings](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.ytsgiaioc8hv). Depending on the progress in the groups, the allowance for string-based lookups may precede testing rules for a general Lookups resource.

### Additional References

The current version of the generated BDD acceptance tests from which the Sample BDD Tests above were taken from [may be found here](https://github.com/RESOStandards/web-api-commander/blob/58485cc04f24e464c6c1313d25428d43835d7668/src/main/java/org/reso/certification/features/data-dictionary/v1-7-0/). Note that this link will be updated once the Data Dictionary 1.7 testing tool codebase has been merged into the main branch.

### Additional Compliance Checking

In addition to finding exact matches for Standard Resources, Fields, and Lookups, algorithmic techniques and heuristics will be used to determine potential matches with the RESO Data Dictionary standard.

In contrast with the other testing methodologies outlined in this document, the techniques used for additional compliance checking exist to enforce the stated policy that data being presented MUST match the RESO Data Dictionary format when they exist on the server. These methods will continue to be refined over time.

The methods will be published along with the Data Dictionary testing tool for transparency, community review, and to allow self-assessment by applicants prior to RESO Certification.

Informational messages will be generated in cases where potential matches with an existing Data Dictionary definition is found. 

Some of the techniques used are described in the following sections.

#### Synonym Matching

The metadata for a given server is checked for synonyms at the resource and field level.

Synonyms MUST NOT be used at the resource or field level. If a synonym of these items is found within the server metadata, certification will fail.

Examples of Synonym Checking are shown in the [sample Timestamp testing rules](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.330xrl44fu5t). 

**Note**: *This feature is complete and will be included in the MVP.***12/29/2020:** *This feature previously covered lookups but they will not be checked in DD 1.7, as discussed in the Certification and Transport groups. Heuristics will be applied for Data Dictionary resource and field names.* [*GitHub issue*](https://github.com/RESOStandards/web-api-commander/issues/37)*.*

#### Similar Name Matching

[Edit distance](https://en.wikipedia.org/wiki/Edit_distance) matching has been incorporated into the RESO Commander in order to find potential variations of Data Dictionary Resources and Fields. Specifically, the [Levenshtein Distance](https://en.wikipedia.org/wiki/Levenshtein_distance) method is used.

A configuration value has been provided that allows the "fuzziness" threshold to be set to a fraction of the length of each term, currently greater than 25% of the word length. This means that terms of length 5-8 characters will allow up to 1 edit distance variation, and 9-12 will allow 2 variations, etc. The threshold has been chosen to provide a low error rate, while still providing meaningful fuzzy matching results.

Edit distance matches within the given threshold will trigger an error in the Data Dictionary Commander. Unresolved matches will not be granted exceptions and will prevent certification from proceeding.

Due to the probabilistic nature of "fuzzy matching," some false negatives may be generated when local terminology too closely resembles RESO Standard items. 

Applicants are expected to provide a list of corrections [in a configuration file](https://github.com/RESOStandards/web-api-commander/blob/58485cc04f24e464c6c1313d25428d43835d7668/src/main/resources/ignored.json) they will submit at the time of certification to address any cases that arise. These corrections will be added to the testing tool in order to ensure that once a particular case has been addressed, it won't be flagged again in other cases.

**12/29/2020 Note**: *This feature is complete and will be included in the MVP. This feature previously covered lookups but they will not be checked in DD 1.7, as discussed in the Certification and Transport groups. Heuristics will be applied for Data Dictionary resource and field names.* [*GitHub issue*](https://github.com/RESOStandards/web-api-commander/issues/37)*.*

#### Data-Driven Matching

RESO certification testing has progressively become more prescriptive and proscriptive over time. Exceptions for nonadherence to Data Dictionary rules were previously granted when an applicant filed a Supplemental Additional Information (SAI) request with RESO.

While SAIs are no longer part of the RESO Certification process, information that was previously recorded will be used to create a corpus of matching terms to help guide vendors toward the Standard Names for Resources, Fields, and Enumerations.

**Note**: *This feature* ***will not*** *be included in the MVP. It will be released as part of a later enhancement.*

## Certification Workflow

The Certification workflow has been optimized around self-assessment prior to certification.

### Self Assessment

It's expected that applicants will ensure they pass all RESO Data Dictionary tests and have reviewed results to their satisfaction prior to applying for certification.

Guides exist to help them with the evaluation process **TODO:** Create guide. 

Any questions regarding automated testing tools and revised certification procedures should be directed to [Joshua Darnell](mailto:josh@reso.org). For any other questions, or to start the certification process please contact [RESO Certification](mailto:certification@reso.org).

### Application

Those seeking RESO Certification will apply with the Membership Department prior to having their application reviewed by the Certification Department. Once an application has been processed, RESO will confirm the outcome of the automated testing tools using a RESOScript provided by the vendor, as described in the next section.

### Certification Issuance

A [RESOScript file is required for review](https://docs.google.com/document/d/15DFf9kDX_mlGCJVOch2fztl8W5h-yd18N0_03Sb4HwM/edit#heading=h.ymhjhbfn00gj). This file should contain credentials and the service location of the Web API Server instance hosting the Data Dictionary metadata to be tested.

## Reporting

### Data Collection

Metadata for a given server instance will be consumed by the RESO Commander in the [OData XML CSDL metadata format](http://docs.oasis-open.org/odata/odata-csdl-xml/v4.01/csprd02/odata-csdl-xml-v4.01-csprd02.html#_Toc486522889) but is not stored locally. Data analysis is done in memory and discarded upon termination of the application so applicants' source code is not retained.

A report will be generated when a certification application is processed that will contain statistics about what was found on a server when the testing tool was run. The report will be used to help the RESO Certification Department and the applicant evaluate results. The report will be emailed to the applicant and kept on file at RESO as proof of certification.

The RESO Commander will also produce summary test statistics in the JSON format with the results of each test step and include relevant data such as Resources, Fields, and Lookups found during testing. These reports will be uploaded into a RESO data collection service for the purpose of analytics.

### Data Collection Pipeline

Test data will be collected for analytics purposes. This information will be stored on a cloud drive in order to catalog results.

<p align="center">
  <img src="https://user-images.githubusercontent.com/88680702/137548342-c3363b43-65d1-40fa-8cba-23de8580806b.jpg" />
</p>

Once test results are stored, they are sent to a collector service for analysis. The collector will be implemented in [ElasticSearch](https://www.elastic.co/).

While the Collector Service and ancillary reports will be delivered after the MVP testing tool, test data will be available from an API so that analytics may be shown on the RESO Certification Map during the initial release of the Data Dictionary testing tool.

### RESO Certification Map

Certification results will be published to the [RESO Certification Map](https://www.reso.org/certification/), which shows information about certified applicants in a geographical manner.

These information includes, but is not limited to (1) a report showing the RESO Standard Resources, Fields and Lookups in relation to the total number available on a per-resource basis; and, once enough aggregate data have been collected, (2) a field comparison report showing how an applicant scored relative to the market average, as shown in the following diagram:

<p align="center">
  <img src="https://user-images.githubusercontent.com/88680702/137548003-2d36d6db-f0a0-4497-a630-9965ee05619f.jpg" />
</p>

### RESO Data Compatibility Report

A comparison tool will be created to show alignment between resources, fields, and lookups between two or more RESO certified organizations. This will be useful for planning conversions and data shares, among other things. 

While the reporting format has yet to be decided, conceptually the tool will find the intersection and difference between sets of resources, fields, and lookups between organizations. The information needed to produce these reports will be produced upon the initial release of the Data Dictionary testing tool, and a web-based UI will be created at a later time.

<p align="center">
  <img src="https://user-images.githubusercontent.com/88680702/137549347-be6b7648-f044-44aa-a86a-1c78a45c7690.jpg" />
</p>

### RESO Analytics Dashboard

An analytics dashboard will be populated with testing data, and will be driven by [Kibana](https://www.elastic.co/kibana), a popular real-time analytics tool. This dashboard will be available to RESO staff and workgroup chairs for planning purposes and to provide information regarding adoption of RESO standards.

## Display of Information on RESO Website

RESO may use anonymous aggregates collected during the certification process for display on its public websites. These items consist of Resource, Field, and Enumeration tallies but will not be displayed for a given area so as not to reveal the source, unless permission is specifically granted. Aggregate summary reports will be available at the Resource, Field, and Enumeration level.

For example:

* For each discovered resource, how many implementations have that resource?
* For each discovered field, how many implementations have that field?
* For each discovered enumeration, how many implementations have that enumeration?

### Data Retention Policies

Applicants and certification recipients have the right to be forgotten. 

At the time of writing, the Data Dictionary testing tool does not store any information during automated testing aside from generating a local log during runtime and producing JSON-based test results used for reporting.

RESO will be retrieving and saving server metadata in XML (EDMX) format at the time of Data Dictionary Certification for further analysis and to show what was retrieved from the server at the time of testing in case future questions arise. Metadata will be stored securely in the cloud and not available publicly. Information about resources, fields, and lookups found in the metadata during certification will be created as a derivative report. 

## Feature Requests

Feature requests can be requested as [issues on the RESO Commander's GitHub project](https://github.com/RESOStandards/web-api-commander/issues) or by contacting [the RESO development team.](mailto:dev@reso.org).

## Support

To apply for certification, or for help with an existing application, please contact [RESO Certification](mailto:certification@reso.org).

For questions about revised certification procedures or for help or questions about RESO's automated testing tools, please contact RESO's [dev support](mailto:dev@reso.org).

<br /><br />

# Section 4. Contributors
This document was written by [Joshua Darnell](mailto:josh@reso.org).

Thanks to the following contributors for their help with this project:

| Contributor | Company |
| --- | --- |
| Sergio Del Rio | Templates for Business, Inc. |
| Eric Finlay | Zillow Group |
| Dylan Gmyrek | FBS |
| Rob Larson | Larson Consulting, LLC |
| Paul Stusiak | Falcon Technologies Corp. |

Many thanks to those who contributed to the RESO Data Dictionary specification, including volunteers from the RESO Data Dictionary and Transport Workgroups.


If you would like to contribute, please contact [RESO Development](mailto:dev@reso.org). This could mean anything from QA or beta testing to technical writing to doing code reviews or writing code.

<br /><br />

# Section 5: References

Please see the following references for more information regarding topics covered in this document:
* [Data Dictionary 1.7 Wiki](https://ddwiki.reso.org/display/DDW17/)
* [Data Dictionary 1.7 Reference Sheet](https://docs.google.com/spreadsheets/d/1SZ0b6T4_lz6ti6qB2Je7NSz_9iNOaV_v9dbfhPwWgXA/edit?usp=sharing)
* [RESO Web API Core Specification](https://github.com/RESOStandards/reso-transport-specifications/blob/main/web-api-core.md)
* [RESO Common Schema Reference Metadata](https://github.com/RESOStandards/web-api-commander/blob/master/src/main/resources/RESODataDictionary-1.7.xml)
* [RESO Common Schema Open API Specification](https://app.swaggerhub.com/apis/darnjo/RESO-Web-API-Common-Schema/1.7)

<br /><br />

# Section 6: Appendices

The following RCPs are related to Data Dictionary 2.0:
* [RCP-031 - Data Dictionary Representation in the RESO Web API](https://reso.atlassian.net/wiki/spaces/RESOWebAPIRCP/pages/2275149854/RCP+-+WEBAPI-031+Data+Dictionary+Representation+in+the+Web+API)
* [RCP-032 - Lookup Resource](https://reso.atlassian.net/wiki/spaces/RESOWebAPIRCP/pages/2275152879)
* [RCP-033 - Field Resource](https://reso.atlassian.net/wiki/spaces/RESOWebAPIRCP/pages/7996473441)

<br /><br />

# Section 7: License
This document is covered by the [RESO EULA](https://www.reso.org/eula/).

Please [contact RESO](mailto:info@reso.org) if you have any questions.
