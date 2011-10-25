<p:declare-step version='1.0' xmlns:p="http://www.w3.org/ns/xproc">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>

<p:option name="endnotes" select="'0'"/>

<p:xslt name="patched">
  <p:input port="stylesheet">
    <p:document href="normalize.xsl"/>
  </p:input>
</p:xslt>

<p:for-each>
  <p:iteration-source select="/TEI.2/text/body/div"/>
  <p:xslt>
    <p:input port="stylesheet">
      <p:document href="tei2html.xsl"/>
    </p:input>
    <p:with-param name="endnotes" select="$endnotes"/>
  </p:xslt>
  <p:store method="xhtml" indent="true">
    <p:with-option name="href" select="concat('epub/doc/chap', p:iteration-position(), '.html')"/>
  </p:store>
</p:for-each>

<p:store href="epub/mimetype" method="text">
  <p:input port="source">
    <p:inline><mimetype>application/epub+zip</mimetype></p:inline>
  </p:input>
</p:store>

<p:choose>
  <p:when test="$endnotes != '0'">
    <p:xslt>
      <p:input port="source">
        <p:pipe step="patched" port="result"/>
      </p:input>
      <p:input port="stylesheet">
        <p:document href="tei2endnotes.xsl"/>
      </p:input>
    </p:xslt>
    <p:store href="epub/doc/endnotes.html" method="xhtml"/>
  </p:when>
  <p:otherwise>
    <p:sink>
      <p:input port="source"><p:empty/></p:input>
    </p:sink>
  </p:otherwise>
</p:choose>

<p:store href="epub/META-INF/container.xml" method="xml" indent="true">
  <p:input port="source">
    <p:inline><container xmlns="urn:oasis:names:tc:opendocument:xmlns:container" version="1.0">
  <rootfiles>
    <rootfile full-path="doc/content.opf" media-type="application/oebps-package+xml"/>
  </rootfiles>
</container></p:inline>
  </p:input>
</p:store>

<p:xslt>
  <p:input port="source">
    <p:pipe step="patched" port="result"/>
  </p:input>
  <p:input port="stylesheet">
    <p:document href="tei2ncx.xsl"/>
  </p:input>
</p:xslt>

<p:store href="epub/doc/toc.ncx" method="xml" indent="true"/>

<p:xslt>
  <p:input port="source">
    <p:pipe step="patched" port="result"/>
  </p:input>
  <p:input port="stylesheet">
    <p:document href="tei2cover.xsl"/>
  </p:input>
</p:xslt>

<p:store href="epub/doc/titlepage.html" method="xhtml"/>

<p:xslt>
  <p:input port="source">
    <p:pipe step="patched" port="result"/>
  </p:input>
  <p:input port="stylesheet">
    <p:document href="tei2opf.xsl"/>
  </p:input>
  <p:with-param name="endnotes" select="$endnotes"/>
</p:xslt>

<p:store href="epub/doc/content.opf" method="xml" indent="true"/>

<p:store href="epub/doc/cover.html" method="xhtml" indent="true">
  <p:input port="source">
    <p:inline><html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Cover</title>
    <style type="text/css"> img { max-width: 100%; }</style>
  </head>
  <body>
    <div id="cover-image">
      <img src="mult001mill01_01_tpg.gif" alt="[Cover]"/>
    </div>
  </body>
</html></p:inline>
  </p:input>
</p:store>

</p:declare-step>

