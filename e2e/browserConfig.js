const chrome = {
    'browserName': 'chrome',
    'chromeOptions': {
        'args': [
            'disable-infobars',
        ]
    }
};
 
const firefox = {
    'browserName': 'firefox',
    'marionette': true,
    'firefoxPath': 'C:\\Program Files\\Mozilla Firefox\\firefox.exe'
};
 
module.exports = { chrome, firefox }
