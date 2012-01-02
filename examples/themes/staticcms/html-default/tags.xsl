<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:s="http://enkel.wsgi.net/xml/staticcms"
		xmlns:m="http://enkel.wsgi.net/xml/markup"
		exclude-result-prefixes="s m">


	<!-- Called once for each tag in the generated grouped-tags file.

	The grouped tags file looks like this:
		<tags>
			<tag id="autogenerated-id">
				<posts>
					<post id="post-id" src="post-src"/>
					...
				</posts>
				<name>tag name</name>
			</tag>
		</tags>
	-->
	<xsl:template name="create-tag-file">
		<xsl:call-template name="create-html-doc">
			<xsl:with-param name="body">
<h1>
	<xsl:value-of select="@name"/>
</h1>
<ul id="tagindex">
	<xsl:choose>
		<xsl:when test="$sort-posts = 'mtime'">
			<xsl:for-each select="post">
				<xsl:sort select="@mtime" order="descending"/>
				<xsl:call-template name="postlist-post"/>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="post">
				<xsl:sort select="@id"/>
				<xsl:call-template name="postlist-post"/>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
</ul>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


	<xsl:template name="postlist-post">
		<li>
			<a href="{$postfile-prefix}{@id}.{$postfile-extension}">
				<xsl:value-of select="document(@src)/s:post/m:section/m:h"/>
			</a>
			<p>
				<xsl:value-of select="document(@src)/s:post/s:summary"/>
			</p>
		</li>
	</xsl:template>

</xsl:stylesheet>
