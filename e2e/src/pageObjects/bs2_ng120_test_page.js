var bs2_120_test_page = function () {
    this.get = async function () {
        await browser.get('http://localhost:3000/bs2_ng120_test_page.html');
    };
};
module.exports = new bs2_120_test_page();