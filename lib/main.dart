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
  bool _isPlayerTurn = true;
  bool _gameIsOver = false;
  final IconData _computerIcon = Icons.close_outlined;
  final IconData _playerIcon = Icons.circle_outlined;
  final IconData _defaultIcon = Icons.crop_3_2_outlined;
  late List<List<GameTile>> _tiles;
  String _selectedValue = "human";
  String _playerOneWinMessage = "Player O Won!!";
  String _playerTwoWinMessage = "Player X Won!!";
  final String _catWinMessage = "The Cat Won and you both lost!!";

  _MyHomePageState() {
    _tiles = [
      [GameTile(), GameTile(), GameTile()],
      [GameTile(), GameTile(), GameTile()],
      [GameTile(), GameTile(), GameTile()]
    ];
  }



  void _computersTurn(){
    Random random = Random();
    int row = random.nextInt(3);
    int col = random.nextInt(3);
    while(!_tiles[row][col].enabled){
      row = random.nextInt(3);
      col = random.nextInt(3);
    }
    _tiles[row][col].icon = (_isPlayerTurn) ? _playerIcon : _computerIcon;
    _tiles[row][col].enabled = false;
    _gameIsOver = getGameIsOver();
    if (!_gameIsOver) {
      _isPlayerTurn = !_isPlayerTurn;
    } else {
      return;
    }
    _turnCounter += 1;
  }

  void _makePlay(int row, int col) {
    _tiles[row][col].icon = (_isPlayerTurn) ? _playerIcon : _computerIcon;
    _tiles[row][col].enabled = false;
    _gameIsOver = getGameIsOver();
    if (!_gameIsOver) {
      _isPlayerTurn = !_isPlayerTurn;
    } else {
      return;
    }
    _turnCounter += 1;
    if(_selectedValue == "computer") {
      _playerOneWinMessage = "You Won!!!";
      _playerTwoWinMessage = "The Computer Won!!";
      _computersTurn();
    } else {
      _playerOneWinMessage = "Player O Won!!";
      _playerTwoWinMessage = "Player X Won!!";
    }
  }

  bool getGameIsOver() {
    _winner = (_isPlayerTurn) ? _player : _computer;
    for (var i = 0; i < 3; i++) {
      if (rowIsEqual(i)) return true;
    }
    for (var i = 0; i < 3; i++) {
      if (colIsEqual(i)) return true;
    }
    if (diagonalIsEqual()) {
      return true;
    }
    if (_turnCounter > 7) {
      _winner = _cat;
      return true;
    }
    return false;
  }

  bool rowIsEqual(int row) {
    return _tiles[row][0].icon != _defaultIcon &&
        _tiles[row][0].icon == _tiles[row][1].icon &&
        _tiles[row][0].icon == _tiles[row][2].icon;
  }

  bool colIsEqual(int col) {
    if (_tiles[0][col].icon == _defaultIcon) {
      return false;
    }
    return _tiles[0][col].icon == _tiles[1][col].icon &&
        _tiles[0][col].icon == _tiles[2][col].icon;
  }

  bool diagonalIsEqual() {
    return (_tiles[0][0].icon == _tiles[1][1].icon &&
            _tiles[1][1].icon == _tiles[2][2].icon && _tiles[0][0].icon != _defaultIcon) ||
        (_tiles[0][2].icon == _tiles[1][1].icon &&
            _tiles[1][1].icon == _tiles[2][0].icon && _tiles[0][2].icon != _defaultIcon);
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
          children: [
            const Text(
                "Welcome To A Game of Tic-Tac-Toe.",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Choose your opponent then touch or click",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text(
                  "a game tile to play the game.",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Column(
              children: [
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  title: const Text('Human'),
                  leading: Radio(
                    value: 'human',
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() { _selectedValue = value as String; });
                    },
                  ),
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  title: const Text('Computer'),
                  leading: Radio(
                    value: 'computer',
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() { _selectedValue = value as String; });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_tiles[0][0].icon),
                  onPressed: _tiles[0][0].enabled && !_gameIsOver
                      ? () {
                          setState(() {
                            _makePlay(0, 0);
                          });
                        }
                      : null,
                ),
                IconButton(
                  icon: Icon(_tiles[0][1].icon),
                  onPressed: _tiles[0][1].enabled && !_gameIsOver
                      ? () {
                          setState(() {
                            _makePlay(0, 1);
                          });
                        }
                      : null,
                ),
                IconButton(
                  icon: Icon(_tiles[0][2].icon),
                  onPressed: _tiles[0][2].enabled && !_gameIsOver
                      ? () {
                          setState(() {
                            _makePlay(0, 2);
                          });
                        }
                      : null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_tiles[1][0].icon),
                  onPressed: _tiles[1][0].enabled && !_gameIsOver
                      ? () {
                          setState(() {
                            _makePlay(1, 0);
                          });
                        }
                      : null,
                ),
                IconButton(
                  icon: Icon(_tiles[1][1].icon),
                  onPressed: _tiles[1][1].enabled && !_gameIsOver
                      ? () {
                          setState(() {
                            _makePlay(1, 1);
                          });
                        }
                      : null,
                ),
                IconButton(
                  icon: Icon(_tiles[1][2].icon),
                  onPressed: _tiles[1][2].enabled && !_gameIsOver
                      ? () {
                          setState(() {
                            _makePlay(1, 2);
                          });
                        }
                      : null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_tiles[2][0].icon),
                  onPressed: _tiles[2][0].enabled && !_gameIsOver
                      ? () {
                          setState(() {
                            _makePlay(2, 0);
                          });
                        }
                      : null,
                ),
                IconButton(
                  icon: Icon(_tiles[2][1].icon),
                  onPressed: _tiles[2][1].enabled && !_gameIsOver
                      ? () {
                          setState(() {
                            _makePlay(2, 1);
                          });
                        }
                      : null,
                ),
                IconButton(
                  icon: Icon(_tiles[2][2].icon),
                  onPressed: _tiles[2][2].enabled && !_gameIsOver
                      ? () {
                          setState(() {
                            _makePlay(2, 2);
                          });
                        }
                      : null,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text((_gameIsOver)
                  ? (_winner == 0)
                      ? _playerOneWinMessage
                      : (_winner == 1)
                          ? _playerTwoWinMessage
                          : _catWinMessage
                  : "",
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
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

  void _resetGame() {
    setState(() {
      _resetTiles();
      _resetCounter();
      _resetBooleanValues();
    });
  }

  void _resetTiles() {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        _tiles[i][j].icon = _defaultIcon;
        _tiles[i][j].enabled = true;
      }
    }
  }

  void _resetCounter() {
    _turnCounter = 0;
  }

  void _resetBooleanValues() {
    _gameIsOver = false;
    _isPlayerTurn = true;
  }
}

class GameTile {
  bool enabled = true;
  IconData icon = Icons.crop_3_2_outlined;
  GameTile();
}
