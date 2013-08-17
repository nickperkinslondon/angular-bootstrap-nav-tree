
angular-bootstrap-nav-tree
==========================

<abn-tree>
----------


This is a Tree directive for Angular JS apps that use Bootstrap CSS.  The tree style will match everything else because the tree is actually just a Bootstrap "nav" list, with a few changes.

Indentation is added to make the list look like a tree, icons are used for the "plus" and "minus" controls to expand and collapse, and Angular CSS animations are used for expand/collapse.

The normal Glyphicons work well, but you can also include the Font Awesome icons, which also work.

There are default icons for the expand/collapse, but you can also override them using html attributes.



See the test section for an example of how to use the tree.

This tree is developed in CoffeeScript, Jade, and Less.
To use it, you must be using AngularJS and Bootstrap.

How to use it:
Just include the 3 files from "dist":

abn_tree_directive.js
abn_tree_style.css
abn_tree_template.html


Then put an <abn-tree> directive in your HTML.
( see the example in "test" )

