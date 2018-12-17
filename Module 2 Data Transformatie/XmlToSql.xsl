<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" indent="no"/>
    <xsl:strip-space elements="*" />
    <xsl:template name="replace">
        <xsl:param name="text"/>
        <xsl:param name="searchString">'</xsl:param>
        <xsl:param name="replaceString">''</xsl:param>
        <xsl:choose>
            <xsl:when test="contains($text,$searchString)">
                <xsl:value-of select="substring-before($text,$searchString)"/>
                <xsl:value-of select="$replaceString"/>
                <!--  recursive call -->
                <xsl:call-template name="replace">
                    <xsl:with-param name="text" select="substring-after($text,$searchString)"/>
                    <xsl:with-param name="searchString" select="$searchString"/>
                    <xsl:with-param name="replaceString" select="$replaceString"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:for-each select="CountryList/country">
            <xsl:for-each select="city">
                <xsl:variable name="cityId">(SELECT CAST(N'' AS XML).value('xs:base64Binary("<xsl:value-of select="@city_id"/>")', 'BINARY(16)'))
                </xsl:variable>
                <xsl:variable name="cityName">
                    <xsl:copy>
                        <xsl:call-template name="replace">
                            <xsl:with-param name="text" select="@ci_name"/>
                        </xsl:call-template>
                    </xsl:copy>           
                </xsl:variable>
                <xsl:variable name="postalCode">
                    <xsl:value-of select="@post"/>
                </xsl:variable>
                <xsl:variable name="country">
                    <xsl:value-of select="../@lc"/>
                </xsl:variable>
                <xsl:variable name="lat">
                    <xsl:for-each select="geo">(select CAST('<xsl:value-of select="lat"/>'  AS FLOAT))
                    </xsl:for-each>
                </xsl:variable>
                <xsl:variable name="long">
                    <xsl:for-each select="geo">(select CAST('<xsl:value-of select="long"/>'  AS FLOAT))
                    </xsl:for-each>
                </xsl:variable>
                INSERT [dbo].[city] ([city_id], [city_name], [latitude], [longitude], [postal_code], [country_code]) VALUES (<xsl:value-of select="$cityId"/>, N'<xsl:value-of select="$cityName"/>', <xsl:value-of select="$lat"/>, <xsl:value-of select="$long"/>, N'<xsl:value-of select="$postalCode"/>',N'<xsl:value-of select="$country"/>');
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
