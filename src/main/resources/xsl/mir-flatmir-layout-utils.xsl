<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="date">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />

  <xsl:variable name="checkAdmin" select="document('userobjectrights:isCurrentUserInRole:admin')/boolean='true'"/>
  <xsl:variable name="checkEditor" select="document('userobjectrights:isCurrentUserInRole:editor')/boolean='true'"/>

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
              <xsl:call-template name="mir.searchbar" />
              <xsl:call-template name="mir.loginMenu" />
              <xsl:call-template name="mir.languageMenu" />
            </ul>
          </nav>
        </div>
      </div>
      <div class="project_logo_box">
        <a title="zur Jade Hochschule" href="https://www.jade-hs.de/">
          <img src="{$WebApplicationBaseURL}images/Logo_JadeHochschule.jpg" alt="Logo Jade Hochschule" />
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
                <xsl:with-param name="menuID" select="'brand'" />
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
    <div id="project_feedback">
      <a href="mailto:info@example.de">Schreiben Sie uns</a>
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- show only on startpage -->
    <xsl:if test="//div/@class='jumbotwo'"></xsl:if>
  </xsl:template>

  <xsl:template name="mir.footer">
    <div class="container">
      <div class="row">
        <div class="col-7 mt-3">
          <div class="row">
            <div class="col-6">
              <h4 class="sr-only">Kontakt</h4>
              <p>
                Jade Hochschule
                <br />
                Wilhelmshaven/Oldenburg/Elsfleth
                <br />
                Friedrich-Paffrath-Straße 101
                <br />
                26389 Wilhelmshaven<br/>
                <br />
                Tel. <span class="text-primary">+49 4421 985-0</span>
                <br />
                Fax <span class="text-primary"> +49 4421 985-2304</span>
              </p>
            </div>
            <div class="col-6">
              <h4 class="sr-only">Links</h4>
              <ul class="internal_links">
                <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='below']/*" />
              </ul>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="project-copyright">
                <xsl:value-of select="concat('©', date:year(date:date()))" />
                Jade Hochschule Wilhelmshaven | Oldenburg | Elsfleth
              </div>
            </div>
          </div>
        </div>
        <div class="col-5 logo-column">
          <a
            href="{$WebApplicationBaseURL}"
            title="Zur Startseite">
            <img
              src="{$WebApplicationBaseURL}images/Logo_Dokumentenserver_JadeHochschule.svg"
              alt="" />
          </a>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.powered_by">
    <xsl:variable name="mcr_version" select="document('version:full')/version/text()" />
    <div id="powered_by">
      <a href="https://www.mycore.de">
        <img
          src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_small_invert.png"
          title="{$mcr_version}"
          alt="powered by MyCoRe" />
      </a>
    </div>
  </xsl:template>

  <xsl:template name="mir.searchbar">
    <li class="searchfield-entry">
      <div class="searchfield_box">
        <form id="bs-searchHeader"
          action="{$WebApplicationBaseURL}servlets/solr/find"
          class="bs-search form-inline"
          role="search">
          <div class="js-searchbar">
            <button type="submit" class="btn pnt-primary text-white">
              <i class="fas fa-search search-button__icon"></i>
            </button>
            <input
              id="searchbar"
              name="condQuery"
              placeholder="{document('i18n:mir.navsearch.placeholder')/i18n/text()}"
              class="form-control form-control-sm search-query"
              type="text" />
            <xsl:choose>
              <xsl:when test="$checkAdmin or $checkEditor">
                <input name="owner" type="hidden" value="createdby:*" />
              </xsl:when>
              <xsl:when test="not($CurrentUser='guest')">
                <input name="owner" type="hidden" value="createdby:{$CurrentUser}" />
              </xsl:when>
            </xsl:choose>
          </div>
        </form>
      </div>
    </li>
  </xsl:template>

  <xsl:template name="project.generate_single_menu_entry">
    <xsl:param name="menuID" />
    <xsl:variable name="menu-item" select="$loaded_navigation_xml/menu[@id=$menuID]/item" />
    <xsl:variable name="active-class">
      <xsl:choose>
        <xsl:when test="$menu-item/@href = $browserAddress">
          <xsl:text>active</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>not-active</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <li class="nav-item {$active-class}">
      <xsl:variable name="full-url">
        <xsl:call-template name="resolve-full-url">
          <xsl:with-param name="link" select="$menu-item/@href" />
        </xsl:call-template>
      </xsl:variable>
      <a id="{$menuID}" href="{$full-url}" class="nav-link">
        <xsl:apply-templates select="$menu-item" mode="linkText" />
      </a>
    </li>
  </xsl:template>

  <xsl:template name="resolve-full-url">
    <xsl:param name="link" />
    <xsl:param name="base-url" select="$WebApplicationBaseURL" />
    <xsl:choose>
      <xsl:when test="starts-with($link,'http:')
                      or starts-with($link,'https:')
                      or starts-with($link,'mailto:')
                      or starts-with($link,'ftp:')">
        <xsl:value-of select="$link" />
      </xsl:when>
      <xsl:when test="starts-with($link,'/')">
        <xsl:choose>
          <xsl:when test="substring($base-url, string-length($base-url), 1) = '/'">
            <xsl:value-of select="concat(substring($base-url, 1, string-length($base-url) - 1), $link)" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat($base-url, $link)" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="substring($base-url, string-length($base-url), 1) = '/'">
            <xsl:value-of select="concat($base-url, $link)" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat($base-url, '/', $link)" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
