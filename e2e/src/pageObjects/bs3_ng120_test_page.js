var bs3_120_test_page = function () {
    this.get = async function () {
        await browser.get('http://localhost:3000/bs3_ng120_test_page.html');
    };
};
module.exports = new bs3_120_test_page();