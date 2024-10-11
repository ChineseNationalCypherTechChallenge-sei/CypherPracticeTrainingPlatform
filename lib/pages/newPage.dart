import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart'; // 选择一种主题

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final TextEditingController _controller = TextEditingController();
  double _splitterWidth = 300; // 分割线初始宽度

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新页面'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    '输入内容:',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('返回'),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(width: 1, color: Colors.grey),
          Container(
            width: _splitterWidth,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        '代码输入框:',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              HighlightView(
                                _controller.text, // 输入的代码
                                language: 'dart', // 语言类型
                                theme: githubTheme, // 选择的主题
                                padding: const EdgeInsets.all(10),
                                textStyle: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: _controller,
                                maxLines: null,
                                onChanged: (value) {
                                  setState(() {
                                    // 更新高亮显示的内容
                                  });
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: '直接输入代码...',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                ),
                                style: const TextStyle(fontFamily: 'monospace'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _splitterWidth += details.delta.dx; // 更新分割线宽度
                    });
                  },
                  child: Container(
                    width: 5,
                    color: Colors.blueGrey,
                    child: const Center(child: Text('')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
