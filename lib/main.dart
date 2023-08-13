import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: TempApp(),
    );
  }
}

class TempApp extends StatefulWidget {
  const TempApp({super.key});

  @override
  State<TempApp> createState() => _TempAppState();
}

class _TempAppState extends State<TempApp> {
  late double input;
  late double output;
  late bool fOrC;

  @override
  void initState() {
    super.initState();
    input = 0.0;
    output = 0.0;
    fOrC = true;
  }

  @override
  Widget build(BuildContext context) {
    TextField inputField = TextField(
      keyboardType: TextInputType.number,
      onChanged: (str){
        try {
          input = double.parse(str);
        } catch (e) {
          input = 0.0;
        }
      },
      decoration: InputDecoration(
        labelText:
               "Input a Value in ${fOrC == false ? "Fahrenheit" : "Celsius"}",
      ) ,
    );

    AppBar appBar = AppBar(
      title: Text("Temperature Calculator"),
    );
    
    Container tempSwitch = Container(
      child: Column(
        children: <Widget>[
          Text("Choose Fahrenheit or Celsius"),
          Switch(
            value: fOrC,
            onChanged: (e) {
              setState(() {
                fOrC = !fOrC;
              });
            },
          )
        ],
      ),
    );

    Container calcBtn = Container(
      child: ElevatedButton(
        child: Text("Calculate"),
        onPressed: () {
          setState(() {
            fOrC == false
                ? output = (input - 32) * (5/9)
                : output = ( input * 9 / 5) + 32;
          });
            showDialog(context: context,
                builder: (context) => AlertDialog(
                  title: Text('The Result'),
                  content: fOrC == false
                      ? Text(
                      "${input.toStringAsFixed(2)} F : ${output.toStringAsFixed(2)} C")
                      : Text(
                      "${input.toStringAsFixed(2)} C : ${output.toStringAsFixed(2)} F") ,
                ),
              barrierDismissible: false,
            );
          },
        ),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[inputField,tempSwitch,calcBtn],
        ),
      ),
    );
  }
}


