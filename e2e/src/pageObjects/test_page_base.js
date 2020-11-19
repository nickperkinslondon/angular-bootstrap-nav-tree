var Page = require('astrolabe').Page;
 
module.exports = Page.create({
    eleAbnTree: {
        get: function () { return $('.abn-tree'); }
    },
 
    eleActiveBranch: {
        get: function () { return $('.abn-tree li.active'); }
    },
 
    lblFirstBranch: {
        get: function () { return $$('.abn-tree li > a > span').first(); }
    },
 
    lblActiveBranch: {
        get: function () { return $('.abn-tree li.active > a > span'); }
    },

    btnChangeTreeDefinition: {
        get: function () { return $('#btn_change_tree_definition'); }
    },

    btnLoadTeeDataAsync: {
        get: function () { return $('#btn_load_tree_async'); }
    },

    btnFirstBranch: {
        get: function () { return $('#btn_first_branch'); }
    },

    btnNextSibling: {
        get: function () { return $('#btn_next_sibling'); }
    },

    btnPreviousSibling: {
        get: function () { return $('#btn_prev_sibling'); }
    },

    btnNextBranch: {
        get: function () { return $('#btn_next_branch'); }
    },

    btnPreviousBranch: {
        get: function () { return $('#btn_prev_branch'); }
    },

    btnParent: {
        get: function () { return $('#btn_parent'); }
    },

    btnExpand: {
        get: function () { return $('#btn_expand'); }
    },

    btnCollapse: {
        get: function () { return $('#btn_collapse'); }
    },

    btnExpandAll: {
        get: function () { return $('#btn_expand_all'); }
    },

    btnCollapseAll: {
        get: function () { return $('#btn_collapse_all'); }
    },

    btnAddBranch: {
        get: function () { return $('#btn_add_branch'); }
    },

    lblOutput: {
        get: function () { return $('#lbl_output'); }
    }
});