<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/"
                version="2.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"
	    omit-xml-declaration="yes"/>

<xsl:template match="/">
  <ncx:ncx version="2005-1">
    <ncx:head>
      <ncx:meta name="cover" content="cover"/>
      <ncx:meta name="dtb:uid" content="/TEI.2/teiHeader/fileDesc/publicationStmt/idno"/>
      <ncx:meta name="dtb:depth" content="-1"/>
      <ncx:meta name="dtb:totalPageCount" content="0"/>
      <ncx:meta name="dtb:maxPageNumber" content="0"/>
    </ncx:head>
    <ncx:docTitle>
      <ncx:text>
        <xsl:value-of select="/TEI.2/teiHeader/(.//title[@type='main'])[1]"/>
      </ncx:text>
    </ncx:docTitle>
    <ncx:navMap>
      <ncx:navPoint id="titlepage" playOrder="1">
        <ncx:navLabel>
          <ncx:text>
            <xsl:value-of select="/TEI.2/teiHeader/(.//title[@type='main'])[1]"/>
          </ncx:text>
        </ncx:navLabel>
        <ncx:content src="titlepage.html"/>
        <xsl:for-each select="/TEI.2/text/body/div">
          <xsl:variable name="chapnum" select="count(preceding::div)+1"/>
          <ncx:navPoint id="{@id}" playOrder="{$chapnum+1}">
            <ncx:navLabel>
              <ncx:text>
                <xsl:value-of select="head"/>
              </ncx:text>
            </ncx:navLabel>
            <ncx:content src="chap{$chapnum}.html"/>
          </ncx:navPoint>
        </xsl:for-each>
      </ncx:navPoint>
    </ncx:navMap>
  </ncx:ncx>
</xsl:template>

</xsl:stylesheet>
