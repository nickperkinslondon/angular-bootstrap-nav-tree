var bs3_115_test_page = function () {
    this.get = async function () {
        await browser.get('http://localhost:3000/bs3_ng115_test_page.html');
    };
};
module.exports = new bs3_115_test_page();