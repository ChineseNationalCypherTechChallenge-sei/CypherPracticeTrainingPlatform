import 'package:flutter/material.dart';
import 'dart:io';

class pageRc4 extends StatefulWidget {
  const pageRc4({super.key});

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<pageRc4> {
  final TextEditingController _controller = TextEditingController();
  String _output = '';

  void _runCode() async {
    String code = _controller.text;
    String RealAnswer = "HELLO";

    File tempFile = File('temp_code.py');
    await tempFile.writeAsString(code);

    try {
      ProcessResult result = await Process.run(
        'python',
        [tempFile.path],
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Rc4算法',
                      style: TextStyle(
                        fontSize: 32, 
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    const Text(
                'RC4 是一种流加密算法，广泛应用于各种加密协议。其主要加密过程如下：',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '初始化 S-box：\n'
                '  生成一个长度为 256 的 S-box，其中每个元素的值为 0 到 255。即 S[i] = i。\n'
                '  使用密钥对 S-box 进行初步打乱。通过遍历 S-box，将其与密钥的各个字节进行混合。',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '生成密钥流：\n'
                '  继续通过对 S-box 的打乱生成伪随机字节流。\n'
                '  在每一步中，生成一个新的字节，作为伪随机密钥流中的一个字节。',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '加密过程：\n'
                '  将生成的密钥流字节与明文中的每一个字节进行异或，得到加密后的密文。',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                '还原并输出Rc4加密的如下字符串：',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                '密文: [45, 139, 35, 110, 21]\n'
                '密钥: [101, 202, 111, 34, 90]\n',
                style: TextStyle(fontSize: 16),
              ),
                    SizedBox(height: 10),
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
    home: pageRc4(),
  ));
}
