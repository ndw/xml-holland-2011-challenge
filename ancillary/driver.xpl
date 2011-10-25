<p:declare-step version='1.0' xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:cxo="http://xmlcalabash.com/ns/extensions/osutils"
                xmlns:cxf="http://xmlcalabash.com/ns/extensions/fileutils">

<!-- This is a partial implementation of the top-level driver in XProc. It turns out there's
     some sort of a bug in my implementation of the extension "eval" step when it comes to
     dealing with the parameter input port, so I didn't bother to finish it. -->

<p:import href="ancillary/osutils.xpl"/>
<p:import href="ancillary/fileutils.xpl"/>

<p:declare-step type="cx:message">
  <p:input port="source"/>
  <p:output port="result"/>
  <p:option name="message" required="true"/>
</p:declare-step>

<p:declare-step type="cx:eval">
  <p:input port="source" sequence="true" primary="true"/>
  <p:input port="pipeline"/>
  <p:input port="parameters" kind="parameter"/>
  <p:input port="options" sequence="true"/>
  <p:output port="result" sequence="true"/>
  <p:option name="detailed" select="'false'"/>
  <p:option name="step" cx:type="xs:QName"/>
</p:declare-step>

<p:variable name="epub" select="'book.epub'"/>
<p:variable name="epubcheck" select="'/usr/local/epubcheck-1.2/epubcheck-1.2.jar'"/>

<p:try>
  <!-- work around bug in cxf:delete -->
  <p:group>
    <cxf:delete fail-on-error="false">
      <p:with-option name="href" select="$epub"/>
    </cxf:delete>
  </p:group>
  <p:catch>
    <p:sink>
      <p:input port="source">
        <p:empty/>
      </p:input>
    </p:sink>
  </p:catch>
</p:try>

<cxf:mkdir href="epub/doc"/>

<p:directory-list path="Millioenenstudien" include-filter="^.*\.gif$"/>
<p:make-absolute-uris match="c:file/@name"/>

<p:for-each name="loop">
  <p:iteration-source select="c:directory/c:file"/>

  <cxf:copy>
    <p:with-option name="href" select="c:file/@name"/>
    <p:with-option name="target" select="concat('epub/doc/', substring-after(c:file/@name,'studien/'))"/>
  </cxf:copy>
</p:for-each>

<cx:eval>
  <p:input port="source">
    <p:document href="Millioenenstudien/mult001mill01_01.xml"/>
  </p:input>
  <p:input port="pipeline">
    <p:document href="tei2epub.xpl"/>
  </p:input>
  <p:input port="parameters">
    <p:empty/>
  </p:input>
  <p:input port="options">
    <p:empty/>
  </p:input>
</cx:eval>

<!--
	rm -f $(EPUB)
	cd epub && zip -q0X ../$(EPUB) mimetype && zip -qXr9D ../$(EPUB) *
	java -jar $(EPUBCHECK) $(EPUB)
-->

</p:declare-step>
