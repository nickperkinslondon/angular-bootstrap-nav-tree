var bs2_ng115_test_page = require('./pageObjects/bs2_ng115_test_page');

describe('bs2_ng115_test_page.html', function () {
    it('should use angularJS 1.1.5', async function () {
        await bs2_ng115_test_page.get();

        expect(browser.executeScript('return window.angular.version.full;')).toEqual('1.1.5');
    });

    it('should use bootstrap 2', async function () {
        await bs2_ng115_test_page.get();
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
});
