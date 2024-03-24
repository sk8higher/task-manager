const { environment } = require('@rails/webpacker')

module.exports = environment
const erb = require('./loaders/erb')
environment.loaders.append('erb', erb)
