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
              title: const Text('RSA'),
              children: <Widget>[
                ListTile(
                  title: const Text('RSA基础'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('直接分解'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewPage(),
                        ));
                  },
                ),
                ListTile(
                  title: const Text('共享素数'),
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
      body: const Align(
        alignment: Alignment.topLeft,  // 将文本对齐到左上角
        child: Padding(
          padding: EdgeInsets.all(16.0),  // 添加16像素的内边距，避免紧贴边缘
          child: Text(
            '主页面内容',  // 大标题
            style: TextStyle(
              fontSize: 32,       // 字体大小
              fontWeight: FontWeight.bold,  // 粗体
              color: Colors.black, // 黑色文字
            ),
          ),
        ),
      ),
    );
  }
}
