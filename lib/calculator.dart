import 'dart:math';

enum CalculatorOperation { 
  plus,
  minus,
  divide,
  miltiply
}

class Calculator{
  String _firstNumber;
  String _secondNumber;
  CalculatorOperation _operation;
  String expression;

  void _ruleTheJoke(){
    var possibleJokes = [
      "0",
      "Sveagruva's creation",
      "hahahaahha",
      "hi",
      "hi as I always say",
      "this is calculotor",
      "follow my twitter @sveagruwa",
      "follow your dreams",
      ":)",
      "🦄",
      "shout out to me",
      "dark theme only",
      "searching for solution",
      "now with keyboard input",
      "hacking your pc...",
      "shiting down..." // TODO shit down pc if not closed in 3 seconds
    ];

    final _random = new Random();
    expression = possibleJokes[_random.nextInt(possibleJokes.length)];
  }

  Calculator(){
    _ruleTheJoke();
  }

  static final Map<CalculatorOperation, String> signs = {
    CalculatorOperation.plus: "+",
    CalculatorOperation.minus: "-",
    CalculatorOperation.divide: "/",
    CalculatorOperation.miltiply: "*"
  };

  void DEL(){
    if(_firstNumber == null)
      return;

    if(_firstNumber.length == 1)
      return _SetFirstNumber(null);

    if(_operation == null)
      return _SetFirstNumber(_firstNumber.substring(0, _firstNumber.length - 1));

    if(_secondNumber == null)
      return setOperation(null);

    if(_secondNumber.length == 1)
      return _SetSecondNumber(null);

    _secondNumber = _secondNumber.substring(0, _secondNumber.length - 1);
  }

  void AC(){
    _firstNumber = null;
    _secondNumber = null;
    _operation = null;
    expression = "0";
    _ruleTheJoke();
  }

  void DOT(){
    if(_firstNumber == null)
      return _SetFirstNumber("0.");

    if(_firstNumber.endsWith("."))
      return;

    if(_firstNumber.indexOf(".") == -1)
      return _SetFirstNumber(_firstNumber + ".");

    if(_operation == null)
      return;

    if(_secondNumber == null)
      return _SetSecondNumber("0.");

    if(_secondNumber.endsWith("."))
      return;

    if(_secondNumber.indexOf(".") == -1)
      return _SetSecondNumber(_secondNumber + ".");
  }

  void EQULE(){
    if(_firstNumber == null)
      return _SetExpression("input first number or choose an operation");

    if(_operation == null)
      return _SetExpression("operation is not choosen");

    if(_secondNumber == null)
      return _SetExpression("input second number or choose an operation");

    if((_secondNumber == "0" || _secondNumber == "0.0") && _operation == CalculatorOperation.divide)
      return _SetExpression("more than you can count");

    double first = double.parse(_firstNumber);
    double second = double.parse(_secondNumber);
    switch(_operation){
      case CalculatorOperation.divide:
        _SetExpression((first / second).toString());
        break;
      case CalculatorOperation.miltiply:
        _SetExpression((first * second).toString());
        break;
      case CalculatorOperation.minus:
        _SetExpression((first - second).toString());
        break;
      case CalculatorOperation.plus:
        _SetExpression((first + second).toString());
        break;
    }

    _firstNumber = expression;
    _operation = null;
    _secondNumber = null;
  }

  void _update(){
    if(_firstNumber == null)
      return _SetExpression("");

    if(_operation == null)
      return _SetExpression(_firstNumber);

    if(_secondNumber == null)
      return _SetExpression(_firstNumber + " " + signs[_operation]);

    _SetExpression(_firstNumber + " " + signs[_operation] + " " + _secondNumber);
  }

  void NumberInput(int number){
    if(_firstNumber == null)
      return _SetFirstNumber(number.toString());

    if(_operation == null)
      return _SetFirstNumber(_firstNumber + number.toString());

    if(_secondNumber == null)
      return _SetSecondNumber(number.toString());

    _SetSecondNumber(_secondNumber + number.toString());
    _update();
  }

  double calcFontSize(){
    if(expression.length < 26)
      return 36;

    return expression.length / 1.8 < 16 ? 16 : expression.length / 1.8;
  }

  void _SetExpression(String expression){
    this.expression = expression;
  }
  void _SetFirstNumber(String number) { _firstNumber = number; _update(); }
  void _SetSecondNumber(String number) { _secondNumber = number; _update();}
  void setOperation(CalculatorOperation operation){
    // if(_firstNumber == null || _firstNumber.endsWith("."))
    //   return;

    _operation = operation;
    _update();
  }
}