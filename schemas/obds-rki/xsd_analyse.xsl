<?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0"
xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xsl:output method='text' encoding="utf-8"/>
<xsl:strip-space elements="xs:documentation"/> 

<xsl:variable name="einrueckung"><xsl:text>| </xsl:text></xsl:variable>

<xsl:template match='/'>
	<xsl:apply-templates select="xs:schema/xs:element">
		<xsl:with-param name="prefix"></xsl:with-param>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match='xs:element'>
<xsl:param name="prefix"/>
<xsl:value-of select="$prefix"/><xsl:value-of select="@name"/>
   <xsl:text> </xsl:text><xsl:value-of select="@minOccurs"/><xsl:if test="not(@minOccurs!='') and @maxOccurs!=''">1</xsl:if><xsl:if test="@maxOccurs!=''">..<xsl:value-of select="@maxOccurs"/></xsl:if>
   <xsl:apply-templates select="xs:simpleType"/>
   <xsl:variable name="type"><xsl:value-of select="@type"/></xsl:variable>
   <xsl:variable name="ref" ><xsl:value-of select="@ref" /></xsl:variable>
   <xsl:apply-templates select="//xs:simpleType[@name=$type]"/>
   <xsl:if test="not(//xs:simpleType[@name=$type]) and $type!=''"> (<xsl:value-of select="$type"/>)</xsl:if>
<xsl:text>
</xsl:text>
<xsl:apply-templates select="*[name()!='xs:simpleType']">
<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/><xsl:value-of select="$einrueckung"/></xsl:with-param>
</xsl:apply-templates>

<xsl:if test="//xs:complexType[@name=$type]">
 <!--  <xsl:variable name="type"><xsl:value-of select="@type"/></xsl:variable> -->
   <xsl:apply-templates select="//xs:complexType[@name=$type]"><xsl:with-param name="prefix"><xsl:value-of select="$prefix"/><xsl:value-of select="$einrueckung"/></xsl:with-param></xsl:apply-templates>
   <xsl:if test="not(//xs:complexType[@name=$type]) and $type!=''"> (<xsl:value-of select="$type"/>)</xsl:if>
</xsl:if>
</xsl:template>

<xsl:template match='xs:simpleType'>(<xsl:apply-templates select="xs:restriction"/>
	<xsl:apply-templates select="*[name()!='xs:restriction']">
		<xsl:with-param name="prefix"></xsl:with-param>
	</xsl:apply-templates>
	<xsl:for-each select="xs:union">
		<xsl:value-of select="@memberTypes"/>
	</xsl:for-each>)</xsl:template>

<xsl:template match='xs:simpleType/xs:restriction'>
	<xsl:param name="prefix"/>
	<xsl:value-of select="$prefix"/><xsl:value-of select="@base"/>
	<xsl:apply-templates select="*">
		<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match='xs:complexContent/xs:restriction'>
	<xsl:param name="prefix"/>
	<xsl:value-of select="$prefix"/>restriction: <xsl:value-of select="@base"/><xsl:text>
</xsl:text>
	<xsl:apply-templates select="*">
		<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match='xs:extension'><xsl:param name="prefix"/><xsl:variable name="base"><xsl:value-of select="@base"/></xsl:variable>
<xsl:apply-templates select="//xs:complexType[@name=$base]"><xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param></xsl:apply-templates>
<xsl:for-each select="xs:attribute">
<xsl:value-of select="$prefix"/><xsl:apply-templates select="."/><xsl:text>
</xsl:text>
</xsl:for-each>
<xsl:apply-templates select="*[name()!='xs:attribute']"><xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
</xsl:apply-templates></xsl:template>

<xsl:template match='xs:enumeration'><xsl:text> </xsl:text><xsl:value-of select="@value"/><xsl:apply-templates select="*"></xsl:apply-templates></xsl:template>

<xsl:template match='xs:annotation'>=<xsl:apply-templates select="xs:documentation/text()"/></xsl:template>

