import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0"; // Texto exibido na tela
  String _currentInput = ""; // Entrada atual do usuário
  String _previousInput = ""; // Última entrada
  String _operation = ""; // Operação em andamento

  // Função para adicionar texto ao visor
  void _appendToOutput(String text) {
    setState(() {
      if (_output == "0") {
        _output = text; // Se for 0, substitui
      } else {
        _output += text; // Caso contrário, adiciona
      }
      _currentInput += text; // Atualiza a entrada atual
    });
  }

  // Função para limpar tudo
  void _clear() {
    setState(() {
      _currentInput = "";
      _previousInput = "";
      _operation = "";
      _output = "0";
    });
  }

  // Função para definir a operação
  void _setOperation(String operation) {
    setState(() {
      if (_currentInput.isEmpty) return; // Se não há nada para calcular, não faz nada
      _previousInput = _currentInput;
      _currentInput = "";
      _operation = operation;
    });
  }

  // Função para calcular o resultado
  void _calculate() {
    double num1 = double.parse(_previousInput);
    double num2 = double.parse(_currentInput);
    double result;

    // Realiza a operação dependendo do operador
    switch (_operation) {
      case "+":
        result = num1 + num2;
        break;
      case "-":
        result = num1 - num2;
        break;
      case "*":
        result = num1 * num2;
        break;
      case "/":
        result = num1 / num2;
        break;
      default:
        result = 0;
        break;
    }

    // Exibe o resultado e reinicia as variáveis
    setState(() {
      _output = result.toString();
      _currentInput = result.toString();
      _previousInput = "";
      _operation = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: [
          // Tela de exibição
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: TextStyle(fontSize: 40), // Tamanho da fonte reduzido para caber melhor
            ),
          ),
          // Grid com os botões da calculadora
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                String buttonText;
                switch (index) {
                  case 0:
                    buttonText = "7";
                    break;
                  case 1:
                    buttonText = "8";
                    break;
                  case 2:
                    buttonText = "9";
                    break;
                  case 3:
                    buttonText = "/";
                    break;
                  case 4:
                    buttonText = "4";
                    break;
                  case 5:
                    buttonText = "5";
                    break;
                  case 6:
                    buttonText = "6";
                    break;
                  case 7:
                    buttonText = "*";
                    break;
                  case 8:
                    buttonText = "1";
                    break;
                  case 9:
                    buttonText = "2";
                    break;
                  case 10:
                    buttonText = "3";
                    break;
                  case 11:
                    buttonText = "-";
                    break;
                  case 12:
                    buttonText = "0";
                    break;
                  case 13:
                    buttonText = "=";
                    break;
                  case 14:
                    buttonText = "C";
                    break;
                  case 15:
                    buttonText = "+";
                    break;
                  case 16:
                    buttonText = ".";
                    break;
                  default:
                    buttonText = "";
                }

                return ElevatedButton(
                  onPressed: () {
                    if (buttonText == "=") {
                      _calculate();
                    } else if (buttonText == "C") {
                      _clear();
                    } else if (["+", "-", "*", "/"].contains(buttonText)) {
                      _setOperation(buttonText);
                    } else {
                      _appendToOutput(buttonText);
                    }
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(fontSize: 22), // Tamanho da fonte reduzido
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
