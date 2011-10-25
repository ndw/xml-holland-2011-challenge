<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">

<xsl:output method="xml" encoding="utf-8" indent="no"
	    omit-xml-declaration="yes"/>

<xsl:preserve-space elements="*"/>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="div|xptr">
  <xsl:copy>
    <xsl:attribute name="id" select="generate-id(.)"/>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="note">
  <xsl:variable name="content" as="element()">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:variable>

  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:attribute name="n">
      <xsl:number from="/" count="note[@place='foot']" level="any"/>
    </xsl:attribute>
    <xsl:apply-templates select="$content"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="p">
  <xsl:for-each-group select="node()" group-adjacent="local-name(.) = 'table'
                                                      or local-name(.) = 'figure'
                                                      or local-name(.) = 'lg'
                                                      or local-name(.) = 'q'">
    <xsl:variable name="strval" select="if (count(current-group()) = 1)
                                        then normalize-space(current-group())
                                        else 'xxx'"/>
    <xsl:variable name="first" select="current-group()[1]"/>

    <xsl:choose>
      <xsl:when test="$first/self::table or $first/self::figure or $first/self::q or $first/self::lg">
        <xsl:apply-templates select="current-group()"/>
      </xsl:when>
      <xsl:when test="$strval = ''">
        <xsl:apply-templates select="current-group()"/>
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates select="current-group()"/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each-group>
</xsl:template>

<xsl:template match="*">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="comment()|processing-instruction()|text()">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>
