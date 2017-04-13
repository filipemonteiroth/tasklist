angular.module('taskListApp').service('TasksService', ['$http', function($http) {

  var tasksService = {};

  tasksService.load = function() {
    return $http({method: 'get', url: '/tasks.json'});
  };

  tasksService.create = function(task) {
    return $http({method: 'post', url: '/tasks.json', data: task});
  };

  tasksService.update = function(task) {
    return $http({method: 'put', url: '/tasks/' + task.id + '.json', data: task});
  };

  tasksService.assignToMe = function(task) {
    return $http({method: 'put', url: '/tasks/' + task.id + '/assign_to_me.json'});
  };

  tasksService.complete = function(task) {
    return $http({method: 'put', url: '/tasks/' + task.id + '/complete.json'});
  };

  tasksService.delete = function(task) {
    return $http({method: 'delete', url: '/tasks/' + task.id + '.json'});
  };

  return tasksService;

}]);