Package.describe({
  name: 'nickperkinslondon:angular-bootstrap-nav-tree',
  version: '0.2.0',
  summary: 'angular-bootstrap-nav-tree (official) for Meteor',
  git: 'https://github.com/nickperkinslondon/angular-bootstrap-nav-tree',
  documentation: null
});

Package.onUse(function (api) {
  api.versionsFrom('METEOR@0.9.0.1');

  api.use('twbs:bootstrap', 'client');
  api.use('angularjs:angular@1.3.15', 'client');

  api.addFiles('dist/abn_tree_directive.js', 'client');
  api.addFiles('dist/abn_tree.css', 'client');
});
