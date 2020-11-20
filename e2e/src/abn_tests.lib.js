const { element } = require('protractor');
var page = require('./pageObjects/test_page_base');

var AbnTests = function () {
    this.runSharedTests = function () {
        it('should change tree data after clicking change the tree definition', async function () {
            await page.btnChangeTreeDefinition.click();
            expect(await page.lblFirstBranch.getText()).toEqual("North America");
        });

        //TODO: This test needs revising as the page state is inconsistent
        /* it('should successfully load data after clicking load tree data asynchronously', async function () {
            await page.btnLoadTeeDataAsync.click();
            expect(await page.lblFirstBranch.getText()).toEqual("North America");
        }); */

        it('should make first branch active after clicking first branch button', async function () {
            await page.btnFirstBranch.click();
            expect(await page.lblActiveBranch.getText()).toEqual("Animal");
        });

        it('should make next sibling active after clicking next sibling button', async function () {
            await page.btnNextSibling.click();
            expect(await page.lblActiveBranch.getText()).toEqual("Red Delicous");
        });

        it('should make previous sibling active after clicking previous sibling button', async function () {
            await page.btnNextSibling.click();
            await page.btnNextSibling.click();
            await page.btnPreviousSibling.click();
            expect(await page.lblActiveBranch.getText()).toEqual("Red Delicous");
        });

        it('should make next branch active after clicking next branch button', async function () {
            await page.btnNextBranch.click();
            await page.btnNextBranch.click();
            await page.btnNextBranch.click();
            expect(await page.lblActiveBranch.getText()).toEqual("Mineral");
        });

        it('should make previous branch active after clicking previous branch button', async function () {
            await page.btnPreviousBranch.click();
            await page.btnPreviousBranch.click();
            expect(await page.lblActiveBranch.getText()).toEqual("Oranges");
        });

        it('should make parent active after clicking parent button', async function () {
            await page.btnParent.click();
            await page.btnParent.click();
            expect(await page.lblActiveBranch.getText()).toEqual("Vegetable");
        });

        it('should collapse active branch after clicking collapse button', async function () {
            await page.btnParent.click();
            await page.btnCollapse.click();
            expect(await page.eleActiveBranch.$$("i").first().getAttribute("class")).toContain("icon-plus");
        });

        it('should expand active branch after clicking expand button', async function () {
            await page.btnNextBranch.click();
            await page.btnNextBranch.click();
            await page.btnNextBranch.click();
            await page.btnNextBranch.click();
            await page.btnExpand.click();
            expect(await page.eleActiveBranch.$$("i").first().getAttribute("class")).toContain("icon-minus");
        });

        it('should not contain any expanded branches after clicking collapse all button', async function () {
            await page.btnParent.click();
            await page.btnCollapseAll.click();
            expect(await $$('.abn-tree i.icon-minus').count()).toEqual(0);
        });

        it('should not contain any collapsed branches after clicking expand all button', async function () {
            await page.btnParent.click();
            await page.btnExpandAll.click();
            expect(await $$('.abn-tree i.icon-plus').count()).toEqual(0);
        });
    };
};
module.exports = new AbnTests();