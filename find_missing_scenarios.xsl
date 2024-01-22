<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Compare the contents of a scenario or campaign list with an extra info list to find any 
		 scenarios missing extra info.  This will produce xml to insert into the extra info xml 
		 file.  Sample command line saxon9t -s:FortressItaly\Scenarios\Scenario_Listing.xml 
		 -xsl:find_missing_scenarios.xsl pathToExtraInfo=FortressItaly/Scenarios/Extra_Info.xml -->
	<xsl:output method="xml" indent="yes" />
	
	<xsl:param name="pathToExtraInfo" select="'Extra_Info.xml'"></xsl:param>
	
	<xsl:variable name="extraInfo" select="document($pathToExtraInfo)"></xsl:variable>
	
	<xsl:template match="/">
		<xsl:message>Using <xsl:value-of select="$pathToExtraInfo" /> first scenario '<xsl:value-of select="$extraInfo/scenarios/scenario[0]/@filename" />'</xsl:message>
		<xsl:choose>
		<xsl:when test="Scenario_Listing">
			<xsl:apply-templates select="Scenario_Listing" />
		</xsl:when>

		<xsl:when test="Campaign_Listing">
			<xsl:apply-templates select="Campaign_Listing" />
		</xsl:when>
	</xsl:choose>
	</xsl:template>
	
	<xsl:template match="Scenario_Listing">
		<xsl:message>Starting...</xsl:message>
		<xsl:for-each select="Scenario_List/Scenario">
			<xsl:message>Processing <xsl:value-of select="./filename"/></xsl:message>
			<xsl:choose>
				<xsl:when test="$extraInfo/scenarios/scenario/@filename=concat(current()/filename, '.btt')">
					<xsl:message>Found extra info for scenario <xsl:value-of select="concat(current()/filename, '.btt')"/></xsl:message>
				</xsl:when>
				<xsl:otherwise>
					<scenario author="information unavailable">
						<xsl:attribute name="filename"><xsl:value-of select="concat(current()/filename, '.btt')"/></xsl:attribute>
						<downloadurls>
							<downloadurl who=""></downloadurl>
						</downloadurls>
					</scenario>
<!-- 					<xsl:message>Need to make a new entry for scenario <xsl:value-of select="concat(current()/filename, '.btt')"/></xsl:message> -->
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>