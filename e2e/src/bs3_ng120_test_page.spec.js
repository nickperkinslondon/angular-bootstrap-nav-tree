var bs3_ng120_testPage = require('./pageObjects/bs3_ng120_test_page');
var abn_tests = require('./abn_tests.lib');

describe('bs3_ng120_test_page.html', function () {
    beforeEach(async function(){
        await bs3_ng120_testPage.go();
    });

    it('should use angularJS 1.2.12', function () {
        expect(browser.executeScript('return window.angular.version.full;')).toEqual('1.2.12');
    });

    it('should use bootstrap 3', async function () {
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

    abn_tests.runSharedTests();
});
