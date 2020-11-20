const browserConfig = require('./browserConfig');

exports.config = {
    framework: 'jasmine',
    directConnect: true,
    capabilities: browserConfig['firefox'],
    specs: ['**/*.spec.js'],
}