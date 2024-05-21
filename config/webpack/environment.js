const { environment } = require("@rails/webpacker");
const webpack = require("webpack");
const path = require("path")

environment.plugins.prepend("Provide",
  new webpack.ProvidePlugin({
    $: "jquery/src/jquery",
    jQuery: "jquery/src/jquery"
  }));

environment.loaders.append("students", {
  test: /\.js$/,
  include: [path.resolve(__dirname, "app/javascript/packs/students")],
});

environment.loaders.append("students", {
  test: /\.js$/,
  include: [path.resolve(__dirname, "app/javascript/packs/attendances")],
});

module.exports = environments;
