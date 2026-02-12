<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="index-search-form">
    <form
      action="../servlets/solr/find"
      id="project-searchMainPage"
      class="form-inline d-flex justify-content-center mt-5"
      role="search">
      <div class="input-group input-group-lg" style="text-align: center;">
        <input
          name="condQuery"
          placeholder="{document('i18n:project.index.search.placeholder.default')/i18n/text()}"
          class="form-control search-query"
          id="project-searchInput"
          type="text" />
        <div class="input-group-append" style="text-align: center;">
          <button type="submit" class="btn btn-primary">
            <i class="fa fa-search" aria-hidden="true" />
          </button>
        </div>
      </div>
    </form>
  </xsl:template>
</xsl:stylesheet>
