<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="xs"
                version="2.0">

<xsl:output method="html" encoding="utf-8" indent="yes"
	    omit-xml-declaration="yes"/>

<xsl:param name="wrap-chapters" as="xs:string" select="'0'"/>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="TEI.2">
  <html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="doc.css" />
    <title>
      <xsl:value-of select="(.//title[@type='main'])[1]"/>
    </title>
  </head>
  <body>
    <xsl:apply-templates select="teiHeader"/>
  </body>
  </html>
</xsl:template>

<xsl:template match="teiHeader">
  <div class="titlepage">
    <h1>
      <xsl:value-of select="(.//title[@type='main'])[1]"/>
    </h1>
    <h2>
      <xsl:value-of select=".//author[1]"/>
    </h2>
  </div>
</xsl:template>

<xsl:template match="editionStmt">
  <div class="edition">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="p">
  <xsl:choose>
    <xsl:when test=". = '&#160;' and count(node()) = 1"/>
    <xsl:otherwise>
      <p>
        <xsl:apply-templates/>
      </p>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="comment()|processing-instruction()|text()">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>
