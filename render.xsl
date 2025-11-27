<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://datacite.org/schema/kernel-4"
                exclude-result-prefixes="d">
  
  <xsl:output method="html" indent="yes"/>
  
  <xsl:template match="/">
    <html>
      <head>
        <title>DataCite Metadata</title>
        <link rel="stylesheet" href="style.css"/> </head>
      <body>
        <h1>DataCite Metadata Record</h1>
        
        <xsl:for-each select="d:resource/d:titles/d:title">
          <h2><xsl:value-of select="."/></h2>
        </xsl:for-each>
        
        <h3>Creators</h3>
        <ul>
          <xsl:for-each select="d:resource/d:creators/d:creator">
            <li>
              <xsl:value-of select="d:creatorName"/>
            </li>
          </xsl:for-each>
        </ul>
        
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>