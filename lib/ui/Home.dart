import 'package:bmi_calculater/ui/custombutton/custom_button.dart';
import 'package:flutter/material.dart';

var titles = '';

class Home extends StatefulWidget {
  var title = '';

  Home({Key key, @required this.title}) : super(key: key);

  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  double _bmiValue = 0.0;
  String _statusOfBmi = '';
  MaterialColor _statusColor = Colors.deepOrange;
  final TextEditingController _ageController = new TextEditingController();
  final TextEditingController _heightController = new TextEditingController();
  final TextEditingController _weightController = new TextEditingController();

  final sccafoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void _onTapButton() {
      setState(() {
        if (_ageController.text.isEmpty &&
            _heightController.text.isEmpty &&
            _weightController.text.isEmpty) {
          _statusOfBmi = '';
        }
        if (checkValidation()) {
          var age = double.parse(_ageController.text.trim());
          var height = double.parse(_heightController.text.trim()) * 0.01;
          var weight = double.parse(_weightController.text.trim());

          _bmiValue = _calculateBmiValue(age, height, weight);
          _statusOfBmi = _calclateStatusOnBmi(_bmiValue);
          _statusColor = _calculateColor(_statusOfBmi);
        }
      });
    }

    return new Scaffold(
      key: sccafoldKey,
      appBar: new AppBar(
        title: new Text(widget.title),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.grey[100],
      body: new Center(
        child: new ListView(
          children: <Widget>[
            new Image.asset('images/bmi_image.gif'),
            new Container(
              color: Colors.blueGrey[100],
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: new Column(
                children: <Widget>[
                  new TextField(
                    controller: _ageController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      fillColor: Colors.blueAccent,
                      labelText: 'AGE',
                      hintText: 'Enter your age',
                      icon: new Icon(Icons.person),
                    ),
                  ),
                  new TextField(
                    controller: _heightController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      fillColor: Colors.blueAccent,
                      labelText: 'Height in CMs',
                      hintText: 'Enter your height',
                      icon: new Icon(Icons.airline_seat_recline_normal),
                    ),
                  ),
                  new TextField(
                    controller: _weightController,
                    cursorColor: Colors.blueAccent,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      fillColor: Colors.blueAccent,
                      labelText: 'Weight in Kg',
                      hintText: 'Enter your weight',
                      icon: new Icon(Icons.cloud_done),
                    ),
                  )
                ],
              ),
            ),
            new Padding(padding: EdgeInsets.all(5.0)),
            new Center(
              child: new CustomButton(
                title: 'Calculate',
                padding: 30.0,
                color: Colors.amber,
                padding_top_bottom: 15.0,
                radius: 8.0,
                textColor: Colors.white,
                taps: _onTapButton,
              ),
            ),
            new Padding(padding: EdgeInsets.all(10.0)),
            new Text(
              'Your Bmi is: ${_bmiValue.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 19.0,
                color: Colors.blue,
              ),
            ),
            new Padding(padding: EdgeInsets.all(10.0)),
            new Text(
              '$_statusOfBmi',
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22.0,
                color: _statusColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  bool checkValidation() {
    if (_ageController.text.isEmpty) {
      sccafoldKey.currentState.showSnackBar(new SnackBar(
          content: Text('Please enter your age.'),
          backgroundColor: Colors.redAccent));
      return false;
    } else if (double.parse(_ageController.text.trim()).toDouble() < 0) {
      sccafoldKey.currentState.showSnackBar(new SnackBar(
          content: Text('Please enter your valid age.'),
          backgroundColor: Colors.redAccent));
      return false;
    } else if (_heightController.text.isEmpty) {
      sccafoldKey.currentState.showSnackBar(new SnackBar(
          content: Text('Please enter your height in cm.'),
          backgroundColor: Colors.redAccent));
      return false;
    } else if (double.parse(_heightController.text.trim()).toDouble() < 0) {
      sccafoldKey.currentState.showSnackBar(new SnackBar(
          content: Text('Please enter your valid height.'),
          backgroundColor: Colors.redAccent));
      return false;
    } else if (_weightController.text.isEmpty) {
      sccafoldKey.currentState.showSnackBar(new SnackBar(
          content: Text('Please enter your weight in kg.'),
          backgroundColor: Colors.redAccent));
      return false;
    } else if (double.parse(_weightController.text.trim()).toDouble() < 0) {
      sccafoldKey.currentState.showSnackBar(new SnackBar(
          content: Text('Please enter your valid wieght.'),
          backgroundColor: Colors.redAccent));
      return false;
    }
    return true;
  }

  double _calculateBmiValue(double age, double height, double weight) {
    var hgt = height * height;
    var value = weight / hgt;
    return value;
  }

  String _calclateStatusOnBmi(double bmiValue) {
    if (bmiValue < 16) {
      return 'Severe Thinness';
    } else if (bmiValue >= 16 && bmiValue < 17) {
      return 'Moderate Thinness';
    } else if (bmiValue >= 17 && bmiValue < 18.5) {
      return 'Mild Thinness';
    } else if (bmiValue >= 18.5 && bmiValue < 25) {
      return 'Normal';
    } else {
      return 'OverWeight';
    }
  }

  MaterialColor _calculateColor(String statusOfBmi) {
    switch (statusOfBmi) {
      case 'Severe Thinness':
        return Colors.red;
      case 'Moderate Thinness':
        return Colors.pink;
      case 'Mild Thinness':
        return Colors.orange;
      case 'Normal':
        return Colors.green;
      case 'OverWeight':
        return Colors.blue;
    }
  }
}
