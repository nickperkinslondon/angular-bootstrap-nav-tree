var bs2_ng120_testPage = require('./pageObjects/bs2_ng120_test_page');
var abn_tests = require('./abn_tests.lib');

describe('bs2_ng120_test_page.html', function () {
    beforeEach(async function(){
        await bs2_ng120_testPage.go();
    });

    it('should use angularJS 1.2.12', function () {
        expect(browser.executeScript('return window.angular.version.full;')).toEqual('1.2.12');
    });

    it('should use bootstrap 2', async function () {
        var bs2Regex = /bootstrap\/2\.\d\.\d\/.*bootstrap.*\.css/g;
        let hasBoostrap2 = false;
        await $$('head link[rel="stylesheet"]').each(async (e)=>{
            const cssUrl = await e.getAttribute('href');
            if(bs2Regex.test(cssUrl)){
                hasBoostrap2 = true;
            }
        });
        expect(hasBoostrap2).toEqual(true);
    });

    abn_tests.runSharedTests();
});
