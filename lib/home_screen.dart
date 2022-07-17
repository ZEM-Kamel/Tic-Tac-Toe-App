// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tic_tac_game/game_logic.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
String activePlayer = 'X';
bool gameOver = false;
int turn = 0;
String result = '';
Game game = Game();
bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: MediaQuery.of(context).orientation ==Orientation.portrait? Column(
          children: [
            ...firstBlock(),
           _expanded(context),
            ...lastBlock(),
          ],
        ): Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...firstBlock(),
                  ...lastBlock(),
                ],
              ),
            ),
            _expanded(context),
          ],
        )
      ),
    );
  }
  List<Widget> firstBlock(){
    return[
      SwitchListTile.adaptive(
        title: Text(
          'Turn On/Off Two Player',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
        value: isSwitched,
        onChanged: (bool newValue)
        {
          setState(() {
            isSwitched = newValue;
          });
        },
      ),
      Text(
        'It\'s  $activePlayer  Turn'.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 40.0,
        ),
        textAlign: TextAlign.center,
      ),
    ];
  }
Expanded _expanded(BuildContext context)
{
  return Expanded(
    child: GridView.count(
      padding: EdgeInsets.all(16.0),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      childAspectRatio: 1.0,
      crossAxisCount: 3,
      children: List.generate(9, (index) => InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: gameOver? null: ()=>_onTap(index),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).shadowColor,
              borderRadius: BorderRadius.circular(16.0)
          ),
          child: Center(
            child: Text(
              Player.playerX.contains(index)
                  ?'X'
                  :Player.playerO.contains(index)
                  ?'O'
                  :''
              ,
              style: TextStyle(
                color:  Player.playerX.contains(index)
                    ?Colors.blue
                    :Colors.red,
                fontSize: 30.0,
              ),
            ),
          ),
        ),
      )),
    ),
  );
}
List<Widget> lastBlock(){
    return [
      Text(
        result,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        ),
        textAlign: TextAlign.center,
      ),
      ElevatedButton.icon(
        onPressed: (){
          setState(() {
            Player.playerX = [];
            Player.playerO = [];
            activePlayer = 'X';
            gameOver = false;
            turn = 0;
            result = '';

          });
        },
        icon: Icon(
          Icons.replay,
        ),
        label: Text(
          'Play Again',
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Theme.of(context).splashColor),
        ),
      ),
    ];
}
  _onTap(int index) async {
     if((Player.playerX.isEmpty ||
        !Player.playerX.contains(index)) &&
         (Player.playerO.isEmpty ||
        !Player.playerO.contains(index))) {
       game.playGame(index, activePlayer);
      updateState();

      if(!isSwitched && !gameOver && turn != 9){
        await game.autoPlay(activePlayer);
        updateState();
      }
    }
  }
    void updateState(){
    setState(() {
      activePlayer = (activePlayer =='X')? 'O' :'X';
      turn++;

      String winnerPlayer = game.checkWinner();
      if(winnerPlayer != '')
        {
          gameOver = true;
          result = '$winnerPlayer Is The Winner';
        }
      else if (!gameOver && turn ==9)
      {
        result = 'It\'s Draw!';
      }
    });
  }
}
