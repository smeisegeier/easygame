<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://datacite.org/schema/kernel-4"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                exclude-result-prefixes="d xsi">

  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>DataCite Metadata</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
          }
          .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
          }
          h1 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
          }
          .section {
            margin: 20px 0;
          }
          .section h2 {
            color: #34495e;
            background-color: #ecf0f1;
            padding: 8px 12px;
            border-left: 4px solid #3498db;
          }
          .item {
            margin: 10px 0;
            padding: 8px;
            background-color: #f8f9fa;
            border-radius: 4px;
          }
          .label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
          }
          .value {
            display: inline-block;
          }
          ul {
            margin: 5px 0;
            padding-left: 20px;
          }
          li {
            margin: 5px 0;
          }
          .link {
            color: #3498db;
            text-decoration: none;
          }
          .link:hover {
            text-decoration: underline;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>DataCite Metadata Record</h1>

          <!-- DOI/Identifier -->
          <div class="section">
            <h2>Identifier</h2>
            <div class="item">
              <span class="label">DOI:</span>
              <span class="value">
                <xsl:value-of select="d:resource/d:identifier"/>
              </span>
            </div>
          </div>

          <!-- Titles -->
          <div class="section">
            <h2>Titles</h2>
            <xsl:for-each select="d:resource/d:titles/d:title">
              <div class="item">
                <xsl:if test="@titleType">
                  <span class="label"><xsl:value-of select="@titleType"/>:</span>
                </xsl:if>
                <xsl:if test="not(@titleType)">
                  <span class="label">Title:</span>
                </xsl:if>
                <span class="value">
                  "<xsl:value-of select="."/>"
                  <xsl:if test="@xml:lang">
                    (<xsl:value-of select="@xml:lang"/>)
                  </xsl:if>
                </span>
              </div>
            </xsl:for-each>
          </div>

          <!-- Creators -->
          <div class="section">
            <h2>Creators</h2>
            <xsl:for-each select="d:resource/d:creators/d:creator">
              <div class="item">
                <div>
                  <span class="label">Creator:</span>
                  <span class="value">
                    <xsl:value-of select="d:creatorName"/>
                    <xsl:if test="d:creatorName/@nameType">
                      (<xsl:value-of select="d:creatorName/@nameType"/>)
                    </xsl:if>
                  </span>
                </div>
                <xsl:if test="d:nameIdentifier">
                  <div>
                    <span class="label">ID:</span>
                    <span class="value">
                      <xsl:variable name="idValue" select="d:nameIdentifier"/>
                      <xsl:variable name="idScheme" select="d:nameIdentifier/@nameIdentifierScheme"/>
                      <xsl:choose>
                        <xsl:when test="$idScheme = 'ORCID'">
                          <a class="link" href="{$idValue}">
                            <xsl:value-of select="$idValue"/>
                          </a>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="$idValue"/>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:if test="not($idScheme = 'ORCID')">
                        (<xsl:value-of select="$idScheme"/>)
                      </xsl:if>
                    </span>
                  </div>
                </xsl:if>
                <xsl:if test="d:affiliation">
                  <div>
                    <span class="label">Affiliation:</span>
                    <span class="value">
                      <xsl:value-of select="d:affiliation"/>
                      <xsl:if test="d:affiliation/@affiliationIdentifier">
                        <xsl:variable name="affiliationId" select="d:affiliation/@affiliationIdentifier"/>
                        <xsl:variable name="affiliationScheme" select="d:affiliation/@affiliationIdentifierScheme"/>
                        <xsl:choose>
                          <xsl:when test="$affiliationScheme = 'ROR'">
                            <a class="link" href="{$affiliationId}">
                              (<xsl:value-of select="$affiliationId"/>)
                            </a>
                          </xsl:when>
                          <xsl:otherwise>
                            (<xsl:value-of select="$affiliationId"/>)
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:if>
                    </span>
                  </div>
                </xsl:if>
              </div>
            </xsl:for-each>
          </div>

          <!-- Publisher -->
          <div class="section">
            <h2>Publisher</h2>
            <div class="item">
              <span class="label">Publisher:</span>
              <span class="value">
                <xsl:value-of select="d:resource/d:publisher"/>
                <xsl:if test="d:resource/d:publisher/@publisherIdentifier">
                  <xsl:variable name="publisherId" select="d:resource/d:publisher/@publisherIdentifier"/>
                  <xsl:variable name="publisherScheme" select="d:resource/d:publisher/@publisherIdentifierScheme"/>
                  <xsl:choose>
                    <xsl:when test="$publisherScheme = 'ROR'">
                      <a class="link" href="{$publisherId}">
                        (<xsl:value-of select="$publisherId"/>)
                      </a>
                    </xsl:when>
                    <xsl:otherwise>
                      (<xsl:value-of select="$publisherId"/>)
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>
              </span>
            </div>
          </div>

          <!-- Publication Year -->
          <div class="section">
            <h2>Publication</h2>
            <div class="item">
              <span class="label">Year:</span>
              <span class="value">
                <xsl:value-of select="d:resource/d:publicationYear"/>
              </span>
            </div>
          </div>

          <!-- Resource Type -->
          <div class="section">
            <h2>Resource Type</h2>
            <div class="item">
              <span class="label">Type:</span>
              <span class="value">
                <xsl:value-of select="d:resource/d:resourceType"/>
                <xsl:if test="d:resource/d:resourceType/@resourceTypeGeneral">
                  (<xsl:value-of select="d:resource/d:resourceType/@resourceTypeGeneral"/>)
                </xsl:if>
              </span>
            </div>
          </div>

          <!-- Subjects -->
          <div class="section">
            <h2>Subjects</h2>
            <xsl:for-each select="d:resource/d:subjects/d:subject">
              <div class="item">
                <span class="label">Subject:</span>
                <span class="value">
                  <xsl:value-of select="."/>
                  <xsl:if test="@subjectScheme">
                    (Scheme: <xsl:value-of select="@subjectScheme"/>)
                  </xsl:if>
                </span>
              </div>
            </xsl:for-each>
          </div>

          <!-- Contributors -->
          <div class="section">
            <h2>Contributors</h2>
            <xsl:for-each select="d:resource/d:contributors/d:contributor">
              <div class="item">
                <div>
                  <span class="label">Type:</span>
                  <span class="value">
                    <xsl:value-of select="@contributorType"/>
                  </span>
                </div>
                <div>
                  <span class="label">Name:</span>
                  <span class="value">
                    <xsl:value-of select="d:contributorName"/>
                    <xsl:if test="d:contributorName/@nameType">
                      (<xsl:value-of select="d:contributorName/@nameType"/>)
                    </xsl:if>
                  </span>
                </div>
                <xsl:if test="d:nameIdentifier">
                  <div>
                    <span class="label">ID:</span>
                    <span class="value">
                      <xsl:variable name="idValue" select="d:nameIdentifier"/>
                      <xsl:variable name="idScheme" select="d:nameIdentifier/@nameIdentifierScheme"/>
                      <xsl:choose>
                        <xsl:when test="$idScheme = 'ORCID'">
                          <a class="link" href="{$idValue}">
                            <xsl:value-of select="$idValue"/>
                          </a>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="$idValue"/>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:if test="not($idScheme = 'ORCID')">
                        (<xsl:value-of select="$idScheme"/>)
                      </xsl:if>
                    </span>
                  </div>
                </xsl:if>
                <xsl:if test="d:affiliation">
                  <div>
                    <span class="label">Affiliation:</span>
                    <span class="value">
                      <xsl:value-of select="d:affiliation"/>
                      <xsl:if test="d:affiliation/@affiliationIdentifier">
                        <xsl:variable name="affiliationId" select="d:affiliation/@affiliationIdentifier"/>
                        <xsl:variable name="affiliationScheme" select="d:affiliation/@affiliationIdentifierScheme"/>
                        <xsl:choose>
                          <xsl:when test="$affiliationScheme = 'ROR'">
                            <a class="link" href="{$affiliationId}">
                              (<xsl:value-of select="$affiliationId"/>)
                            </a>
                          </xsl:when>
                          <xsl:otherwise>
                            (<xsl:value-of select="$affiliationId"/>)
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:if>
                    </span>
                  </div>
                </xsl:if>
              </div>
            </xsl:for-each>
          </div>

          <!-- Dates -->
          <div class="section">
            <h2>Dates</h2>
            <xsl:for-each select="d:resource/d:dates/d:date">
              <div class="item">
                <span class="label">Type:</span>
                <span class="value">
                  <xsl:value-of select="@dateType"/>
                </span>
                <span class="label">Date:</span>
                <span class="value">
                  <xsl:value-of select="."/>
                  <xsl:if test="@dateInformation">
                    (<xsl:value-of select="@dateInformation"/>)
                  </xsl:if>
                </span>
              </div>
            </xsl:for-each>
          </div>

          <!-- Language -->
          <div class="section">
            <h2>Language</h2>
            <div class="item">
              <span class="label">Language:</span>
              <span class="value">
                <xsl:value-of select="d:resource/d:language"/>
              </span>
            </div>
          </div>

          <!-- Version -->
          <div class="section">
            <h2>Version</h2>
            <div class="item">
              <span class="label">Version:</span>
              <span class="value">
                <xsl:value-of select="d:resource/d:version"/>
              </span>
            </div>
          </div>

          <!-- Geo Locations -->
          <div class="section">
            <h2>Geographic Locations</h2>
            <xsl:for-each select="d:resource/d:geoLocations/d:geoLocation">
              <div class="item">
                <xsl:if test="d:geoLocationPlace">
                  <div>
                    <span class="label">Place:</span>
                    <span class="value">
                      <xsl:value-of select="d:geoLocationPlace"/>
                    </span>
                  </div>
                </xsl:if>
              </div>
            </xsl:for-each>
          </div>

          <!-- Funding References -->
          <div class="section">
            <h2>Funding</h2>
            <xsl:for-each select="d:resource/d:fundingReferences/d:fundingReference">
              <div class="item">
                <div>
                  <span class="label">Funder:</span>
                  <span class="value">
                    <xsl:value-of select="d:funderName"/>
                  </span>
                </div>
                <xsl:if test="d:funderIdentifier">
                  <div>
                    <span class="label">Funder ID:</span>
                    <span class="value">
                      <xsl:variable name="funderId" select="d:funderIdentifier"/>
                      <xsl:variable name="funderIdType" select="d:funderIdentifier/@funderIdentifierType"/>
                      <xsl:choose>
                        <xsl:when test="$funderIdType = 'Crossref Funder ID'">
                          <a class="link" href="{$funderId}">
                            <xsl:value-of select="$funderId"/>
                          </a>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="$funderId"/>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:if test="not($funderIdType = 'Crossref Funder ID')">
                        (<xsl:value-of select="$funderIdType"/>)
                      </xsl:if>
                    </span>
                  </div>
                </xsl:if>
              </div>
            </xsl:for-each>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>