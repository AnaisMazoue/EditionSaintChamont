<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    <!-- Attention une sortie HTML => exclusion du préfixe tei des résultats -->
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/> <!-- pour éviter les espaces non voulus -->
    
    <xsl:template match="/">
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), '.xml', '')"/>
        </xsl:variable>
        <xsl:variable name="path_accueil">
            <xsl:value-of select="concat($witfile, 'accueil', '.html')"/>
        </xsl:variable>
        <xsl:variable name="path_index_persos">
            <xsl:value-of select="concat($witfile, 'indexpersos', '.html')"/>
        </xsl:variable>
        <xsl:variable name="path_index_lieux">
            <xsl:value-of select="concat($witfile, 'indexlieux', '.html')"/>
        </xsl:variable>
        <xsl:variable name="path_transcription">
            <xsl:value-of select="concat($witfile, 'transcription', '.html')"/>
        </xsl:variable>
        <xsl:variable name="path_texte_corrigé">
            <xsl:value-of select="concat($witfile, 'versioncorrigee', '.html')"/>
        </xsl:variable>
        <xsl:variable name="path_a_propos">
            <xsl:value-of select="concat($witfile, 'apropos', '.html')"/>
        </xsl:variable>
        
        
        <xsl:variable name="title">
            <i>
                <xsl:value-of select="//titleStmt/title/text()"/>
            </i>
        </xsl:variable>
        
        <xsl:variable name="author">
            <xsl:value-of select="concat(TEI/teiHeader/fileDesc/editionStmt/respStmt/persName/forename, TEI/teiHeader/fileDesc/editionStmt/respStmt/persName/surname)"/>
        </xsl:variable>
        
        <xsl:variable name="idPerson">
            <xsl:value-of select="./@xml:id"/>
        </xsl:variable>
        

        <!-- Définition des métadonnées -->
        <xsl:variable name="head">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <meta name="description" content="Édition numérique du{$title}"/>
                <meta name="keywords" content="XML, TEI, XSLT"/>
                <meta name="author" content="{$author}"/>
                <link
                    href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
                    rel="stylesheet"
                    integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
                    crossorigin="anonymous"/>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"/>
            </head>
        </xsl:variable>
        
        <!-- Mise en place de la barre de navigation avec création de liens dans celle-ci. Ces liens correspondent aux chemins de fichier des différents output HTML. -->
        <xsl:variable name="nav_bar">
            <nav class="navbar navbar-expand-md navbar-dark bg-dark justify-content: center;">
                <a class="navbar-brand" style="padding-left: 20px" href="{$path_accueil}">Accueil</a>
                <ul class="navbar-nav mr-auto">
                   <li class="nav-item">
                        <a class="nav-link" href="{$path_accueil}">Page d'accueil </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_index_persos}">Index des personnages</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_index_lieux}">Index des lieux</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_transcription}">Transcription</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_a_propos}">À propos</a>
                    </li>
                </ul>
            </nav>
        </xsl:variable>
        
        <!-- Ajout des métadonnées présentes dans le teiHeader sur la page d'accueil. -->
        <xsl:result-document href="{$path_accueil}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div>
                        <h1 class="container col-sm-10 text-center p-3">Projet
                            d'édition numérique de la <i><xsl:value-of select="$title"/>.</i></h1>
                        <p style="text-align: center">
                            <xsl:value-of select="//edition"/>
                        </p>
                        <p class="container col-5 text-justify">
                            <h2 class="m-4 text-center">Présentation du manuscrit</h2>
                            <ul class="m-2 text-justify">
                                <li class="m-2 text-justify"><b>Titre</b> : <i><xsl:value-of select="$title"/>.</i></li>
                                <li class="m-2 text-justify"><b>Résumé</b> : <xsl:value-of select="//summary"/></li>
                                <li class="m-2 text-justify"><b>Lieu de conservation</b> :
                                    <xsl:value-of select="concat(//settlement, ', ', //institution, ', ', //repository)"/>.</li>
                                <li class="m-2 text-justify"><b>Analyse codicologique</b> :
                                    <xsl:value-of select="concat(//supportDesc, '. ', //layoutDesc, ', ',//bindingDesc)"/></li>
                                <li class="m-2 text-justify"><b>Analyse paléographique </b>:
                                    <xsl:value-of select="concat(//handDesc, ' ', //scriptDesc)"/></li>
                                <li class="m-2 text-justify"><b>Édition </b>:
                                    <xsl:value-of select="concat(//editionStmt/respStmt/resp, ' réalisés par ',//editionStmt/respStmt/persName/forename, ' ', //editionStmt/respStmt/persName/surname, '.')"/></li>
                            </ul>
                        </p>
                    </div>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Création d'une page Index des personnages à partir des informations contenues dans le partiDesc du teiHeader. -->
        <xsl:result-document href="{$path_index_persos}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div>
                        <h1 class="text-center">Index des personnagess</h1>
                        <ol style="text-justify; padding-left: 110px;">
                            <xsl:for-each select=".//listPerson/person">
                                <xsl:sort select="person" order="ascending"/>
                                <li>
                                    <xsl:choose>
                                        <xsl:when test="contains(@role, 'pape')">
                                            <span class="font-weight-bold" style="color: #c63939">
                                                <xsl:apply-templates select="descendant::note"/>
                                            </span>
                                        </xsl:when>
                                        <xsl:when test="contains(@role, 'roi')">
                                            <span class="font-weight-bold" style="color: #3939c6">
                                                <xsl:apply-templates select="descendant::note"/>
                                            </span>
                                        </xsl:when>
                                        <xsl:when test="contains(@role, 'empereur')">
                                            <span class="font-weight-bold" style="color: #d19961">
                                                <xsl:apply-templates select="descendant::note"/>
                                            </span>
                                        </xsl:when>
                                        <xsl:when test="contains(@role, 'cardinal')">
                                            <span class="font-weight-bold" style="color: #d16161">
                                                <xsl:apply-templates select="descendant::note"/>
                                            </span>
                                        </xsl:when>
                                        <xsl:when test="contains(@role, 'factionfr')">
                                            <span class="font-weight-bold" style="color: #6199d1">
                                                <xsl:apply-templates select="descendant::note"/>
                                            </span>
                                        </xsl:when>
                                        <xsl:when test="contains(@role, 'factionesp')">
                                            <span class="font-weight-bold" style="color: #c6a33a">
                                                <xsl:apply-templates select="descendant::note"/>
                                            </span>
                                        </xsl:when>
                                        <xsl:when test="contains(@role, 'prefet')">
                                            <span class="font-weight-bold" style="color: #c65d3a">
                                                <xsl:apply-templates select="descendant::note"/>
                                            </span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <span class="font-weight-bold" style="color: #150a06">
                                                <xsl:apply-templates select="descendant::note"/>
                                            </span>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </li>
                            </xsl:for-each>
                            </ol>
                    </div>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Création d'une page Index des lieux à partir des informations contenues dans le settingDesc du teiHeader. -->
        <xsl:result-document href="{$path_index_lieux}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div>
                        <h1 class="text-center">Index des lieux</h1>
                        <ol style="text-justify; padding-left: 110px;">
                            <xsl:for-each select=".//listPlace/place">
                                <xsl:sort select="place" order="ascending"/>
                                <li>
                                    <xsl:value-of select="placeName"/>
                                </li>
                            </xsl:for-each>
                        </ol>
                    </div>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Création d'une page Transcription à partir des données relatives au body du text du document d'origine. -->
        <xsl:result-document href="{$path_transcription}">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container p-4">
                        <!-- Création de deux colonnes, chacune correspondant à une version du texte encodé -->
                        <div class="row">
                            <div class="col-md-6">
                                <h2>Transcription diplomatique</h2>
                                <xsl:apply-templates select="TEI//body//p" mode="original-version"/>
                            </div>
                            <div class="col-md-6">
                                <h2>Transcription modernisée</h2>
                                <xsl:apply-templates select="TEI//body//p" mode="normalised-version"/>
                            </div>
                        </div>
                    </div>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Création d'une page À propos qui explique le contexte de réalisation de ce projet -->
        <xsl:result-document href="{$path_a_propos}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <p style="text-align: center; padding: 100px;">Ce projet d'édition numérique a été établi dans le cadre de l'évaluation
                            des modules XML-TEI et XSLT du master 2 « Technologies Numériques Appliquées
                            à l'Histoire » de l'École nationale des Chartes.</p>
                    </div>
                </body>
            </html>
        </xsl:result-document>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Éléments qui ne doivent pas apparaître sur la transcription diplomatique -->
    <xsl:template match="TEI//body//expan" mode="original-version"/>
    <xsl:template match="TEI//body//reg" mode="original-version"/>
    <xsl:template match="TEI//body//corr" mode="original-version"/>
    
    <!-- Éléments qui ne doivent pas apparaître sur la transcription modernisée -->
    <xsl:template match="TEI//body//abbr" mode="normalised-version"/>
    <xsl:template match="TEI//body//orig" mode="normalised-version"/>
    <xsl:template match="TEI//body//sic" mode="normalised-version"/>
    <xsl:template match="TEI//body//del" mode="normalised-version"/>
    
    
    <!-- Templates permettant de faire des liens entre les transcriptions du texte et les index de personnages et de lieux. -->
    <xsl:template match="persName" mode="#all">
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), '.xml', '')"/>
        </xsl:variable>
        <xsl:variable name="path_pers_index">
            <xsl:value-of select="concat($witfile, 'indexpersos', '.html')"/>
        </xsl:variable>
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$path_pers_index"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
   
    <xsl:template match="placeName" mode="#all">
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), '.xml', '')"/>
        </xsl:variable>
        <xsl:variable name="path_lieux_index">
            <xsl:value-of select="concat($witfile, '_indexlieux', '.html')"/>
        </xsl:variable>
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$path_lieux_index"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- Templates permettant de respecter la mise en page de la source, en indiquant notamment les changements de page et de ligne. -->
    <xsl:template match="pb" mode="#all">
        <p style="text-align: center;">
            <xsl:value-of select="pb"/> page n° <xsl:value-of select="@n"/>  
        </p>
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="//body//p" mode="#all">
        <p>
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>
    
    <xsl:template match="lb" mode="#all">
        <br class="m-3"/>
        <i>
            <xsl:number select="." level="any" format="1"/>
        </i>
        <span class="m-3"> - </span>
    </xsl:template>
    
    
</xsl:stylesheet>