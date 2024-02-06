import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:getx_flutter/app/models/github_user_model.dart';
import 'package:getx_flutter/app/repositories/github_repository.dart';

class HomeController extends GetxController {
  final GithubRepository repository;

  final List<GithubUserModel> _users = <GithubUserModel>[].obs;
  List<GithubUserModel> get users => _users;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  HomeController({required this.repository});

  getGitHubUsers() async {
    _isLoading.value = true;
    final response = await repository.getGitHubUsers();
    _users.addAll(response);
    _isLoading.value = false;
  }
}
