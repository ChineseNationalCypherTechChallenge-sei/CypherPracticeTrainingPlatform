import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'dart:io';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final TextEditingController _controller = TextEditingController();
  String _output = ''; // 存储输出结果
  String markdownSource = '';

  @override
  void initState() {
    super.initState();
    loadMarkdownFile();
  }

  // 加载 Markdown 文件
  Future<void> loadMarkdownFile() async {
    final String data = await rootBundle.loadString('assets/README.md');
    setState(() {
      markdownSource = data;
    });
  }

  void _runCode() async {
    String code = _controller.text;
    String RealAnswer = "3112";

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
        title: const Text('RSA'),
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
                      'RSA算法',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'RSA（Rivest-Shamir-Adleman）是一种非对称加密算法，广泛用于安全数据传输。它依赖于两个密钥：公钥和私钥。公钥用于加密数据，而私钥用于解密。非对称的特点在于，即使拥有公钥的人也无法解密数据，只有私钥持有者可以解密。\nRSA的安全性基于大数因数分解的数学难题，即将两个大质数的乘积分解为原始质数非常困难，因此即使攻击者获得公钥，也很难通过公钥反推出私钥',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'RSA的基本过程：\n'
                      '1. 选择两个大质数 p 和 q。\n'
                      '2. 计算它们的乘积 n = p × q，这是模数。\n'
                      '3. 选择一个加密指数 e（通常是 65537）。\n'
                      '4. 通过数学方法计算私钥 d，使得 e 和 d 互为逆。\n',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'RSA的加密和解密公式：\n'
                      '加密：C = M^e mod n （M 是消息，C 是密文）\n'
                      '解密：M = C^d mod n （C 是密文，M 是原始消息）\n',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '请将下面这个N分解，并输出其分解结果p与q的异或（p^q），以十进制数输出\nN = 10101203027',
                      style: TextStyle(fontSize: 18),
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

// 自定义 MathBuilder 来渲染数学公式
class MathBuilder extends MarkdownElementBuilder {
  @override
  Widget visitText(text, TextStyle? preferredStyle) {
    return Math.tex(text.text, textStyle: preferredStyle);
  }
}

void main() {
  runApp(const MaterialApp(
    home: NewPage(),
  ));
}
