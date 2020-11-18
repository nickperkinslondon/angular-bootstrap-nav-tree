var bs3_ng120_test_page = require('./pageObjects/bs3_ng120_test_page');

describe('bs3_ng120_test_page.html', function () {
    it('should use angularJS 1.2.12', async function () {
        await bs3_ng120_test_page.get();

        expect(browser.executeScript('return window.angular.version.full;')).toEqual('1.2.12');
    });

    it('should use bootstrap 3', async function () {
        await bs3_ng120_test_page.get();
        var bs3Regex = /bootstrap\/3\.\d\.\d\/.*bootstrap.*\.css/g;
        let hasBoostrap3 = false;
        await $$('head link[rel="stylesheet"]').each(async (e)=>{
            const cssUrl = await e.getAttribute('href');
            if(bs3Regex.test(cssUrl)){
                hasBoostrap3 = true;
            }
        });
        expect(hasBoostrap3).toEqual(true);
    });
});