<xsl:template match='xs:pattern'><xsl:text> </xsl:text><xsl:value-of select="@value"/><xsl:apply-templates select="*"></xsl:apply-templates></xsl:template>

<xsl:template match='xs:maxLength'><xsl:text> &lt;=</xsl:text><xsl:value-of select="@value"/><xsl:apply-templates select="*"></xsl:apply-templates></xsl:template>

<xsl:template match='xs:attribute'><xsl:text> @</xsl:text><xsl:value-of select="@name"/>=<xsl:value-of select="@use"/>
   <xsl:variable name="type"><xsl:value-of select="@type"/></xsl:variable>
   <xsl:apply-templates select="//xs:simpleType[@name=$type]"/>
   <xsl:if test="not(//xs:simpleType[@name=$type]) and $type!=''"> (<xsl:value-of select="$type"/>)</xsl:if>

<xsl:apply-templates select="*"></xsl:apply-templates></xsl:template>

<xsl:template match='xs:complexType'>
<xsl:param name="prefix"/>
<xsl:for-each select="xs:attribute">
<xsl:value-of select="$prefix"/><xsl:apply-templates select="."/><xsl:text>
</xsl:text>
</xsl:for-each>
<xsl:apply-templates select="*[name()!='xs:attribute']">
<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
</xsl:apply-templates></xsl:template>

<xsl:template match='xs:choice'>
<xsl:param name="prefix"/>
<xsl:for-each select="xs:attribute">
<xsl:value-of select="$prefix"/><xsl:apply-templates select="."/><xsl:text>
</xsl:text>
</xsl:for-each>
<xsl:value-of select="concat($prefix, 'xs:choice (', count(*[name()!='xs:attribute']), ' Optionen)')"/><xsl:text>
</xsl:text>
<xsl:for-each  select="*[name()!='xs:attribute']">
	<xsl:value-of select="concat($prefix, 'Option ', position())"/><xsl:text>
</xsl:text>
	<xsl:apply-templates select=".">
		<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
	</xsl:apply-templates>
</xsl:for-each>
</xsl:template>

<xsl:template match="xs:group[@ref!='']">
<xsl:param name="prefix"/>
   <xsl:variable name="ref" ><xsl:value-of select="@ref" /></xsl:variable>
   <xsl:value-of select="concat($prefix, 'xs:group ', $ref)"/><xsl:text> </xsl:text><xsl:value-of select="@minOccurs"/><xsl:if test="not(@minOccurs!='') and @maxOccurs!=''">1</xsl:if><xsl:if test="@maxOccurs!=''">..<xsl:value-of select="@maxOccurs"/></xsl:if><xsl:text>
</xsl:text>
<xsl:if test="//xs:group[@name=$ref]">
   <xsl:apply-templates select="//xs:group[@name=$ref]"       ><xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param></xsl:apply-templates>
   <xsl:if test="not(//xs:group[@name=$ref])         and $ref !=''"> (<xsl:value-of select="$ref"/>)</xsl:if>
</xsl:if>
<xsl:apply-templates select="*[name()!='xs:attribute']">
</xsl:apply-templates></xsl:template>

<xsl:template match="xs:group[@name!='']">
<xsl:param name="prefix"/>
<xsl:for-each select="xs:attribute">
<xsl:value-of select="$prefix"/><xsl:apply-templates select="."/><xsl:text>
</xsl:text>
</xsl:for-each>
<xsl:apply-templates select="*[name()!='xs:attribute']">
<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/>\</xsl:with-param>
</xsl:apply-templates></xsl:template>

<xsl:template match='*'>
	<xsl:param name="prefix"/>
	<xsl:apply-templates select="*">
		<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match='xs:annotation'></xsl:template>

<xsl:template match='text()'><xsl:value-of select="normalize-space(.)"/></xsl:template>

</xsl:stylesheet>