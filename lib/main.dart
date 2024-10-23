import 'package:cypherpracticetrainingplatform/pages/newPage.dart';
import 'package:cypherpracticetrainingplatform/pages/pageRc4.dart';
import 'package:cypherpracticetrainingplatform/pages/pageCeasar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CypherPracticeTrainingPlatform());
}

class CypherPracticeTrainingPlatform extends StatelessWidget {
  const CypherPracticeTrainingPlatform({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '密码技术实训平台(demo)',
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
        title: const Text('密码技术实训平台(demo)'),
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
                Navigator.pop(context);
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.settings),
              title: const Text('一览'),
              children: <Widget>[
                ListTile(
                  title: const Text('凯撒加密'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const pageCeasar(),
                        ));
                  },
                ),
                ListTile(
                  title: const Text('RSA'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewPage(),
                        ));
                  },
                ),
                ListTile(
                  title: const Text('rc4'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const pageRc4(),
                        ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: const Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '主页',
                style: TextStyle(
                  fontSize: 32, // 字体大小
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              SizedBox(height: 20),
              Text(
                '这是密码技术实训平台的演示版本，主要是基于flutter编写的桌面/Android应用\n我们主要以OJ的形式呈现该平台，并以各种密码的攻击方案作为示例', // 需要添加的文本
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
