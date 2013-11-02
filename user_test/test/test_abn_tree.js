var app;

app = angular.module('AbnTest', ['angularBootstrapNavTree']);

app.controller('AbnTestController', function($scope) {
  var apple_selected;
//  scope.change= function(){
  $scope.example_treedata =[{
    label: 'Animal',
    children: ['lion','chiken','ship']
  }];
  //}
  $scope.my_default_handler = function(branch) {
    var _ref;
    $scope.output = "You selected: " + branch.label;
    if ((_ref = branch.data) != null ? _ref.description : void 0) {
      return $scope.output += '(' + branch.data.description + ')';
    }
  };
  apple_selected = function(branch) {
    return $scope.output = "APPLE! : " + branch.label;
  };
  $scope.change = function(){
   $scope.example_treedata = [{
    label: 'Languages',
    children: ['Jade','Less','Coffeescript']
  }];
}
});

