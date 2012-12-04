<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:eml="eml://ecoinformatics.org/eml-2.1.1" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://datacite.org/schema/kernel-2.2" exclude-result-prefixes="eml xs">
  <xsl:output method="xml" indent="yes"/>
  
	<xsl:template match="/eml:eml">
	<resource xmlns="http://datacite.org/schema/kernel-2.2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://datacite.org/schema/kernel-2.2 http://schema.datacite.org/meta/kernel-2.2/metadata.xsd">
	  	<xsl:apply-templates select="dataset"/>
	  	</resource>
	</xsl:template>
   
   <xsl:template match="dataset">
   <xsl:variable name="publishervar" select="associatedParty[role='publisher']/organizationName"/>
   <identifier identifierType="DOI"><xsl:value-of select="document('config.xml')/config/doi"/></identifier>
    <creators>
		<creator>
			<creatorName>
				<xsl:apply-templates select="creator/individualName"/>
      		</creatorName>
		</creator>
	</creators>
	<titles>
		<title><xsl:value-of select="title"/> from <xsl:value-of select="$publishervar"/></title>
	</titles>
	<publisher><xsl:value-of select="$publishervar"/></publisher>
	<xsl:variable name="pubDatevar" select="pubDate"/>
	<publicationYear><xsl:value-of select="year-from-date(xs:date($pubDatevar))"/></publicationYear>
	
	<xsl:apply-templates select="keywordSet"/>
	
	<xsl:variable name="contactvar" select="contact/individualName/surName"/>
	<contributors>
		<xsl:apply-templates select="contact"/>
		<xsl:apply-templates select="associatedParty[individualName[surName != $contactvar]][role!='publisher']"/>
		<contributor contributorType="RegistrationAgency">
			<contributorName><xsl:value-of select="document('config.xml')/config/registrationAgency"/></contributorName>
		</contributor>
	</contributors>
	<dates>
		<date dateType="Accepted"><xsl:value-of select="pubDate"/></date>
		<date dateType="Updated"><xsl:value-of select="document('config.xml')/config/updatedDate"/></date>
	</dates>
	<language><xsl:value-of select="language"/></language>
	<resourceType resourceTypeGeneral="Collection">Occurrences</resourceType>
	<alternateIdentifiers>
		<alternateIdentifier alternateIdentifierType="URL"><xsl:value-of select="document('config.xml')/config/datasetURL"/></alternateIdentifier>
	</alternateIdentifiers>
	<formats>
		<format>application/zip</format>
	</formats>
	<rights><xsl:value-of select="intellectualRights/para"/></rights>
	<descriptions>
		<description descriptionType="Abstract"><xsl:value-of select="abstract/para"/></description>
	</descriptions>
  </xsl:template>
  
  <xsl:template match="keywordSet">
	<subjects>
  		<xsl:apply-templates select="keyword"/>
  	</subjects>
  </xsl:template >
  
  <xsl:template match="keyword">
  	<subject><xsl:value-of select="."/></subject>
  </xsl:template >
 
  <xsl:template match="contact">
	<contributor contributorType="ContactPerson">
		<contributorName><xsl:apply-templates select="individualName"/></contributorName>
	</contributor>
  </xsl:template >
  
  <xsl:template match="associatedParty">
	<contributor contributorType="ProjectMember">
		<contributorName><xsl:apply-templates select="individualName"/></contributorName>
	</contributor>
  </xsl:template >
  
  <xsl:template match="individualName">
  	<xsl:value-of select="surName"/>, <xsl:value-of select="givenName"/>
  </xsl:template >
  
  <xsl:template match="additionalMetadata"/>  
  
</xsl:stylesheet>