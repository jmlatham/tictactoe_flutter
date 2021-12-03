import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe with Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tic-Tac-Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _player = 0;
  final int _computer = 1;
  final int _cat = -1;
  int _winner = -1;
  int _turnCounter = 0;
  bool _isPlayerTurn = false;
  bool _gameIsOver = false;
  bool _topEnabled = true;
  bool _rightEnabled = true;
  bool _bottomEnabled = true;
  bool _leftEnabled = true;
  bool _topLeftEnabled = true;
  bool _topRightEnabled = true;
  bool _bottomLeftEnabled = true;
  bool _bottomRightEnabled = true;
  bool _centerEnabled = true;
  final IconData _computerIcon = Icons.close_outlined;
  final IconData _playerIcon = Icons.circle_outlined;
  final IconData _defaultIcon = Icons.crop_3_2_outlined;
  late List<List<IconData>> _values; //= List<List<IconData>>.generate(3, (_) => List<IconData>.filled(3, _defaultIcon, growable: false));

  _MyHomePageState(){
    _values = List<List<IconData>>.generate(3, (_) => List<IconData>.filled(3, _defaultIcon, growable: false));
    Random random = Random();
    _isPlayerTurn = random.nextInt(2) == 1;
  }

  void _makePlay(int row, int col){
    _values[row][col] = (_isPlayerTurn)?_playerIcon:_computerIcon;
    _gameIsOver = getGameIsOver();
    if(!_gameIsOver){
      _isPlayerTurn = !_isPlayerTurn;
    }
    _turnCounter += 1;
  }

  bool getGameIsOver(){
    _winner = (_isPlayerTurn)? _player : _computer;
    for(var i = 0; i < 3; i++){
      if (rowIsEqual(i)) return true;
    }
    for(var i = 0; i < 3; i++){
      if (colIsEqual(i)) return true;
    }
    if(diagonalIsEqual()){
      return true;
    }
    if(_turnCounter > 7){
      _winner = _cat;
      return true;
    }
    return false;
  }

  bool rowIsEqual(int row){
    return !_values[row].contains(_defaultIcon) && _values[row][0] == _values[row][1] &&
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Row(
              children:[
                IconButton(
                  icon: Icon(
                    _values[0][0]
                  ),
                  onPressed: _topLeftEnabled && !_gameIsOver ?() {
                    setState(() {
                      _topLeftEnabled = false;
                      _makePlay(0, 0);
                    });
                  }:null,
                ),
                IconButton(
                  icon: Icon(
                    _values[0][1]
                  ),
                  onPressed: _topEnabled && !_gameIsOver ?() {
                    setState(() {
                      _topEnabled = false;
                      _makePlay(0, 1);
                    });
                  }:null,
                ),
                IconButton(
                  icon: Icon(
                    _values[0][2]
                  ),
                  onPressed: _topRightEnabled && !_gameIsOver ?() {
                    setState(() {
                      _topRightEnabled = false;
                      _makePlay(0, 2);
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
                  ),
                  onPressed: _leftEnabled && !_gameIsOver ?() {
                    setState(() {
                      _leftEnabled = false;
                      _makePlay(1, 0);
                    });
                  }:null,
                ),
                IconButton(
                  icon: Icon(
                    _values[1][1]
                  ),
                  onPressed: _centerEnabled && !_gameIsOver ?() {
                    setState(() {
                      _centerEnabled = false;
                      _makePlay(1, 1);
                    });
                  }:null,
                ),
                IconButton(
                  icon: Icon(
                    _values[1][2]
                  ),
                  onPressed: _rightEnabled && !_gameIsOver ?() {
                    setState(() {
                      _rightEnabled = false;
                      _makePlay(1, 2);
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
                  ),
                  onPressed: _bottomLeftEnabled && !_gameIsOver ?() {
                    setState(() {
                      _bottomLeftEnabled = false;
                      _makePlay(2, 0);
                    });
                  }:null,
                ),
                IconButton(
                  icon: Icon(
                    _values[2][1]
                  ),
                  onPressed: _bottomEnabled && !_gameIsOver ?() {
                    setState(() {
                      _bottomEnabled = false;
                      _makePlay(2, 1);
                    });
                  }:null,
                ),
                IconButton(
                  icon: Icon(
                    _values[2][2]
                  ),
                  onPressed: _bottomRightEnabled && !_gameIsOver ?() {
                    setState(() {
                      _bottomRightEnabled = false;
                      _makePlay(2, 2);
                    });
                  }:null,
                ),
              ],
            ),
            Text(
              (_gameIsOver)
                ?(_winner == 0)
                  ?"Player Won!"
                  :(_winner == 1)
                      ?"Computer Won!!"
                      :"Cat Won!!"
                :""
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetGame,
        tooltip: 'Reset',
        child: const Icon(Icons.restart_alt_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _resetGame(){
    setState(() {
      _resetIcons();
      _resetCounter();
      _resetBooleanValues();
    });
  }

  void _resetIcons() {
    for(var i = 0; i < 3; i++){
      for(var j = 0; j<3; j++){
        _values[i][j] = _defaultIcon;
      }
    }
  }

  void _resetCounter() {
    _turnCounter = 0;
  }

  void _resetBooleanValues() {
    _gameIsOver = false;
    _topEnabled = true;
    _rightEnabled = true;
    _bottomEnabled = true;
    _leftEnabled = true;
    _topLeftEnabled = true;
    _topRightEnabled = true;
    _bottomLeftEnabled = true;
    _bottomRightEnabled = true;
    _centerEnabled = true;
  }
}
