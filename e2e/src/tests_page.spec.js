var testsPage = require('./pageObjects/tests_page');

describe('abn-tree tests', function () {
    it('should have a title', async function () {
        await testsPage.get();

        expect(browser.getTitle()).toEqual('abn-tree tests');
    });
});