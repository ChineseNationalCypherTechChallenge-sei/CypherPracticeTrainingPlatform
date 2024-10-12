import 'package:cypherpracticetrainingplatform/pages/newPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CypherPracticeTrainingPlatform());
}

class CypherPracticeTrainingPlatform extends StatelessWidget {
  const CypherPracticeTrainingPlatform({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('二级侧边栏示例'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                '菜单',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('主页'),
              onTap: () {
                // 跳转到主页逻辑
                Navigator.pop(context);
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.settings),
              title: const Text('改成加密类型'),
              children: <Widget>[
                ListTile(
                  title: const Text('题目名字1'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewPage(),
                        ));
                  },
                ),
                ListTile(
                  title: const Text('题目名字1'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('关于'),
              onTap: () {
                // 跳转到关于页面
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('主页面内容'),
      ),
    );
  }
}
