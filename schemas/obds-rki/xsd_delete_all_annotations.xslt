<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:strip-space elements="*" />
	<xsl:template match="@*|node()">
	 <xsl:copy>
		 <xsl:apply-templates select="@*|node()"/>
	 </xsl:copy>
	</xsl:template>
<xsl:template match="xs:annotation" />

<!--<xsl:template match="Column[@SourceColumn='xs:annotation']|annotation" />
-->

</xsl:stylesheet>






