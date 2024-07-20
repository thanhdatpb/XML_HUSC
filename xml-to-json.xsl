<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:json="http://json.org/">

  <xsl:output indent="no" omit-xml-declaration="yes" method="text" encoding="utf-8"/>
  <xsl:strip-space elements="*"/>
  <xsl:param name="debug" as="xs:boolean" select="false()"/>
  <xsl:param name="use-rabbitfish" as="xs:boolean" select="false()"/>
  <xsl:param name="use-badgerfish" as="xs:boolean" select="false()"/>
  <xsl:param name="use-namespaces" as="xs:boolean" select="false()"/>
  <xsl:param name="use-rayfish" as="xs:boolean" select="false()"/>
  <xsl:param name="jsonp" as="xs:string" select="''"/>
  <xsl:param name="skip-root" as="xs:boolean" select="false()"/>

  <xsl:function name="json:generate" as="xs:string">
    <xsl:param name="input" as="node()"/>

    <xsl:variable name="json-tree">
      <json:object>
        <xsl:copy-of select="if (not($use-rayfish)) then json:create-node($input, false()) else json:create-simple-node($input)"/>
      </json:object>
    </xsl:variable>

    <xsl:variable name="json-mtree">
      <xsl:choose>
        <xsl:when test="$skip-root">
          <xsl:copy-of select="$json-tree/json:object/json:member/json:value/child::node()"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="$json-tree"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="output">
      <xsl:choose>
        <xsl:when test="normalize-space($jsonp)">
          <xsl:value-of select="$jsonp"/><xsl:text>(</xsl:text><xsl:apply-templates select="$json-mtree" mode="json"/><xsl:text>)</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text/><xsl:apply-templates select="$json-mtree" mode="json"/><xsl:text/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:sequence select="$output"/>
  </xsl:function>
</xsl:stylesheet>
