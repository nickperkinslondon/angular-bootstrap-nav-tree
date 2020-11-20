var TestsPage = function () {
    this.get = async function () {
        await browser.waitForAngularEnabled(false);
        await browser.get('http://localhost:3000/tests_page.html');
    };
};
module.exports = new TestsPage();