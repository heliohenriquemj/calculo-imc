import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus Dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>(); // ADICIONE ESTA LINHA!
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);
      if (imc < 18.6) {
        _infoText = "Seu frango (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Ta fitness (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Mórbida I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Gordaaao II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Mórbida III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 120.0,
                        color: Colors.green,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Peso (kg)",
                            labelStyle: TextStyle(color: Colors.green)),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 25.0),
                        controller: weightController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Insira seu Peso";
                          }
                        },
                      ),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Altura (cm)",
                              labelStyle: TextStyle(color: Colors.green)),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.green, fontSize: 25.0),
                          controller: heightController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Insira sua Altura";
                            }
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Container(
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _calculate();
                              }
                            },
                            child: Text(
                              'Calcular',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        _infoText,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 25.0),
                      )
                    ]))));
  }
}
