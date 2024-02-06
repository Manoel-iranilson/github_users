import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_flutter/app/pages/home/home_controller.dart';
import 'package:getx_flutter/app/repositories/github_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = HomeController(
      repository: GithubRepository(
        dio: Dio(),
      ),
    );

    _controller.getGitHubUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GitHub users")),
      body: Obx(() {
        return _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : _controller.users.isEmpty
                ? const Center(
                    child: Text("Nenhum usuario encontrado"),
                  )
                : ListView.builder(
                    itemCount: _controller.users.length,
                    itemBuilder: (context, index) {
                      final item = _controller.users[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(item.avatarUrl),
                        ),
                        title: Text(item.login, style: TextStyle(fontSize: 30)),
                      );
                    },
                  );
      }),
    );
  }
}
