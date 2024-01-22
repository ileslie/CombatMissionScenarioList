<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes" />
	<xsl:output name="sub-html-file-format" method="html" indent="yes" />

	<xsl:param name="gameName" select="'CM2x WW2'"></xsl:param>
    <xsl:param name="game" select="'BattleForNormandy'"></xsl:param>
    <xsl:param name="extrainfopath" select="'Scenarios'"></xsl:param>
    <xsl:param name="qb" select="'n'"></xsl:param>
    <xsl:param name="map" select="'n'"></xsl:param>
    
    <xsl:variable name="stylePrefix">
        <xsl:choose>
            <xsl:when test="$game = 'BattleForNormandy'">cmbn</xsl:when>
            <xsl:when test="$game = 'BlackSea'">cmbs</xsl:when>
            <xsl:when test="$game = 'ColdWar'">cmcw</xsl:when>
            <xsl:when test="$game = 'FinalBlitzkrieg'">cmfb</xsl:when>
            <xsl:when test="$game = 'FortressItaly'">cmfi</xsl:when>
            <xsl:when test="$game = 'ShockForce'">cmsf</xsl:when>
            <xsl:otherwise>cmrt</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="showingQBList" select="$qb = 'y'" />
    <xsl:variable name="showingMapList" select="$map = 'y'" />
    
    <xsl:variable name="extraInfo" select="document(concat($extrainfopath, '/Extra_Info.xml'))"/>

	<xsl:template match="/">

		<xsl:text disable-output-escaping='yes'>&lt;!doctype html&gt;&#xa;</xsl:text>
		<html lang="en">
			<head>
				<meta charset="utf-8" />
				<link rel="stylesheet" href="../../css/style.css?v=1" />
				<script src="../../javascript/sorttable.js">&#160;</script>
				<xsl:choose>
					<xsl:when test="Scenario_Listing/Scenario_List/containing_campaign">
						<title>
					       <xsl:value-of select="$gameName" /> - Scenario Listing for Campaign "<xsl:value-of select="Scenario_Listing/Scenario_List/containing_campaign" />"
						</title>
						<meta name="description">
							<xsl:attribute name="content">Details for <xsl:value-of select="$gameName" /> - Scenario Listing for Campaign "<xsl:value-of select="Scenario_Listing/Scenario_List/containing_campaign" /></xsl:attribute> 
						</meta>
					</xsl:when>

					<xsl:when test="Scenario_Listing">
						<title>
						  <xsl:value-of select="$gameName" /> - Scenario Listing
						</title>
						<meta name="description">
							<xsl:attribute name="content">Details for <xsl:value-of select="$gameName" /> - Scenario Listing</xsl:attribute> 
						</meta>
					</xsl:when>

					<xsl:when test="Campaign_Listing">
						<title>
							<xsl:value-of select="$gameName" /> - Campaign Listing
						</title>
						<meta name="description">
							<xsl:attribute name="content"><xsl:value-of select="$gameName" /> - Campaign Listing</xsl:attribute> 
						</meta>
					</xsl:when>
				</xsl:choose>
			</head>
			<body onload="initialTableSort()">
				<script>
				function initialTableSort()  {
					var myTH = document.getElementsByTagName("th")[0];
					sorttable.innerSortFunction.apply(myTH, []);
				}
				</script>
                <xsl:variable name="searchRowsString">
                    <xsl:choose>
                        <xsl:when test="Scenario_Listing and $showingMapList"> Maps</xsl:when>
                        <xsl:when test="Scenario_Listing and $showingQBList"> QBMaps</xsl:when>
                        <xsl:when test="Campaign_Listing"> Campaigns</xsl:when>
                        <xsl:otherwise> Scenarios</xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
				<xsl:choose>
					<xsl:when test="Scenario_Listing">
						<xsl:apply-templates select="Scenario_Listing" />
					</xsl:when>

					<xsl:when test="Campaign_Listing">
						<xsl:apply-templates select="Campaign_Listing" />
					</xsl:when>
				</xsl:choose>

				<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
				<script src="../../javascript/jquery.ba-throttle-debounce.min.js"></script>
				<script src="../../javascript/jquery.stickyheader.js"></script>
				<script type="text/javascript">
    				function updateRowCount (){
                        $("#rowCount").text(($('tr:visible').length - 2) + "<xsl:value-of select="$searchRowsString" />");
                    }
                    
					$(document).ready(function(){
						$('table.search-table').tableSearch({
							searchPlaceHolder:'search',
							caseSensitive:false
						});
						$('input[type="text"]#searchinput').val('');
						
						updateRowCount ();
					});
				</script>
                <script src="../../javascript/html-table-search.js">&#160;</script>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="Scenario_Listing">
        <header>
       	<div class="titleBar">
       		<a href="http://www.lesliesoftware.com"><img src="../../images/LeslieSoftwareLogo.jpg" /></a>
			<xsl:choose>
			<xsl:when test="Scenario_List/containing_campaign">
				<span class="title"><xsl:value-of select="$gameName" /> - Scenario Listing for Campaign "<xsl:value-of select="Scenario_List/containing_campaign" />"</span>
			</xsl:when>
			<xsl:when test="$showingQBList">
				<span class="title"><xsl:value-of select="$gameName" /> - QB Map Listing</span>
			</xsl:when>
			<xsl:when test="$showingMapList">
				<span class="title"><xsl:value-of select="$gameName" /> - Map Listing</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="title"><xsl:value-of select="$gameName" /> - Scenario Listing</span>
			</xsl:otherwise>
			</xsl:choose>
		</div>
        <xsl:call-template name="insertNavBar" />
        </header>

		<nav id="breadcrumb">
			<xsl:choose>
			<xsl:when test="$showingQBList">
				<a href="../../index.html">Home</a> &gt; <span>QB Map Listing</span>
			</xsl:when>
			<xsl:when test="$showingMapList">
				<a href="../../index.html">Home</a> &gt; <span>Map Listing</span>
			</xsl:when>
			<xsl:otherwise>
				<a href="../../index.html">Home</a> &gt; <span>Scenario Listing</span>
			</xsl:otherwise>
			</xsl:choose>
		</nav>
		<div>
		<xsl:attribute name="class">
			<xsl:choose>
			<xsl:when test="$showingQBList">scenario_qb_list-wrapper</xsl:when>
			<xsl:otherwise>scenario_list-wrapper</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<div class="search_bar">
		    <label id="rowCount"><xsl:choose>
	                <xsl:when test="$showingMapList"> Maps</xsl:when>
	                <xsl:when test="$showingQBList"> QBMaps</xsl:when>
	                <xsl:otherwise> Scenarios</xsl:otherwise>
	            </xsl:choose></label>
			<span><input type="text" placeholder="search" id="searchinput" />
			<a class="searchgo" id="searchgo"></a>
			<a class="searchcancel" id="searchcancel"></a></span>
		</div>
		<table id="main" class="sortable search-table">
			<thead>
				<tr>
					<th class="picture_col {$stylePrefix}">Title</th>
					<th class="description_col {$stylePrefix}">Battle Type / Description</th>
					<xsl:if test="not($showingQBList)">
					<th class="date_col {$stylePrefix}">Date (yyyy/mm/dd)</th>
					<th class="partofday_col {$stylePrefix}">Time of Day</th>
					<th class="length_col {$stylePrefix}">Length</th>
					<th class="battlesize_col {$stylePrefix}">Battle Size</th>
					</xsl:if>
					<th class="mapsize_col {$stylePrefix}">Map Size (Area - Width/Depth)</th>
					<th class="region_col {$stylePrefix}">Region</th>
					<th class="environment_col {$stylePrefix}">Envir.</th>
	                <xsl:if test="not($showingQBList)">
					<th class="weather_col {$stylePrefix}">Weather</th>
					</xsl:if>
					<th class="modulesrequired_col {$stylePrefix}">Modules Required</th>
	                <xsl:if test="not($showingQBList)">
					<th class="author_col {$stylePrefix}">Author</th>
					<th class="sizemodifier_col {$stylePrefix}">The Blitz Size Modifier</th>
					<th class="links_col {$stylePrefix}">Links</th>
					</xsl:if>
				</tr>
			</thead>
			<tbody>
			
			<xsl:for-each select="Scenario_List/Scenario">
				<xsl:variable name="curScenarioHTMLFilePath">
				    <xsl:call-template name="stringToSafeFileName">
				        <xsl:with-param name="fileNameStr" select="concat(filename, '.html')" />
				    </xsl:call-template>
				</xsl:variable>
				<xsl:variable name="scenarioExtraInfo" select="$extraInfo/scenarios/scenario[@filename=concat(current()/filename,'.btt')]"/>
		
				<!-- Generate a line in the table -->
				<tr>
					<td class="title">
						<xsl:value-of select="Title/number_in_campaign" />
						<br></br>
						<xsl:choose>
                        <xsl:when test="not($showingQBList)">
	                        <!-- Scenario title with link to detail page -->
							<a>
								<xsl:attribute name="href"><xsl:value-of select="$curScenarioHTMLFilePath" /></xsl:attribute>
								<xsl:value-of select="translate(Title/battle_title, '_', ' ')" />
							</a>
						</xsl:when>
						<xsl:otherwise>
							<!-- QB title -->
                            <xsl:value-of select="Title/battle_title" />
						</xsl:otherwise>
						</xsl:choose>
						<br></br>
						<br></br>
					
						<xsl:choose>
                        <xsl:when test="not($showingQBList)">
                        	<!-- Scenario image with link to detail page -->
							<a>
								<xsl:attribute name="href"><xsl:value-of select="$curScenarioHTMLFilePath" /></xsl:attribute>
							<img>
								<xsl:attribute name="class">scenario</xsl:attribute>
								<xsl:attribute name="src">
									<xsl:call-template name="convertExtensionToJPG">
										<xsl:with-param name="url"><xsl:value-of select="picture_link" /></xsl:with-param>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:attribute name="alt">No picture provided!</xsl:attribute>
							</img>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<!-- QB image  -->
							<img>
								<xsl:attribute name="class">scenario</xsl:attribute>
								<xsl:attribute name="src">
									<xsl:call-template name="convertExtensionToJPG">
										<xsl:with-param name="url"><xsl:value-of select="picture_link" /></xsl:with-param>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:attribute name="alt">No picture provided!</xsl:attribute>
							</img>
						</xsl:otherwise>
						</xsl:choose>
						<br></br>
						<span class="filename"><xsl:call-template name="breakLongFileNameForDisplay">
							<xsl:with-param name="fileNameStr" select="filename"/>
						</xsl:call-template>.btt</span>
					</td>
					<td class="description">
						<p><xsl:value-of select="battle_type" /></p>
						<p><xsl:value-of select="description" /></p>
					</td>
                    <xsl:if test="not($showingQBList)">
					<td class="date">
						<xsl:choose>
							<xsl:when test="$game = 'ShockForce' and game_version = 'Unknown'">
								unknown
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="formatDate">
									<xsl:with-param name="date" select="date" />
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="partofday">
						<xsl:choose>
							<xsl:when test="$game = 'ShockForce' and game_version = 'Unknown'">
								unknown
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="part_of_day" />
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="length">
						<xsl:choose>
							<xsl:when test="$game = 'ShockForce' and game_version = 'Unknown'">
								unknown
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="length" />
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="battlesize">
						<xsl:value-of select="battle_size" />
					</td>
					</xsl:if>
					<td class="mapsize">
						<xsl:value-of select="Map_Size/map_area" />
						<br></br>
						(<xsl:value-of select="Map_Size/map_width" />/<xsl:value-of select="Map_Size/map_depth" />)
					</td>
					<td class="region">
						<xsl:choose>
							<xsl:when test="$game = 'ShockForce' and game_version = 'Unknown'">
								unknown
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="region" />
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="environment">
						<xsl:value-of select="environment" />
					</td>
                    <xsl:if test="not($showingQBList)">
					<td class="weather">
						<xsl:choose>
							<xsl:when test="$game = 'ShockForce' and game_version = 'Unknown'">
								unknown
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="weather" />
							</xsl:otherwise>
						</xsl:choose>
					</td>
					</xsl:if>
					<td class="modulesrequired">
						<xsl:value-of select="Modules_Required/module1" />
						<br></br>
						<br></br>
						<xsl:value-of select="Modules_Required/module2" />
						<br></br>
						<br></br>
						<xsl:value-of select="Modules_Required/module3" />
						<br></br>
						<br></br>
						<xsl:value-of select="Modules_Required/module4" />
					</td>
                    <xsl:if test="not($showingQBList)">
					<td class="author">
						<xsl:value-of select="$scenarioExtraInfo/@author" />
					</td>
					<td class="sizemodifier">
						<xsl:choose>
							<xsl:when test="$game = 'ShockForce' and game_version = 'Unknown'">
								unknown
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="size_modifier" />
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td class="links">
						<xsl:apply-templates select="$scenarioExtraInfo/urls_list/*" mode="column"><xsl:sort select="name(.)" order="descending" /><xsl:sort select="./@primary" /></xsl:apply-templates>
					</td>
					</xsl:if>
				</tr>
		
				<xsl:if test="not($showingQBList)">
					<xsl:call-template name="createScenarioDetailPage">
						<xsl:with-param name="fileName"><xsl:value-of select="$curScenarioHTMLFilePath"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="extraInfo" select="$scenarioExtraInfo"></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:for-each>
			</tbody>
		</table>
		</div>

	</xsl:template>
	
	<xsl:template match="Campaign_Listing">
        <header>
			<div class="titleBar"><a href="http://www.lesliesoftware.com"><img src="../../images/LeslieSoftwareLogo.jpg" /></a>
			<span class="title"><xsl:value-of select="$gameName" /> - Campaign Listing</span></div>
	        <xsl:call-template name="insertNavBar" />
        </header>

        <nav id="breadcrumb">
            <a href="../../index.html">Home</a> &gt; <span>Campaign Listing</span>
        </nav>
        <div class="campaign_list-wrapper">
        <div class="search_bar">
            <label id="rowCount">Campaigns</label>
            <span><input type="text" placeholder="search" id="searchinput" />
            <a class="searchgo" id="searchgo"></a>
            <a class="searchcancel" id="searchcancel"></a></span>
        </div>
        <table id="main" class="sortable search-table">
			<thead>
				<tr>
					<th class="picture_col {$stylePrefix}">Title</th>
					<th class="description_col {$stylePrefix}">Description</th>
					<th class="date_col {$stylePrefix}">Date (yyyy/mm/dd)</th>
					<th class="region_col {$stylePrefix}">Region</th>
					<th class="modulesrequired_col {$stylePrefix}">Modules Required</th>
					<th class="author_col {$stylePrefix}">Author</th>
					<th class="links_col {$stylePrefix}">Links</th>
				</tr>
			</thead>
			<tbody>
        
			<xsl:for-each select="Campaign_List/Campaign">
				<xsl:variable name="curCampaignHTMLFilePath">
				    <xsl:call-template name="stringToSafeFileName">
				        <xsl:with-param name="fileNameStr" select="concat(filename, '.html')" />
				    </xsl:call-template>
				</xsl:variable>
				<xsl:variable name="scenarioExtraInfo" select="$extraInfo/scenarios/scenario[@filename=concat(current()/filename,'.cam')]"/>
		
				<!-- Generate a line in the table -->
				<tr>
					<td class="title">
						<a>
							<xsl:attribute name="href"><xsl:value-of select="$curCampaignHTMLFilePath" /></xsl:attribute>
	                        <xsl:value-of select="title" />
                        </a>
						<br></br>
						<br></br>
						<a>
							<xsl:attribute name="href"><xsl:value-of select="$curCampaignHTMLFilePath" /></xsl:attribute>
						<img>
							<xsl:attribute name="class">scenario</xsl:attribute>
							<xsl:attribute name="src">
								<xsl:call-template name="convertExtensionToJPG">
									<xsl:with-param name="url"><xsl:value-of select="picture_link" /></xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:attribute name="alt">No picture provided!</xsl:attribute>
						</img>
						</a>
						<br></br>
						<span class="filename"><xsl:call-template name="breakLongFileNameForDisplay">
							<xsl:with-param name="fileNameStr" select="filename"/>
						</xsl:call-template>.cam</span>
					</td>
					<td class="description">
						<xsl:value-of select="description" />
					</td>
					<td class="date">
					   <xsl:choose>
					   <xsl:when test="date_range/earliest_date != date_range/latest_date">
                            <xsl:call-template name="formatDate">
                                <xsl:with-param name="date" select="date_range/earliest_date" />
                            </xsl:call-template>
                            - 
                            <xsl:call-template name="formatDate">
                                <xsl:with-param name="date" select="date_range/latest_date" />
                            </xsl:call-template>
					   </xsl:when>
					   <xsl:otherwise>
                            <xsl:call-template name="formatDate">
                                <xsl:with-param name="date" select="date_range/earliest_date" />
                            </xsl:call-template>
					   </xsl:otherwise>
					   </xsl:choose>
					</td>
					<td class="region">
					   <xsl:for-each select="region_list/*">
                            <xsl:value-of select="current()" /><xsl:if test="position() &lt; last()"><br></br><br></br></xsl:if>
                        </xsl:for-each>
					</td>
					<td class="modulesrequired">
						<xsl:value-of select="Modules_Required/module1" />
						<br></br>
						<br></br>
						<xsl:value-of select="Modules_Required/module2" />
						<br></br>
						<br></br>
						<xsl:value-of select="Modules_Required/module3" />
						<br></br>
						<br></br>
						<xsl:value-of select="Modules_Required/module4" />
					</td>
					<td class="author">
						<xsl:value-of select="$scenarioExtraInfo/@author" />
					</td>
					<td class="links">
						<xsl:apply-templates select="$scenarioExtraInfo/urls_list/*" mode="column"><xsl:sort select="name(.)" order="descending" /><xsl:sort select="./@primary" /></xsl:apply-templates>
					</td>
				</tr>
		
				<xsl:call-template name="createCampaignDetailPage">
					<xsl:with-param name="fileName"><xsl:value-of select="$curCampaignHTMLFilePath"></xsl:value-of></xsl:with-param>
					<xsl:with-param name="extraInfo" select="$scenarioExtraInfo"></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			</tbody>
		</table>
		</div>
	</xsl:template>

	<xsl:template name="createScenarioDetailPage">
		<xsl:param name="fileName"></xsl:param>
		<xsl:param name="extraInfo"></xsl:param>
		<xsl:param name="campaign" select="''"></xsl:param>
		<xsl:param name="scenario" select="."></xsl:param>

		<xsl:variable name="scenarioPictureUrl">
        	<xsl:choose>
        	<xsl:when test="$campaign">
				<xsl:value-of select="concat($campaign/filename, ' scenarios', '/', $scenario/picture_link)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$scenario/picture_link" />
			</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<!-- Generate a scenario specific file -->
		<xsl:result-document href="{$fileName}" format="sub-html-file-format">
			<xsl:text disable-output-escaping='yes'>&lt;!doctype html&gt;&#xa;</xsl:text>
			
			<html lang="en">
			<head>
				<meta charset="utf-8" />
				<title>Details for <xsl:value-of select="$scenario/Title/battle_title" /></title>
				<meta name="description">
					<xsl:attribute name="content">Details for <xsl:value-of select="$scenario/Title/battle_title" /></xsl:attribute> 
				</meta>
				<link rel="stylesheet" href="../../css/style.css?v=1" />
			</head>
			<body>
				<header>
		        	<div class="titleBar"><a href="http://www.lesliesoftware.com"><img src="../../images/LeslieSoftwareLogo.jpg" /></a>
		        	<xsl:choose>
		        	<xsl:when test="$campaign">
						<span class="title"><xsl:value-of select="$gameName" /> - Campaign "<xsl:value-of select="$campaign/title" />" - Scenario "<xsl:value-of select="$scenario/Title/battle_title" />"</span>
		        	</xsl:when>
		        	<xsl:otherwise>
						<span class="title"><xsl:value-of select="$gameName" /> - Scenario "<xsl:value-of select="$scenario/Title/battle_title" />"</span>
		        	</xsl:otherwise>
		        	</xsl:choose>
		        	</div>
			        <xsl:call-template name="insertNavBar" />
				</header>
				<nav id="breadcrumb">
		        	<xsl:choose>
		        	<xsl:when test="$campaign">
						<a href="../../index.html">Home</a> &gt; <a href="index.html">Campaign Listing</a> &gt; <span>
						<a>
							<xsl:attribute name="href">
							    <xsl:call-template name="stringToSafeFileName">
                                    <xsl:with-param name="fileNameStr" select="concat($campaign/filename, '.html')" />
                                </xsl:call-template>
							</xsl:attribute>
							<xsl:value-of select="$campaign/title" />
						</a>
						</span> &gt; <span><xsl:value-of select="$scenario/Title/battle_title" /></span>
		        	</xsl:when>
					<xsl:when test="$showingQBList">
						<a href="../../index.html">Home</a> &gt; <a href="index.html">QB Map Listing</a> &gt; <span><xsl:value-of select="$scenario/Title/battle_title" /></span>
					</xsl:when>
					<xsl:when test="$showingMapList">
						<a href="../../index.html">Home</a> &gt; <a href="index.html">Map Listing</a> &gt; <span><xsl:value-of select="$scenario/Title/battle_title" /></span>
					</xsl:when>
		        	<xsl:otherwise>
						<a href="../../index.html">Home</a> &gt; <a href="index.html">Scenario Listing</a> &gt; <span><xsl:value-of select="$scenario/Title/battle_title" /></span>
		        	</xsl:otherwise>
		        	</xsl:choose>
				</nav>
				<div id="scenarioInfo">
					<div class="create">
						<span class="info_label"></span>Author: <span class="info_value"><xsl:value-of select="$extraInfo/@author" /></span>
						<span class="info_label">Created with version:</span><span class="info_value">
						<xsl:choose>
							<xsl:when test="$game = 'ShockForce' and $scenario/game_version = 'Unknown'">
								1.x
							</xsl:when>
                            <xsl:when test="$extraInfo/@version_override">
                                <xsl:value-of select="$extraInfo/@version_override" />
                            </xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$scenario/game_version" />
							</xsl:otherwise>
						</xsl:choose>
						</span>
						<span class="info_label">Requires module(s): </span>
						<span class="info_value"><xsl:for-each select="$scenario/Modules_Required/*">
							<xsl:value-of select="current()" /><xsl:if test="position() &lt; last()">, </xsl:if>
						</xsl:for-each></span>
						<span class="info_label">Uses mod tags:</span>
						<span class="info_value"><xsl:for-each select="$scenario/Mod_Tags/mod_tag">
							<xsl:value-of select="current()" /><xsl:if test="position() &lt; last()">, </xsl:if>
						</xsl:for-each></span>
					</div>
					
					<div class="summary {$stylePrefix}">
						<p class="basic_info">
							<img class="basic_info">
								<xsl:attribute name="src">
									<xsl:call-template name="convertExtensionToJPG">
										<xsl:with-param name="url"><xsl:value-of select="$scenarioPictureUrl" /></xsl:with-param>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:attribute name="alt">No picture provided!</xsl:attribute>
							</img>
							<xsl:value-of select="$scenario/description" />
							<br/>
                            <br/>
                            <xsl:value-of select="$extraInfo/additional_info" />
						</p>
						<div class="availability">
						<xsl:choose>
				        	<xsl:when test="$campaign">
								<p class="stock">Included with the campaign</p>
				        	</xsl:when>
							<xsl:when test="$extraInfo/@stock='y'">
								<p class="stock">Stock Scenario</p>
							</xsl:when>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="$extraInfo/urls_list">
								<p>
									<xsl:apply-templates select="$extraInfo/urls_list/*"><xsl:sort select="name(.)" order="descending" /><xsl:sort select="./@primary" /></xsl:apply-templates>
								</p>
							</xsl:when>
							<xsl:when test="not($campaign or $extraInfo/@stock='y')">
								<p>No download information found.</p>
							</xsl:when>
						</xsl:choose>
						</div>
					</div>
					<div class="details">
						<table class="detail_info">
							<tbody>
							<tr>
								<td class="detail_label">Battle Type:</td>
								<td class="detail_value"><xsl:value-of select="$scenario/battle_type" /></td>
								<td class="detail_label">Date:</td>
								<td class="detail_value">
									<xsl:choose>
										<xsl:when test="$game = 'ShockForce' and $scenario/game_version = 'Unknown'">
											unknown
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="formatDate">
												<xsl:with-param name="date" select="$scenario/date" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<tr>
								<td class="detail_label">Time:</td>
								<td class="detail_value">
									<xsl:choose>
										<xsl:when test="$game = 'ShockForce' and $scenario/game_version = 'Unknown'">
											unknown
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$scenario/part_of_day" /><xsl:text> </xsl:text><xsl:value-of select="$scenario/time_of_day" />
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<td class="detail_label">Length:</td>
								<td class="detail_value">
									<xsl:choose>
										<xsl:when test="$game = 'ShockForce' and $scenario/game_version = 'Unknown'">
											unknown
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$scenario/length" />
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<tr>
								<td class="detail_label">Size:</td>
								<td class="detail_value">
									<xsl:choose>
										<xsl:when test="$game = 'ShockForce' and $scenario/game_version = 'Unknown'">
											unknown
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$scenario/battle_size" />
										</xsl:otherwise>
									</xsl:choose>
								</td>
                                <td class="detail_label">Terrain:</td>
                                <td class="detail_value">
                                    <xsl:choose>
                                        <xsl:when test="$game = 'ShockForce' and $scenario/game_version = 'Unknown'">
                                            unknown
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$scenario/environment" />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
							</tr>
							<tr>
								<td class="detail_label">Map Size:</td>
								<td class="detail_value">w: <xsl:value-of select="$scenario/Map_Size/map_width" /> d: <xsl:value-of select="$scenario/Map_Size/map_depth" /></td>
								<td class="detail_label">Area:</td>
								<td class="detail_value"><xsl:value-of select="$scenario/Map_Size/map_area" /></td>
							</tr>
							<tr>
								<td class="detail_label">Region:</td>
								<td class="detail_value">
									<xsl:choose>
										<xsl:when test="$game = 'ShockForce' and $scenario/game_version = 'Unknown'">
											unknown
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$scenario/region" />
										</xsl:otherwise>
									</xsl:choose>
								</td>
                                <td class="detail_label">Early Intel:</td>
                                <td class="detail_value">
                                    <xsl:choose>
                                        <xsl:when test="$game = 'ShockForce' and $scenario/game_version = 'Unknown'">
                                            unknown
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$scenario/early_intel" />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
							</tr>
							<tr>
								<td class="detail_label">Weather:</td>
								<td class="detail_value">
									<xsl:choose>
										<xsl:when test="$game = 'ShockForce' and $scenario/game_version = 'Unknown'">
											unknown
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$scenario/weather" /> and <xsl:value-of select="$scenario/temperature" />
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<td class="detail_label">Ground Conditions:</td>
								<td class="detail_value">
									<xsl:choose>
										<xsl:when test="$game = 'ShockForce' and $scenario/game_version = 'Unknown'">
											unknown
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$scenario/ground_condition" />
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<tr>
                                <td class="detail_label">theBlitz Size Modifier:</td>
                                <td class="detail_value">
                                    <xsl:choose>
                                        <xsl:when test="$game = 'ShockForce' and $scenario/game_version = 'Unknown'">
                                            unknown
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$scenario/size_modifier" />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                                <td class="detail_label"></td>
                                <td class="detail_value"></td>
							</tr>
	                        <xsl:choose>
	                            <xsl:when test="$campaign"></xsl:when>
	                            <xsl:otherwise>
									<tr>
                                        <td class="detail_label">Filename:</td>
                                        <td class="detail_value" colspan="3"><xsl:call-template name="breakLongFileNameForDisplay">
                                            <xsl:with-param name="fileNameStr" select="$scenario/filename"/>
                                        </xsl:call-template>.btt</td>
                                    </tr>
	                            </xsl:otherwise>
	                        </xsl:choose>
							</tbody>
						</table>
					</div>
				</div>
			</body>
			</html>
		</xsl:result-document>
	</xsl:template>
	
	<xsl:template name="createCampaignDetailPage">
		<xsl:param name="fileName"></xsl:param>
		<xsl:param name="extraInfo"></xsl:param>

	    <xsl:variable name="extraCampaignScenarioInfo" select="document(concat($extrainfopath, '/Extra_Info-', filename, '.xml'))"/>
	    <xsl:variable name="campaignScenarioListing" select="document(concat($extrainfopath, '/', filename, ' scenarios/', filename, ' - Scenario_Listing.xml'))" />

		<!-- Generate a scenario specific file -->
		<xsl:result-document href="{$fileName}" format="sub-html-file-format">
			<xsl:text disable-output-escaping='yes'>&lt;!doctype html&gt;&#xa;</xsl:text>
			
			<html lang="en">
			<head>
				<meta charset="utf-8" />
				<title>Details for <xsl:value-of select="title" /></title>
				<meta name="description">
					<xsl:attribute name="content">Details for <xsl:value-of select="title" /></xsl:attribute> 
				</meta>
				<link rel="stylesheet" href="../../css/style.css?v=1" />
				<script src="../../javascript/sorttable.js">&#160;</script>
			</head>
			<body onload="initialTableSort()">
				<script>
				function initialTableSort()  {
					var myTH = document.getElementsByTagName("th")[0];
					sorttable.innerSortFunction.apply(myTH, []);
				}
				</script>
				<header>
		        	<div class="titleBar"><a href="http://www.lesliesoftware.com"><img src="../../images/LeslieSoftwareLogo.jpg" /></a>
					<span class="title"><xsl:value-of select="$gameName" />  - Campaign "<xsl:value-of select="title" />"</span></div>
			        <xsl:call-template name="insertNavBar" />
				</header>
				<nav id="breadcrumb">
					<a href="../../index.html">Home</a> &gt; <a href="index.html">Campaign Listing</a> &gt; <span><xsl:value-of select="title" /></span>
				</nav>
				<div id="scenarioInfo">
					<div class="create">
						<span class="info_label"></span>Author: <span class="info_value"><xsl:value-of select="$extraInfo/@author" /></span>
						<span class="info_label">Created with version</span>
						<span class="info_value">
							<xsl:choose>
								<xsl:when test="$game = 'ShockForce' and game_version = 'Unknown'">
									1.x
								</xsl:when>
	                            <xsl:when test="$extraInfo/@version_override">
	                                <xsl:value-of select="$extraInfo/@version_override" />
	                            </xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="game_version" />
								</xsl:otherwise>
							</xsl:choose>
						</span>
						<span class="info_label">Requires module(s): </span>
						<span class="info_value"><xsl:for-each select="Modules_Required/*">
							<xsl:value-of select="current()" /><xsl:if test="position() &lt; last()">, </xsl:if>
						</xsl:for-each></span>
					</div>
					
					<div class="summary {$stylePrefix}">
						<p class="basic_info">
							<img class="basic_info">
								<xsl:attribute name="src">
									<xsl:call-template name="convertExtensionToJPG">
										<xsl:with-param name="url"><xsl:value-of select="picture_link" /></xsl:with-param>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:attribute name="alt">No picture provided!</xsl:attribute>
							</img>
							<xsl:value-of select="description" />
						</p>
						<div class="availability">
						<xsl:choose>
							<xsl:when test="$extraInfo/@stock='y'">
								<p class="stock">Stock Campaign</p>
							</xsl:when>
							<xsl:when test="$extraInfo/urls_list">
								<p>
									<xsl:apply-templates select="$extraInfo/urls_list/*"><xsl:sort select="name(.)" order="descending" /><xsl:sort select="./@primary" /></xsl:apply-templates>
								</p>
							</xsl:when>
							<xsl:otherwise>
								<p>No download information found.</p>
							</xsl:otherwise>
						</xsl:choose>
						</div>
					</div>
					
					<div class="details">
                        <table class="detail_info">
                            <tbody>
                            <tr>
                                <td class="detail_label">Date Range:</td>
                                <td class="detail_value">
                                    <xsl:choose>
			                       <xsl:when test="date_range/earliest_date != date_range/latest_date">
			                            <xsl:call-template name="formatDate">
			                                <xsl:with-param name="date" select="date_range/earliest_date" />
			                            </xsl:call-template><xsl:text> - </xsl:text><xsl:call-template name="formatDate">
			                                <xsl:with-param name="date" select="date_range/latest_date" />
			                            </xsl:call-template>
			                       </xsl:when>
			                       <xsl:otherwise>
			                            <xsl:call-template name="formatDate">
			                                <xsl:with-param name="date" select="date_range/earliest_date" />
			                            </xsl:call-template>
			                       </xsl:otherwise>
			                       </xsl:choose>
                                </td>
                                <td class="detail_label">Region:</td>
                                <td class="detail_value">
                                    <xsl:for-each select="region_list/*">
			                            <xsl:value-of select="current()" /><xsl:if test="position() &lt; last()"><xsl:text> </xsl:text></xsl:if>
			                        </xsl:for-each>
                                </td>
                            </tr>
                            <tr>
                                <td class="detail_label">Filename:</td>
                                <td class="detail_value" colspan="3"><xsl:call-template name="breakLongFileNameForDisplay">
                                    <xsl:with-param name="fileNameStr" select="./filename"/>
                                </xsl:call-template>.cam</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    
					<div class="decisionTree">
						<h2>Campaign Decision Tree:</h2>
						<img>
							<xsl:attribute name="class">campaign_tree</xsl:attribute>
							<xsl:attribute name="src"><xsl:value-of select="campaign_tree_link" /></xsl:attribute>
							<xsl:attribute name="alt">No campaign decision tree available!</xsl:attribute>
						</img>
					</div>
					
					<div class="campaign_scenario_list-wrapper">
					<div class="search_bar">
						<input type="text" placeholder="search" id="searchinput" />
						<a class="searchgo" id="searchgo"></a>
						<a class="searchcancel" id="searchcancel"></a>
					</div>
					<table id="main" class="sortable search-table" style="table-layout:fixed">
						<thead>
						<tr>
							<th class="title_col {$stylePrefix}">
								Battle Number &amp; 
								<br></br>
								Battle Name
							</th>
							<th class="winthreshold_col {$stylePrefix}">Win Threshold</th>
							<th class="nextbattle_col {$stylePrefix}">Next Battle after Win</th>
							<th class="nextbattle_col {$stylePrefix}">Next Battle after Defeat</th>
							<th class="victory_col {$stylePrefix}">Minimum Required Victory</th>
							<th class="victory_col {$stylePrefix}">Maximum Allowed Victory</th>
							<th class="repair_col {$stylePrefix}">Blue Refit</th>
							<th class="repair_col {$stylePrefix}">Blue Repair Vehicle</th>
							<th class="repair_col {$stylePrefix}">Blue Resupply</th>
							<th class="repair_col {$stylePrefix}">Blue Rest</th>
							<th class="repair_col {$stylePrefix}">Red Refit</th>
							<th class="repair_col {$stylePrefix}">Red Repair Vehicle</th>
							<th class="repair_col {$stylePrefix}">Red Resupply</th>
							<th class="repair_col {$stylePrefix}">Red Rest</th>
						</tr>
						</thead>
	
						<tbody>	
						<xsl:for-each select="Campaign_Decision_Block">
							<xsl:variable name="curCampaignScenarioHTMLFilePath">
							    <xsl:call-template name="stringToSafeFileName">
							        <xsl:with-param name="fileNameStr" select="concat(../filename, Scenario_Title/number_in_campaign, '.html')" />
							    </xsl:call-template>
							</xsl:variable>
							<xsl:variable name="campaignScenarioExtraInfo" select="$extraCampaignScenarioInfo/scenarios/scenario[@filename=concat(current()/filename, '.btt')]"/>
							<tr>
								<td class="title">
									<a>
										<xsl:attribute name="href" select="$curCampaignScenarioHTMLFilePath"/>
										<xsl:value-of select="Scenario_Title/number_in_campaign" />
										<br></br>
										<xsl:value-of select="Scenario_Title/battle_title" />
									</a>
								</td>
								<td class="winthreshold">
									<xsl:value-of select="win_threshold" />
								</td>
								<td class="nextbattle">
									<xsl:value-of select="next_battle_win" />
								</td>
								<td class="nextbattle">
									<xsl:value-of select="next_battle_lose" />
								</td>
								<td class="victory">
									<xsl:value-of select="minimum_required_victory" />
								</td>
								<td class="victory">
									<xsl:value-of select="maximum_allowed_victory" />
								</td>
								<td class="repair">
									<xsl:value-of select="blue_refit" />
								</td>
								<td class="repair">
									<xsl:value-of select="blue_repair_vehicle" />
								</td>
								<td class="repair">
									<xsl:value-of select="blue_resupply" />
								</td>
								<td class="repair">
									<xsl:value-of select="blue_rest" />
								</td>
								<td class="repair">
									<xsl:value-of select="red_refit" />
								</td>
								<td class="repair">
									<xsl:value-of select="red_repair_vehicle" />
								</td>
								<td class="repair">
									<xsl:value-of select="red_resupply" />
								</td>
								<td class="repair">
									<xsl:value-of select="red_rest" />
								</td>
							</tr>
							
							<!-- Create a detail page for each campaign scenario -->
							<xsl:call-template name="createScenarioDetailPage">
								<xsl:with-param name="fileName">
									<xsl:value-of select="$curCampaignScenarioHTMLFilePath"></xsl:value-of>
								</xsl:with-param>
								<xsl:with-param name="extraInfo" select="$campaignScenarioExtraInfo"></xsl:with-param>
								<xsl:with-param name="campaign" select=".."></xsl:with-param>
								<xsl:with-param name="scenario" select="$campaignScenarioListing/Scenario_Listing/Scenario_List/Scenario[filename=current()/filename]" />
							</xsl:call-template>
						</xsl:for-each>
						</tbody>
					</table>
					</div>
				</div>

				<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
				<script src="../../javascript/jquery.ba-throttle-debounce.min.js"></script>
				<script src="../../javascript/jquery.stickyheader.js"></script>
				<script src="../../javascript/html-table-search.js">&#160;</script>
				<script type="text/javascript">
					$(document).ready(function(){
						$('table.search-table').tableSearch({
							searchPlaceHolder:'search',
							caseSensitive:false
						});
						$('input[type="text"]#searchinput').val('');
					});
				</script>
			</body>
			</html>
		</xsl:result-document>
	</xsl:template>
	
	<xsl:template match="downloadurl">
		<a class="downloadbutton"><xsl:attribute name="href"><xsl:value-of select="." /></xsl:attribute><xsl:value-of select="translate(./@who, ' ', '&#160;')" />&#160;download</a>
		<xsl:text> </xsl:text>
	</xsl:template>
	
	<xsl:template match="infourl">
		<a class="infobutton"><xsl:attribute name="href"><xsl:value-of select="." /></xsl:attribute><xsl:value-of select="translate(./@who, ' ', '&#160;')" />&#160;information</a>
		<xsl:text> </xsl:text>
	</xsl:template>

	<xsl:template match="downloadurl" mode="column">
		<a><xsl:attribute name="href"><xsl:value-of select="." /></xsl:attribute><xsl:attribute name="target">_blank</xsl:attribute>
		<img src="../../images/download.png" /><xsl:value-of select="translate(./@who, ' ', '&#160;')" /></a>
		<br/>
	</xsl:template>
	
	<xsl:template match="infourl" mode="column">
		<a><xsl:attribute name="href"><xsl:value-of select="." /></xsl:attribute><xsl:attribute name="target">_blank</xsl:attribute>
		<img src="../../images/info.png" /><xsl:value-of select="translate(./@who, ' ', '&#160;')" /></a>
		<br/>
	</xsl:template>

    <xsl:template name="insertNavBar">
            <nav>
                <ul>
                    <li><a href="../../index.html">Home</a></li>
                    <li><a href="#">Battle For Normandy <span class="toggle">Expand</span><span class="caret"></span></a>
                        <nav>
                            <ul>
                                <li><a href="../../BattleForNormandy/Scenarios/index.html">Scenarios</a></li>
                                <li><a href="../../BattleForNormandy/Campaigns/index.html">Campaigns</a></li>
                                <li><a href="../../BattleForNormandy/Maps/index.html">Maps</a></li>
                                <li><a href="../../BattleForNormandy/QBMaps/index.html">QBMaps</a></li>
                            </ul>
                        </nav></li>
                    <li><a href="#">Final Blitzkrieg <span class="toggle">Expand</span><span class="caret"></span></a>
                        <nav>
                            <ul>
                                <li><a href="../../FinalBlitzkrieg/Scenarios/index.html">Scenarios</a></li>
                                <li><a href="../../FinalBlitzkrieg/Campaigns/index.html">Campaigns</a></li>
                                <li><a href="../../FinalBlitzkrieg/Maps/index.html">Maps</a></li>
                                <li><a href="../../FinalBlitzkrieg/QBMaps/index.html">QBMaps</a></li>
                            </ul>
                        </nav></li>
                    <li><a href="#">Fortress Italy <span class="toggle">Expand</span><span class="caret"></span></a>
                        <nav>
                            <ul>
                                <li><a href="../../FortressItaly/Scenarios/index.html">Scenarios</a></li>
                                <li><a href="../../FortressItaly/Campaigns/index.html">Campaigns</a></li>
                                <li><a href="../../FortressItaly/Maps/index.html">Maps</a></li>
                                <li><a href="../../FortressItaly/QBMaps/index.html">QBMaps</a></li>
                            </ul>
                        </nav></li>
                    <li><a href="#">Red Thunder <span class="toggle">Expand</span><span class="caret"></span></a>
                        <nav>
                            <ul>
                                <li><a href="../../RedThunder/Scenarios/index.html">Scenarios</a></li>
                                <li><a href="../../RedThunder/Campaigns/index.html">Campaigns</a></li>
                                <li><a href="../../RedThunder/Maps/index.html">Maps</a></li>
                                <li><a href="../../RedThunder/QBMaps/index.html">QBMaps</a></li>
                            </ul>
                        </nav></li>
                    <li><a href="#">Cold War <span class="toggle">Expand</span><span class="caret"></span></a>
                        <nav>
                            <ul>
                                <li><a href="../../ColdWar/Scenarios/index.html">Scenarios</a></li>
                                <li><a href="../../ColdWar/Campaigns/index.html">Campaigns</a></li>
                                <li><a href="../../ColdWar/Maps/index.html">Maps</a></li>
                                <li><a href="../../ColdWar/QBMaps/index.html">QBMaps</a></li>
                            </ul>
                        </nav></li>
                    <li><a href="#">Shock Force <span class="toggle">Expand</span><span class="caret"></span></a>
                        <nav>
                            <ul>
                                <li><a href="../../ShockForce/Scenarios/index.html">Scenarios</a></li>
                                <li><a href="../../ShockForce/Campaigns/index.html">Campaigns</a></li>
                                <li><a href="../../ShockForce/Maps/index.html">Maps</a></li>
                                <li><a href="../../ShockForce/QBMaps/index.html">QBMaps</a></li>
                            </ul>
                        </nav></li>
                    <li><a href="#">Black Sea <span class="toggle">Expand</span><span class="caret"></span></a>
                        <nav>
                            <ul>
                                <li><a href="../../BlackSea/Scenarios/index.html">Scenarios</a></li>
                                <li><a href="../../BlackSea/Campaigns/index.html">Campaigns</a></li>
                                <li><a href="../../BlackSea/Maps/index.html">Maps</a></li>
                                <li><a href="../../BlackSea/QBMaps/index.html">QBMaps</a></li>
                            </ul>
                        </nav></li>
                    <li><a href="http://www.lesliesoftware.com/products/WhoseTurnIsIt/index.html">Whose Turn Is It? <span class="toggle">Expand</span><span class="caret"></span></a>
                        <nav>
                            <ul>
                                <li><a href="http://www.lesliesoftware.com/products/WhoseTurnIsIt/newandnoteworthy.html">New&#160;and&#160;Noteworthy</a></li>
                                <li><a href="http://www.lesliesoftware.com/products/WhoseTurnIsIt/download.html">Download</a></li>
                                <li><a href="http://www.lesliesoftware.com/products/WhoseTurnIsIt/gettingstarted.html">Getting Started</a></li>
                                <li><a href="http://www.lesliesoftware.com/products/WhoseTurnIsIt/roadmap.html">Road Map</a></li>
                            </ul>
                        </nav></li>
                    <li><a href="http://www.lesliesoftware.com/about.html">About</a></li>
                    <li><a href="http://www.lesliesoftware.com/contact.html">Contact</a></li>
                </ul>
            </nav>
    </xsl:template>

	<xsl:template name="formatDate">
		<xsl:param name="date" />

		<xsl:choose>
		<xsl:when test="contains($date, 'Invalid')">
			Invalid date
		</xsl:when>
		<xsl:when test="$date">	
		    <xsl:variable name="iso-date">
		        <xsl:analyze-string select="$date" regex="(\d{{1,2}})/(\d{{1,2}})/(\d{{4}})">
		            <xsl:matching-substring>
		                <xsl:value-of select="regex-group(3)"/>
		                <xsl:text>-</xsl:text>
		                <xsl:value-of select="regex-group(2)"/>
		                <xsl:text>-</xsl:text>
		                <xsl:value-of select="regex-group(1)"/>
		            </xsl:matching-substring>
		        </xsl:analyze-string>
		    </xsl:variable>
		
		    <xsl:value-of select="format-date($iso-date, '[Y0001]/[M01]/[D01]', 'en', (), ())"/>
	    </xsl:when>
	    <xsl:otherwise>
	    	Invalid date
	    </xsl:otherwise>
	    </xsl:choose>
    </xsl:template>
    
    <xsl:template name="convertExtensionToJPG">
    	<xsl:param name="url" />
    	
    	<xsl:variable name="ext">
    		<xsl:choose>
    			<xsl:when test="substring($url, string-length($url)) != '.'"><xsl:value-of select="tokenize($url, '\.')[last()]" /></xsl:when>
    			<xsl:otherwise><xsl-value-of select="''" /></xsl:otherwise>
    		</xsl:choose>
    	</xsl:variable>
    	
    	<xsl:variable name="newUrl">
    		<xsl:choose>
    			<xsl:when test="$ext='bmp' or $ext=''">
    				<!-- replace the extension with .jpg -->
    				<xsl:value-of select="concat (substring ($url, 1, string-length ($url) - string-length ($ext) - 1), '.jpg')" />
    			</xsl:when>
    			<xsl:otherwise>
    				<!-- No extension found just return the url  -->
    				<xsl:value-of select="$url" />
    			</xsl:otherwise>
    		</xsl:choose>
    	</xsl:variable>
    	
    	<xsl:value-of select="$newUrl" />
    </xsl:template>
    
    <xsl:template name="stringToSafeFileName">
        <xsl:param name="fileNameStr" />
        
        <xsl:value-of select="translate($fileNameStr, '[]{}*#%!@$()&amp;', '-')" />
    </xsl:template>

	<xsl:template name="breakLongFileNameForDisplay">
		<xsl:param name="fileNameStr"/>
		
		<xsl:choose>
		<xsl:when test="string-length($fileNameStr) &gt; 32">
			<!-- Long string - chose how to break it up -->
			<xsl:choose>
			<!-- Replace the '_' with '_ ' so the name will break at the '_' -->
			<xsl:when test="not(contains($fileNameStr, ' ')) and contains($fileNameStr, '_')"><xsl:value-of select="replace($fileNameStr, '_', '_ ')" /></xsl:when>
			<!-- Break every 32 characters -->
			<xsl:when test="not(contains($fileNameStr, ' '))">
				<xsl:call-template name="chop">
					<xsl:with-param name="text"><xsl:value-of select="$fileNameStr"/></xsl:with-param>
					<xsl:with-param name="delimiter"><xsl:value-of select="' '"/></xsl:with-param>
					<xsl:with-param name="length"><xsl:value-of select="32"/></xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<!-- Just display the string - let it break at the spaces -->
			<xsl:otherwise><xsl:value-of select="$fileNameStr" /></xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<!-- Just display the string -->
		<xsl:otherwise><xsl:value-of select="$fileNameStr" /></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="chop">
		<xsl:param name="text" select="." />
		<xsl:param name="delimiter">
			<br />
		</xsl:param>
		<xsl:param name="length" select="10" />
		<xsl:choose>
			<xsl:when test="string-length($text) > $length">
				<xsl:value-of select="substring($text, 1, $length)" />
				<xsl:copy-of select="$delimiter" />
				<xsl:call-template name="chop">
					<xsl:with-param name="text" select="substring($text, $length + 1)" />
					<xsl:with-param name="delimiter">
						<xsl:copy-of select="$delimiter" />
					</xsl:with-param>
					<xsl:with-param name="length" select="$length" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
