var testsPage = require('./pageObjects/tests_page');

describe('abn-tree tests', function () {
    beforeEach(async function(){
        await testsPage.get();
    });
    
    it('should have a title', async function () {
        expect(browser.getTitle()).toEqual('abn-tree tests');
    });
});