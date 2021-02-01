import 'package:flutter/material.dart';
import 'package:calculator/calculator.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: Theme.of(context).textTheme.apply(
          fontSizeFactor: 1.2,
          fontSizeDelta: 2.0,
        ),
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Calculator _calculator = Calculator();
  final Map<String, CalculatorOperation> string2Operator = Calculator.signs.map((key, value) => MapEntry(value, key));

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (keyEvent){
        if(keyEvent.runtimeType == RawKeyUpEvent)
          return;

        switch(keyEvent.character){
          case "1":
          case "2":
          case "3":
          case "4":
          case "5":
          case "6":
          case "7":
          case "8":
          case "9":
          case "0":
            _calculator.NumberInput(int.parse(keyEvent.character));
            break;
          case ".":
            _calculator.DOT();
            break;
          case "/":
          case "*":
          case "+":
          case "-":
            _calculator.setOperation(string2Operator[keyEvent.character]);
            break;
          default:
            final pressed = keyEvent.data.logicalKey.keyId;
            if(pressed == LogicalKeyboardKey.backspace.keyId || pressed == LogicalKeyboardKey.delete.keyId || pressed == LogicalKeyboardKey.numpadBackspace.keyId)
              _calculator.DEL();
            
            if(pressed == LogicalKeyboardKey.equal.keyId || pressed == LogicalKeyboardKey.enter.keyId || pressed == LogicalKeyboardKey.numpadEnter.keyId || pressed == LogicalKeyboardKey.numpadEqual.keyId)
              _calculator.EQULE();
        }

        setState(() {});
      },
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Container(
                        child: Text(_calculator.expression, style: TextStyle(fontSize: _calculator.calcFontSize(), color: Colors.amber),),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(children: [
                Expanded(flex: 2, child: TextButton(onPressed: () => setState(() =>_calculator.AC()), child: Text("AC"))),
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.DEL()), child: Text("DEL"))),
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.setOperation(CalculatorOperation.divide)), child: Text("/")))
              ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
              ),
            ),
            Expanded(
              child: Row(children: [
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.NumberInput(7)), child: Text("7"))),
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.NumberInput(8)), child: Text("8"))),
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.NumberInput(9)), child: Text("9"))),
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.setOperation(CalculatorOperation.miltiply)), child: Text("*")))
              ],
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,),
            ),
            Expanded(
              child: Row(children: [
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.NumberInput(4)), child: Text("4"))),
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.NumberInput(5)), child: Text("5"))),
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.NumberInput(6)), child: Text("6"))),
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.setOperation(CalculatorOperation.plus)), child: Text("+")))
              ],              crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,),
            ),
            Expanded(
              child: Row(children: [
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.NumberInput(1)), child: Text("1"))),
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.NumberInput(2)), child: Text("2"))),
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.NumberInput(3)), child: Text("3"))),
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.setOperation(CalculatorOperation.minus)), child: Text("-")))
              ],              crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,),
            ),
            Expanded(
              child: Row(children: [
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.DOT()), child: Text("."))),
                Expanded(flex: 1, child: TextButton(onPressed: () => setState(() =>_calculator.NumberInput(0)), child: Text("0"))),
                Expanded(flex: 2, child: TextButton(onPressed: () => setState(() =>_calculator.EQULE()), child: Text("=")))
          ],              crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,),
            )
        ],)
      ),
    );
  }
}