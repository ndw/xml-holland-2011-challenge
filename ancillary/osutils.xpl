<p:library xmlns:p="http://www.w3.org/ns/xproc"
	   xmlns:cx="http://xmlcalabash.com/ns/extensions"
	   xmlns:cxo="http://xmlcalabash.com/ns/extensions/osutils"
	   xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic"
	   xmlns:xsd="http://www.w3.org/2001/XMLSchema"
           version="1.0">

<p:documentation xmlns="http://www.w3.org/1999/xhtml">
<div>
<h1>OS utils Library</h1>
<h2>Version 1.0</h2>
<p>The steps defined in this library provide information about the
underlying operating system and its environment.
</p>
</div>
</p:documentation>

<!-- ============================================================ -->

<p:documentation xmlns="http://www.w3.org/1999/xhtml">
<p>The <code>cxo:info</code> step returns information about the OS
on which the processor is running. It returns a <code>c:result</code> element
with attributes describing properties of the system. It <strong>should</strong>
include the following properties:</p>
<dl>
<dt>file-separator</dt>
<dd>The file separator; usually “/” on Unix, “\” on Windows.</dd>
<dt>path-separator</dt>
<dd>The path separator; usually “:” on Unix, “;” on Windows.</dd>
<dt>os-architecture</dt>
<dd>The operating system architecture, for example “i386”.</dd>
<dt>os-name</dt>
<dd>The name of the operating system, for example “Mac OS X”.</dd>
<dt>os-version</dt>
<dd>The version of the operating system, for example “10.5.6”.</dd>
<dt>cwd</dt>
<dd>The current working directory.</dd>
<dt>user-name</dt>
<dd>The login name of the effective user, for example “ndw”.</dd>
<dt>user-home</dt>
<dd>The home diretory of the effective user, for example “/home/ndw”.</dd>
</dl>
<p>The exact set of properties returned is implementation-dependent.</p>
</p:documentation>

<p:declare-step type="cxo:info">
  <p:output port="result"/>
</p:declare-step>

<!-- ============================================================ -->

<p:documentation xmlns="http://www.w3.org/1999/xhtml">
<p>The <code>cxo:cwd</code> step returns a single <code>c:result</code>
containing the current working directory. On systems which have no
concept of a working directory, this step returns the empty sequence.
</p>
<p>(This step is exactly duplicates the <code>cwd</code> attribute on
the <code>c:result</code> from <code>cxo:info</code>; it's just for
convenience.)</p>
</p:documentation>

<p:declare-step type="cxo:cwd">
  <p:output port="result" sequence="true"/>
</p:declare-step>

<!-- ============================================================ -->

<p:documentation xmlns="http://www.w3.org/1999/xhtml">
<p>The <code>cxo:env</code> step returns information about the environment.
It returns a <code>c:result</code> containing zero or more
<code>c:env</code> elements. Each <code>c:env</code> has
<code>name</code> and <code>value</code> attributes containing the name
and value of an environment variable.</p>
<p>On systems which nave no concept of an environment, this step returns
an empty <code>c:result</code>.</p>
</p:documentation>

<p:declare-step type="cxo:env">
  <p:output port="result"/>
</p:declare-step>

</p:library>
