var ExtractTextPlugin = require("extract-text-webpack-plugin");
var CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = {
  entry: {
    home: ["./web/static/css/home/mixdown.scss", "./web/static/js/home/mixdown.js"],
    admin: ["./web/static/css/app.scss", "./web/static/js/app.js"]
  },

  output: {
    path: "./priv/static",
    filename: "js/[name].js"
  },

  resolve: {
    modulesDirectories: [ "node_modules", __dirname + "/web/static/js" ]
  },

  devtool: "source-map",

  module: {
    loaders: [{
      test: /\.vue$/,
      loader: 'vue'
    }, {
      test: /\.json$/,
      loader: 'json'
    },{
      test: /\.js$/,
      exclude: /node_modules/,
      loader: "babel!eslint"
    }, {
      test: /\.scss$/,
      loader: ExtractTextPlugin.extract(
        "style",
        "css!sass?sourceMap"
      )
    }]
  },

  vue: {
    loaders: {
      js: 'babel!eslint'
    }
  },

  plugins: [
    new CopyWebpackPlugin([{ from: "./web/static/assets" }]),
    new ExtractTextPlugin("css/[name].css")
  ]
};