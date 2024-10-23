import 'package:flutter/material.dart';
import 'dart:io';

class pageCeasar extends StatefulWidget {
  const pageCeasar({super.key});

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<pageCeasar> {
  final TextEditingController _controller = TextEditingController();
  String _output = '';

  void _runCode() async {
    String code = _controller.text;
    String RealAnswer = "The quick brown fox jumps over the lazy dog";

    File tempFile = File('temp_code.py');
    await tempFile.writeAsString(code);

    try {
      ProcessResult result = await Process.run(
        'python',
        [tempFile.path],
      );

      setState(() {
        _output = result.stdout.trim();
        if (_output == RealAnswer) {
          _output = "Pass";
        } else {
          _output = "Failed";
        }
      });
    } catch (e) {
      setState(() {
        _output = 'Error: $e';
      });
    } finally {
      await tempFile.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ceasar'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '凯撒加密',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '凯撒加密是一种最古老、最简单的加密方法，通过将字母表中的每个字母按固定位移加密。',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '例如：假设位移量为3，加密"HELLO"得到"KHOOR"。',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '尝试还原如下句子:\nWkh txlfn eurzq ira mxpsv ryhu wkh odcb grj\n并输出',
                      style: TextStyle(fontSize: 16, color: Colors.black),
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
                            child: const Text('提交'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              iconColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
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
    home: pageCeasar(),
  ));
}
