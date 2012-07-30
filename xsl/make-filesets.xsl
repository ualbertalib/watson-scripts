<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
   exclude-result-prefixes="xs xd"
   version="2.0">
   <xd:doc scope="stylesheet">
      <xd:desc>
         <xd:p><xd:b>Created on:</xd:b> Jul 30, 2012</xd:p>
         <xd:p><xd:b>Author:</xd:b> peterbinkley</xd:p>
         <xd:p></xd:p>
      </xd:desc>
   </xd:doc>
   
   <xsl:output method="xml" indent="yes"/>
   
   <xsl:param name="sel">all</xsl:param>
   <xsl:param name="basedir">data</xsl:param>
   
   <xsl:template match="/">
   <fileset id="tiffs-{$sel}" dir="{$basedir}">
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
   </fileset>
   </xsl:template>
   
   <xsl:template match="tiff">
      <include name="{substring-after(@uri, concat($basedir, '/'))}"/>
   </xsl:template>
</xsl:stylesheet>