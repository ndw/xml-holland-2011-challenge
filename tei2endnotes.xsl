<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="xs"
                version="2.0">

<xsl:output method="html" encoding="utf-8" indent="yes"
	    omit-xml-declaration="yes"/>

<xsl:template match="/">
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <link rel="stylesheet" type="text/css" href="doc.css" />
      <title>Eindnoten</title>
    </head>
    <body>
      <h1>Eindnoten</h1>
      <xsl:apply-templates select="//note[@place='foot']"/>
    </body>
  </html>
</xsl:template>

<xsl:template match="note[@place='foot']">
  <xsl:variable name="fn">
    <xsl:apply-templates select="." mode="footnote-number"/>
  </xsl:variable>

  <xsl:variable name="chap" select="ancestor::div[@type='chapter']"/>
  <xsl:variable name="chapnum" select="count($chap/preceding-sibling::div)+1"/>

  <p id="fn{$fn}">
    <sup>
      <a href="chap{$chapnum}.html#fnr{$fn}">
        <xsl:value-of select="$fn"/>
      </a>
    </sup>
    <xsl:apply-templates select="*[1]/node()"/>
  </p>
  <xsl:apply-templates select="*[position()&gt;1]"/>
</xsl:template>

<xsl:template match="note[@place='foot']" mode="footnote-number">
  <xsl:value-of select="@n"/>
</xsl:template>

<xsl:template match="p">
  <xsl:choose>
    <xsl:when test=". = '&#160;' and count(node()) = 1"/>
    <xsl:otherwise>
      <xsl:variable name="ps" select="preceding-sibling::*[1]"/>
      <xsl:variable name="fs" select="following-sibling::*[1]"/>
      <xsl:variable name="class" as="xs:string*">
        <xsl:if test="$ps/self::p and not($ps = '&#160;' and count($ps/node()) = 1)">indent</xsl:if>
        <xsl:if test="$fs/self::p and not($fs = '&#160;' and count($fs/node()) = 1)">tight</xsl:if>
      </xsl:variable>
      <p>
        <xsl:if test="exists($class)">
          <xsl:attribute name="class" select="$class"/>
        </xsl:if>
        <xsl:apply-templates/>
      </p>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="hi[@rend='i']">
  <span class="hi-i">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="hi[@rend='sc']">
  <span class="hi-sc">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="hi[@rend='sup']">
  <sup class="hi-sup">
    <xsl:apply-templates/>
  </sup>
</xsl:template>

<xsl:template match="hi[@rend='sub']">
  <sub class="hi-sub">
    <xsl:apply-templates/>
  </sub>
</xsl:template>

<xsl:template match="hi[@rend='b']">
  <span class="hi-b">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="hi[@rend='spat']">
  <span class="hi-spat">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="q[@rend='bq']">
  <blockquote class="q-bq">
    <p>
      <xsl:apply-templates/>
    </p>
  </blockquote>
</xsl:template>

<xsl:template match="lb">
  <br/>
</xsl:template>

<xsl:template match="lg[@type='poem']">
  <div class="poem">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="lg[@type='poem']/l">
  <span class="line">
    <xsl:apply-templates/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="list[@type='simple']">
  <div class="list-simple">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="list[@type='simple']/item">
  <span class="item">
    <xsl:apply-templates/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="figure">
  <div class="figure">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="xptr[@to]">
  <img src="{@to}" alt="[Image]"/>
</xsl:template>

<xsl:template match="table">
  <table border="1">
    <xsl:apply-templates/>
  </table>
</xsl:template>

<xsl:template match="row">
  <tr>
    <xsl:apply-templates/>
  </tr>
</xsl:template>

<xsl:template match="cell">
  <td>
    <xsl:choose>
      <xsl:when test="empty(node())">&#160;</xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </td>
</xsl:template>

<xsl:template match="*">
  <div>
    <span class="unknown">&lt;<xsl:value-of select="local-name(.)"/>&gt;</span>
    <xsl:apply-templates/>
    <span class="unknown">&lt;/<xsl:value-of select="local-name(.)"/>&gt;</span>
  </div>
</xsl:template>

<xsl:template match="comment()|processing-instruction()|text()">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>
