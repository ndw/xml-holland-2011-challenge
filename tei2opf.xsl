<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.idpf.org/2007/opf"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                version="2.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"
	    omit-xml-declaration="yes"/>

<xsl:param name="endnotes" select="'1'"/>

<xsl:template match="/">
  <package version="2.0" unique-identifier="bookid">
    <metadata>
      <dc:identifier id="bookid">
        <xsl:value-of select="/TEI.2/teiHeader/fileDesc/publicationStmt/idno"/>
      </dc:identifier>
      <dc:title>
        <xsl:value-of select="/TEI.2/teiHeader/(.//title[@type='main'])[1]"/>
      </dc:title>
      <dc:rights>Copyright © 2007 digitale bibliotheek voor de Nederlandse letteren</dc:rights>
      <dc:publisher>digitale bibliotheek voor de Nederlandse letteren</dc:publisher>
      <dc:subject>General studies</dc:subject>
      <dc:date>1872</dc:date>
      <dc:creator>J. Waltman Jr.</dc:creator>
      <dc:description>Multatuli-Millions studies. J. Waltman Jr., Delft 1872</dc:description>
      <dc:language>nl</dc:language>
      <meta name="cover" content="cover-image"/>
    </metadata>
    <manifest>
      <item id="ncxtoc" media-type="application/x-dtbncx+xml" href="toc.ncx"/>
      <item id="cover" href="cover.html" media-type="application/xhtml+xml"/>
      <item id="titlepage" href="titlepage.html" media-type="application/xhtml+xml"/>
      <item id="css" href="doc.css" media-type="text/css"/>
      <xsl:if test="$endnotes != '0'">
        <item id="endnotes" href="endnotes.html" media-type="application/xhtml+xml"/>
      </xsl:if>
      <item id="cover-image" href="mult001mill01_01_tpg.gif" media-type="image/gif"/>
      <xsl:for-each select="/TEI.2/text/body/div">
        <xsl:variable name="chapnum" select="count(preceding::div)+1"/>
        <item id="{@id}" href="chap{$chapnum}.html" media-type="application/xhtml+xml"/>
      </xsl:for-each>
      <xsl:for-each select="//xptr">
        <item id="{@id}" href="{@to}" media-type="image/gif"/>
      </xsl:for-each>
    </manifest>
    <spine toc="ncxtoc">
      <itemref idref="cover"/>
      <itemref idref="titlepage"/>
      <xsl:if test="$endnotes != '0'">
        <itemref idref="endnotes"/>
      </xsl:if>
      <xsl:for-each select="/TEI.2/text/body/div">
        <xsl:variable name="chapnum" select="count(preceding::div)+1"/>
        <itemref idref="{@id}"/>
      </xsl:for-each>
    </spine>
    <guide>
      <reference href="cover.html" type="cover" title="Cover"/>
    </guide>
  </package>
</xsl:template>

</xsl:stylesheet>
