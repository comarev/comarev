//= require jquery
//= require swagger-ui-dist/swagger-ui-bundle
//= require swagger-ui-dist/swagger-ui-standalone-preset

$(function () {
  let $swagger_ui_element = $("#swagger-ui");
  const ui = SwaggerUIBundle({
    url: $swagger_ui_element.data("url"),
    dom_id: "#swagger-ui",
    presets: [SwaggerUIBundle.presets.apis, SwaggerUIStandalonePreset],
    plugins: [SwaggerUIBundle.plugins.DownloadUrl],
    layout: "StandaloneLayout",
  });

  window.ui = ui;
});
