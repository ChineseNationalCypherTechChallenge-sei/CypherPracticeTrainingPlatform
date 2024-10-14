import 'package:flutter/material.dart';
import 'dart:io'; // 导入 dart:io 库以使用 Process

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final TextEditingController _controller = TextEditingController();
  String _output = ''; // 存储输出结果

  // 执行用户输入的 Python 代码
  void _runCode() async {
    String code = _controller.text;
    String RealAnswer = "22748";

    // 创建一个临时文件来保存代码
    File tempFile = File('temp_code.py'); // 使用 .py 扩展名
    await tempFile.writeAsString(code); // 写入用户输入的代码

    try {
      // 使用 Process.run 来运行 Python 代码
      ProcessResult result = await Process.run(
        'python', // 确保您已安装 Python 并且该命令在 PATH 中
        [tempFile.path], // 传入代码文件路径
      );

      setState(() {
        _output = result.stdout.trim();
        if(_output == RealAnswer){
          _output = "Pass";
        } else {
          _output = "Failed";
        }
      });
    } catch (e) {
      setState(() {
        _output = 'Error: $e'; // 处理错误
      });
    } finally {
      await tempFile.delete(); // 执行完后删除临时文件
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新页面'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'N =	1867596509:',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('返回'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        iconColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 300,
              padding: const EdgeInsets.all(10),
              color: Colors.grey[850],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '代码输入框:',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '直接输入 Python 代码...',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                              ),
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _runCode,
                            child: const Text('提交'), // 添加 child 参数
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              iconColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // 显示输出结果
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                _output,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NewPage(),
  ));
}
