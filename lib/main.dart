import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe with Flutter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tic-Tac-Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _player = 0;
  int _computer = 1;
  int _cat = -1;
  int _counter = 0;
  int _winner = -1;
  int _turnCounter = -1;
  bool _isPlayerTurn = false;
  bool _gameIsOver = false;
  bool _gameHasStarted = false;
  bool _topEnabled = true;
  bool _rightEnabled = true;
  bool _bottomEnabled = true;
  bool _leftEnabled = true;
  bool _topLeftEnabled = true;
  bool _topRightEnabled = true;
  bool _bottomLeftEnabled = true;
  bool _bottomRightEnabled = true;
  bool _centerEnabled = true;
  IconData _computerIcon = Icons.close_outlined;
  IconData _playerIcon = Icons.circle_outlined;
  IconData _defaultIcon = Icons.crop_3_2_outlined;
  // int _row = 3;
  // int _col = 4;
  // var twoDList = List.generate(3, (i) => List.generate(3, (j) => j, growable:false), growable: false);
  late List<List<IconData>> _values; //= List<List<IconData>>.generate(3, (_) => List<IconData>.filled(3, _defaultIcon, growable: false));

  _MyHomePageState(){
    _values = List<List<IconData>>.generate(3, (_) => List<IconData>.filled(3, _defaultIcon, growable: false));
    // for(var i = 0; i < _values.length; i++){
    //   for(var j = 0; i < _values[i].length; i++){
    //     // print(_values[i][j]);
    //     _values[i][j] = _defaultIcon;
    //   }
    // }
    Random random = Random();
    _isPlayerTurn = random.nextInt(2) == 1;
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  bool getGameIsOver(){
    if(_turnCounter > 7){
      _winner = _cat;
      return true;
    }
    // for(var i = 0; i < 3; i++){
    //   if (_values[i].contains(_defaultIcon)) return false;
    // }
    _winner = (_isPlayerTurn)? _player : _computer;
    for(var i = 0; i < 3; i++){
      if (rowIsEqual(i)) return true;
    }
    for(var i = 0; i < 3; i++){
      if (colIsEqual(i)) return true;
    }
    return diagonalIsEqual();
  }

  bool rowIsEqual(int row){
    return !_values[row].contains(_defaultIcon) && [row][0] == _values[row][1] &&
    _values[row][0] == _values[row][2];
  }

  bool colIsEqual(int col){
    if(_values[0][col] == _defaultIcon){
      return false;
    }
    return _values[0][col] == _values[1][col] &&
        _values[0][col] == _values[2][col];
  }

  bool diagonalIsEqual(){
    if(_values[0][0] == _defaultIcon || _values[0][2] == _defaultIcon){
      return false;
    }
    return (
      _values[0][0] == _values[1][1] &&
        _values[1][1] == _values[2][2]
    ) || (
        _values[0][2] == _values[1][1] &&
            _values[1][1] == _values[2][0]
    );
  }

  @override
  Widget build(BuildContext context) {
    // final gameHasStarted = _gameHasStarted[0];
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Row(
              children:[
                IconButton(
                  icon: Icon(
                      // (_gameHasStarted && !_topLeftEnabled)?
                          _values[0][0]
                      // (_isPlayerTurn)?
                      // _playerIcon:_computerIcon
                      //     :_defaultIcon
                  ),
                  onPressed: _topLeftEnabled && !_gameIsOver ?() {
                    setState(() {
                      _topLeftEnabled = false;
                      _values[0][0] = (_isPlayerTurn)?_playerIcon:_computerIcon;
                      _gameHasStarted = true;
                      _gameIsOver = getGameIsOver();
                      if(_gameIsOver){
                        displayGameOverMessage();
                      } else {
                        _isPlayerTurn = !_isPlayerTurn;
                      }
                    });
                  }:null,
                ),
                IconButton(
                  icon: Icon(
                      // (_gameHasStarted && !_topEnabled)?
                          _values[0][1]
                      // (_isPlayerTurn)?
                      // _playerIcon:_computerIcon
                      //     :_defaultIcon
                  ),
                  onPressed: _topEnabled && !_gameIsOver ?() {
                    setState(() {
                      _topEnabled = false;
                      _values[0][1] = (_isPlayerTurn)?_playerIcon:_computerIcon;
                      _gameIsOver = getGameIsOver();
                      if(_gameIsOver){
                        displayGameOverMessage();
                      } else {
                        _isPlayerTurn = !_isPlayerTurn;
                      }
                    });
                  }:null,
                ),
                IconButton(
                  icon: Icon(
                    _values[0][2]
                      // (_gameHasStarted)?
                      // (_isPlayerTurn)?
                      // _playerIcon:_computerIcon:_defaultIcon
                  ),
                  onPressed: _topRightEnabled && !_gameIsOver ?() {
                    setState(() {
                      _topRightEnabled = false;
                      _values[0][2] = (_isPlayerTurn)?_playerIcon:_computerIcon;
                      _gameIsOver = getGameIsOver();
                      if(_gameIsOver){
                        displayGameOverMessage();
                      } else {
                        _isPlayerTurn = !_isPlayerTurn;
                      }
                    });
                  }:null,
                ),
              ],
            ),
            Row(
              children:[
                IconButton(
                  icon: Icon(
                    _values[1][0]
                      // (_gameHasStarted)?
                      // (_isPlayerTurn)?
                      // _playerIcon:_computerIcon:_defaultIcon
                  ),
                  onPressed: _leftEnabled && !_gameIsOver ?() {
                    setState(() {
                      _leftEnabled = false;
                      _values[1][0] = (_isPlayerTurn)?_playerIcon:_computerIcon;
                      _gameIsOver = getGameIsOver();
                      if(_gameIsOver){
                        displayGameOverMessage();
                      } else {
                        _isPlayerTurn = !_isPlayerTurn;
                      }
                    });
                  }:null,
                ),
                IconButton(
                  icon: Icon(
                    _values[1][1]
                      // (_gameHasStarted)?
                      // (_isPlayerTurn)?
                      // _playerIcon:_computerIcon:_defaultIcon
                  ),
                  onPressed: _centerEnabled && !_gameIsOver ?() {
                    setState(() {
                      _centerEnabled = false;
                      _values[1][1] = (_isPlayerTurn)?_playerIcon:_computerIcon;
                      _gameIsOver = getGameIsOver();
                      if(_gameIsOver){
                        displayGameOverMessage();
                      } else {
                        _isPlayerTurn = !_isPlayerTurn;
                      }
                    });
                  }:null,
                ),
                IconButton(
                  icon: Icon(
                    _values[1][2]
                      // (_gameHasStarted)?
                      // (_isPlayerTurn)?
                      // _playerIcon:_computerIcon:_defaultIcon
                  ),
                  onPressed: _rightEnabled && !_gameIsOver ?() {
                    setState(() {
                      _rightEnabled = false;
                      _values[1][2] = (_isPlayerTurn) ? _playerIcon : _computerIcon;
                      _gameIsOver = getGameIsOver();
                      if (_gameIsOver) {
                        displayGameOverMessage();
                      } else {
                        _isPlayerTurn = !_isPlayerTurn;
                      }
                    });
                  }:null,
                ),
              ],
            ),
            Row(
              children:[
                IconButton(
                  icon: Icon(
                    _values[2][0]
                      // (_gameHasStarted)?
                      // (_isPlayerTurn)?
                      // _playerIcon:_computerIcon:_defaultIcon
                  ),
                  onPressed: _bottomLeftEnabled && !_gameIsOver ?() {
                    setState(() {
                      _bottomLeftEnabled = false;
                      _values[2][0] = (_isPlayerTurn)?_playerIcon:_computerIcon;
                      _gameIsOver = getGameIsOver();
                      if (_gameIsOver) {
                        displayGameOverMessage();
                      } else {
                        _isPlayerTurn = !_isPlayerTurn;
                      }
                    });
                  }:null,
                ),
                IconButton(
                  icon: Icon(
                    _values[2][1]
                      // (_gameHasStarted)?
                      // (_isPlayerTurn)?
                      // _playerIcon:_computerIcon:_defaultIcon
                  ),
                  onPressed: _bottomEnabled && !_gameIsOver ?() {
                    setState(() {
                      _bottomEnabled = false;
                      _values[2][1] = (_isPlayerTurn)?_playerIcon:_computerIcon;
                      _gameIsOver = getGameIsOver();
                      if (_gameIsOver) {
                        displayGameOverMessage();
                      } else {
                        _isPlayerTurn = !_isPlayerTurn;
                      }
                    });
                  }:null,
                ),
                IconButton(
                  icon: Icon(
                    _values[2][2]
                      // (_gameHasStarted)?
                      // (_isPlayerTurn)?
                      // _playerIcon:_computerIcon:_defaultIcon
                  ),
                  onPressed: _bottomRightEnabled && !_gameIsOver ?() {
                    setState(() {
                      _bottomRightEnabled = false;
                      _values[2][2] = (_isPlayerTurn)?_playerIcon:_computerIcon;
                      _gameIsOver = getGameIsOver();
                      if (_gameIsOver) {
                        displayGameOverMessage();
                      } else {
                        _isPlayerTurn = !_isPlayerTurn;
                      }
                    });
                  }:null,
                ),
              ],
            ),
          ],
          // children: <Widget>[
          //   const Text(
          //     'You have pushed the button this many times:',
          //   ),
          //   Text(
          //     '$_counter',
          //     style: Theme.of(context).textTheme.headline4,
          //   ),
          // ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void displayGameOverMessage(){

  }
}
