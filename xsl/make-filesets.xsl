<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:jhove="http://hul.harvard.edu/ois/xml/ns/jhove"
    xmlns:redirect="http://xml.apache.org/xalan/redirect" exclude-result-prefixes="xs xd redirect jhove"
    extension-element-prefixes="redirect" version="1.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jul 30, 2012</xd:p>
            <xd:p><xd:b>Author:</xd:b> peterbinkley</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>

    <xsl:output method="text"/>

    <xsl:param name="sel">all</xsl:param>
    <xsl:param name="basedir-raw">data</xsl:param>
    <xsl:param name="output"/>

    <!-- convert Windows paths to Unix, to match output of xquery -->
    <xsl:variable name="basedir" select="translate($basedir-raw, '\', '/')"/>

    <xsl:template match="/">
        <xsl:text># output: </xsl:text>
        <xsl:value-of select="$output"/>
        <xsl:text>&#x0a;</xsl:text>
        <xsl:choose>
            <xsl:when test="$sel='all'">
                <xsl:apply-templates select="/results/tiff"/>
            </xsl:when>
            <xsl:when test="$sel='good'">
                <xsl:apply-templates select="/results/tiff[status='Well-Formed and valid']"/>
            </xsl:when>
            <xsl:when test="$sel='bad'">
                <xsl:apply-templates select="/results/tiff[not(status='Well-Formed and valid')]"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tiff">
        <xsl:variable name="path" select="substring-after(@uri, concat($basedir, '/'))"/>
        <xsl:value-of select="$path"/>
        <xsl:text>&#x0a;</xsl:text>
        <xsl:if test="$sel='bad'">
            <redirect:open file="report-bad-tiff.txt" append="true"/>
            <redirect:write file="report-bad-tiff.txt">
                <xsl:text>Bad file: </xsl:text>
                <xsl:value-of select="$path"/>
                <xsl:text>&#x0a;Status: </xsl:text>
                <xsl:value-of select="status"/>
                <xsl:text>&#x0a;Message: </xsl:text>
                <xsl:value-of select="jhove:messages/jhove:message"/>
                <xsl:text>&#x0a;&#x0a;</xsl:text>
            </redirect:write>
            <redirect:close file="report-bad-tiff.txt"/>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>