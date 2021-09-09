<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>

	<xsl:template match="/">
	
	    <html>
		    <head>
			    <link href="codifica.css" rel="stylesheet" type="text/css"/>
				<title>Appunti di Ferdinand de Saussure</title>
			</head>
			
			<body>
			    <header>
				    <h1><xsl:value-of select="//tei:fileDesc/tei:titleStmt/tei:title" /></h1>
					<h2><xsl:value-of select="//tei:sourceDesc/tei:bibl/tei:title"/></h2>
					<h2>di <xsl:value-of select="//tei:fileDesc/tei:titleStmt/tei:author" /></h2>
				</header>
				
				<nav>
                  <li><a href="#descrizione">Descrizione</a></li>
                  <li><a href="#p21">Pagina 21</a></li>
                  <li><a href="#p22">Pagina 22</a></li>
                  <li><a href="#note">Note</a></li>
				  <li><a href="#voc">Vocabolario</a></li>
				  <li><a href="#bibl">Bibliografia</a></li>
                </nav>
				
                <div id="contenitore">                   
                    <div id="descrizione">
                      <div id="info">
					        <h3> Informazioni </h3>
						    <p>Titolo: <xsl:value-of select="//tei:sourceDesc/tei:msDesc/tei:msContents/tei:summary"/></p>
						    <p>Autore: <xsl:value-of select="//tei:fileDesc/tei:titleStmt/tei:author"/></p>
                            <p>Lingua: <xsl:value-of select="//tei:sourceDesc/tei:msDesc/tei:msContents/tei:textLang"/></p>
							<p>Data: <xsl:value-of select="//tei:sourceDesc/tei:msDesc/tei:history/tei:origin"/></p>
							<p>Ubicazione: <xsl:value-of select="//tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:repository"/>, 
							<xsl:value-of select="//tei:settlement"/>, 
							<xsl:value-of select="//tei:country"/></p>
							<p>Identificatore: <xsl:value-of select="//tei:idno"/></p>
							<p>Traduzione: <xsl:value-of select="//tei:fileDesc/tei:titleStmt/tei:respStmt/tei:name"/></p>
                      </div>
                      <div class="fisica">
					        <h3> Descrizione fisica </h3>
							<p>Materiale: <xsl:value-of select="//tei:material"/></p>
							<p>Condizioni: <xsl:value-of select="//tei:condition"/></p>
							<p>Stile: <xsl:value-of select="//tei:typeDesc"/></p>
							<p>Mano: <xsl:value-of select="//tei:handNote"/></p>						                      
                      </div>
                    </div>
					
					<div class="cont">
					    <h2> Pagina 21 </h2>
					    <div class="contenitore_pagina" id="p21">
					    
						    <div class="immagine">
								<xsl:element name="img">
									<xsl:attribute name="src">
										<xsl:value-of select="//tei:surface[@n = '1']/tei:graphic/@url"/>
									</xsl:attribute>
								</xsl:element>
						    </div>
						    <div class="trascrizione">
                                <xsl:apply-templates select="//tei:body/tei:div[@n = '21']" />
                            </div>
					
					    </div>
					</div>
					
					<div class="cont">
					    <h2> Pagina 22 </h2>
					    <div class="contenitore_pagina" id="p22">
					    
						    <div class="immagine">
								<xsl:element name="img">
							        <xsl:attribute name="src">
						                <xsl:value-of select="//tei:surface[@n = '2']/tei:graphic/@url" />
								    </xsl:attribute>
							    </xsl:element>
						    </div>
							
						    <div class="trascrizione">
                                <xsl:apply-templates select="//tei:body/tei:div[@n = '22']" />
                            </div>
					
					    </div>
					</div>
					
					<div class="cont">
					    <h2>Note</h2>
					    <div id="note">                           
                            <xsl:apply-templates select="//tei:list[@type='notes']" />
                        </div>
					</div>
					
					<div class="cont">
					    <h2>Vocabolario</h2>
					    <div id="voc">                           
                            <xsl:apply-templates select="//tei:list[@type='terminology']" />
                        </div>
					</div>
					
					<div class="cont">
					    <h2>Bibliografia</h2>
					    <div id="bibl">                           
                            <xsl:apply-templates select="//tei:listBibl" />
                        </div>
					</div>
                </div>
				
				<footer>
                        <xsl:apply-templates select="//tei:editionStmt" />                        
                </footer>
					
			</body>
			
		</html>
	</xsl:template>
	
	<!-- TRASCRIZIONE -->
	<xsl:template match="tei:lb">
        <br /><br />
        <xsl:element name="span">
            <xsl:attribute name="id">
                <xsl:value-of select="concat('line', substring(@xml:id, 6, 1), '_', @n)" />		  
            </xsl:attribute>
            <xsl:value-of select="@n" />
		    <xsl:text>. </xsl:text>
        </xsl:element>
    </xsl:template>
	
	
	<!-- PUNTI DI RIFERIMENTO DELLE NOTE -->	
    <xsl:template match="tei:ptr">
        <xsl:element name="span">
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:value-of select="@target" />
                </xsl:attribute>
            <xsl:attribute name="class">note</xsl:attribute>
            <xsl:attribute name="id">
                <xsl:value-of select="concat('n_', substring(current()/@target, 2))" />
            </xsl:attribute>
                <xsl:value-of select="substring(current()/@target, 10)" />
            </xsl:element>
        </xsl:element>
    </xsl:template>	
      
    <!-- NOTE -->	  
    <xsl:template match="tei:list[@type='notes']">
        <xsl:element name="div">
            <xsl:attribute name="class">lista_note</xsl:attribute>
            <xsl:for-each select="current()/tei:item">

            <xsl:element name="span">
                <xsl:attribute name="class">note</xsl:attribute>
                <xsl:attribute name="id">
                    <xsl:value-of select="concat('i_', current()//@xml:id)" />
                </xsl:attribute>
                <xsl:value-of select="@n" />
            </xsl:element>

            <xsl:element name="span">
                <xsl:attribute name="id">
                    <xsl:value-of select="current()//@xml:id" />
                </xsl:attribute>
                <xsl:apply-templates select="current()/tei:note" />
            </xsl:element>

                <br /><br />
            </xsl:for-each>
      </xsl:element>
    </xsl:template>
	
	
	<!-- VOCABOLARIO-->
    <xsl:template match="tei:list[@type='terminology']">
        <div>
            <ul>
                <xsl:for-each select="tei:label">
                    <li class="termElement">
                        <xsl:attribute name="id">
						    <xsl:value-of select="tei:term/@xml:id"/>
						</xsl:attribute>
                        <p>
                            <b>
							    <xsl:value-of select="tei:term[@xml:lang='it']"/> 								
							</b>
							<span> &#8212; </span>
                            <xsl:apply-templates select="following-sibling::tei:item[1]/tei:gloss"/>
                        </p>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>
		
	<!-- BIBLIOGRAFIA-->
   <xsl:template match="tei:listBibl">
        <xsl:for-each select="current()/tei:bibl">
            <xsl:element name="li">
                <xsl:attribute name="id">
                    <xsl:value-of select="@xml:id" />
                </xsl:attribute>

                <xsl:for-each select="current()//tei:author">
                    <xsl:element name="span">
                        <xsl:for-each select="current()//tei:surname">
                            <xsl:apply-templates />
                        </xsl:for-each>
                        <xsl:text> </xsl:text>
                        <xsl:for-each select="current()//tei:forename">
                            <xsl:value-of select="concat(substring(current(), 1, 1), '. ')" />
                        </xsl:for-each>
                    </xsl:element>
                    <xsl:text>, </xsl:text>
                </xsl:for-each>

                <xsl:element name="span">
                    <xsl:element name="i">
                        <xsl:for-each select="current()//tei:title">
                        <xsl:apply-templates />
                        <xsl:text>. </xsl:text>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:element>

                <xsl:element name="span">
                    <xsl:for-each select="current()//tei:pubPlace">
                        <xsl:apply-templates />
                        <xsl:text>, </xsl:text>
                    </xsl:for-each>
                </xsl:element>

                <xsl:element name="span">
                    <xsl:apply-templates select="current()//tei:publisher" />
				    <xsl:text>, </xsl:text>
                </xsl:element>
                

                <xsl:element name="span">
                    <xsl:apply-templates select="current()//tei:date" />
                </xsl:element>

            </xsl:element>
		    <br />
        </xsl:for-each>
   </xsl:template>
   
    <xsl:template match="tei:gap">
        <span class="gap"></span>
    </xsl:template>
	
    <xsl:template match="tei:expan">
        <span class="expan"></span>
    </xsl:template>
	
    <xsl:template match="tei:del">
        <span class="del"></span>
    </xsl:template>
	
	<xsl:template match="tei:emph">
        <u><xsl:apply-templates /></u>
    </xsl:template>
	
	<xsl:template match="tei:term">
        <strong><xsl:apply-templates /></strong>
    </xsl:template>
 
    <!-- FOOTER-->
    <xsl:template match="tei:editionStmt">
        <span class="edition">
            <xsl:value-of select="current()/tei:edition" />
			<br />
        </span>
		<br />
        <xsl:for-each select="current()/tei:respStmt">
            <xsl:element name="span">
                <xsl:value-of select="current()//tei:resp" />
            </xsl:element> <br />
            <xsl:element name="span">
                <xsl:value-of select="current()//tei:name" />
            </xsl:element>
		    <br /><br />
        </xsl:for-each>
    </xsl:template>
		
</xsl:stylesheet>