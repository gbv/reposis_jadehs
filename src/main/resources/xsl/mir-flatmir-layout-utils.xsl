<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
    xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
    xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
    exclude-result-prefixes="i18n mcrver mcrxsl">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />

  <xsl:template name="mir.navigation">

    <div class="container">
      <div class="project_topnav_box">
        <div class="project-social-nav">
          <ul class="navbar-nav mr-auto flex-row">
            <li>
              <a
                href="https://www.facebook.com/jadehs"
                title="Folgen Sie uns auf Facebook"
                target="_blank"
                class=""
                rel="noreferrer nofollow">
                <i class="fa-brands fa-facebook"></i>
              </a>
            </li>
            <li>
              <a
                href="https://www.instagram.com/jade_hochschule/"
                title="Folgen Sie uns auf Instagram"
                target="_blank"
                class=""
                rel="noreferrer nofollow">
                <i class="fa-brands fa-instagram"></i>
              </a>
            </li>
            <li>
              <a
                href="https://www.youtube.com/user/jadeuniversity"
                title="Folgen Sie uns auf Youtube"
                target="_blank"
                class=""
                rel="noreferrer nofollow">
                <i class="fa-brands fa-youtube"></i>
              </a>
            </li>
          </ul>
        </div>
        <div class="mir-prop-nav">
          <nav>
            <ul class="navbar-nav ml-auto flex-row">
              <xsl:call-template name="mir.loginMenu" />
              <xsl:call-template name="mir.languageMenu" />
            </ul>
          </nav>
        </div>
      </div>
      <div class="project_logo_box">
        <a title="zur Jade Hochschule" href="https://www.jade-hs.de/">
          <img
            src="{$WebApplicationBaseURL}images/Logo_JadeHochschule.jpg"
            alt="Logo Jade Hochschule" />
        </a>
      </div>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="mir-main-nav bg-secondary">
      <div class="container">
        <nav class="navbar navbar-expand-lg navbar-dark bg-secondary">

          <button
            class="navbar-toggler"
            type="button"
            data-toggle="collapse"
            data-target="#mir-main-nav-collapse-box"
            aria-controls="mir-main-nav-collapse-box"
            aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div class="collapse navbar-collapse mir-main-nav__entries">
            <ul class="navbar-nav">
              <xsl:call-template name="project.generate_single_menu_entry">
                <xsl:with-param name="menuID" select="'brand'"/>
              </xsl:call-template>
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='browse']" />
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
              <xsl:call-template name="mir.basketMenu" />
            </ul>
          </div>

        </nav>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- show only on startpage -->
    <xsl:if test="//div/@class='jumbotwo'">
    </xsl:if>
  </xsl:template>

  <xsl:template name="mir.footer">
    <div class="container">
      <div class="row">
        <div class="col-3">
          <h4>Kontakt</h4>
          <p>
            Jade Hochschule<br/>
            Wilhelmshaven/Oldenburg/Elsfleth<br/>
            Friedrich-Paffrath-Straße 101<br/>
            26389 Wilhelmshaven<br/>
            <br/>
            Tel. +49 4421 985-0<br/>
            Fax +49 4421 985-2304
          </p>
        </div>
        <div class="col-3">
          <h4>Links</h4>
          <ul class="internal_links">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='below']/*" />
          </ul>
        </div>
        <div class="col-6">
        </div>
      </div>
      <div class="row">
        <div class="col-12">
          <div class="project-copyright">
            ©2024 Jade Hochschule Wilhelmshaven | Oldenburg | Elsfleth
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.powered_by">
    <xsl:variable name="mcr_version" select="concat('MyCoRe ',mcrver:getCompleteVersion())" />
    <div id="powered_by">
      <a href="http://www.mycore.de">
        <img src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_small_invert.png" title="{$mcr_version}" alt="powered by MyCoRe" />
      </a>
    </div>
  </xsl:template>

  <xsl:template name="project.generate_single_menu_entry">
    <xsl:param name="menuID" />

    <xsl:variable name="activeClass">
      <xsl:choose>
        <xsl:when test="$loaded_navigation_xml/menu[@id=$menuID]/item[@href = $browserAddress ]">
        <xsl:text>active</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>not-active</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <li class="nav-item {$activeClass}">

      <a id="{$menuID}" href="{$WebApplicationBaseURL}{$loaded_navigation_xml/menu[@id=$menuID]/item/@href}" class="nav-link" >
        <xsl:choose>
          <xsl:when test="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($CurrentLang)] != ''">
            <xsl:value-of select="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($CurrentLang)]" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($DefaultLang)]" />
          </xsl:otherwise>
        </xsl:choose>
      </a>
    </li>
  </xsl:template>

</xsl:stylesheet>
