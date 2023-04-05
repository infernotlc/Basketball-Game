import 'package:flutter/material.dart';

void main() => runApp(BasketballGameApp());

class BasketballGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basketball Game',
      home: Scaffold(
        body: BasketballGame(),
      ),
    );
  }
}

class BasketballCourt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/imgbin-tennis-centre-basketball-court-basketball-creative-fYyT6xfjSrjR6TBsG95cYhbUC.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class BasketballGame extends StatefulWidget {
  @override
  _BasketballGameState createState() => _BasketballGameState();
}

class _BasketballGameState extends State<BasketballGame> {
  Offset _ballPosition = Offset(0, 0);
  double _score = 0;

  bool _isScored(Offset ballPosition) {
    // Check if ball is inside the hoop
    if (ballPosition.dx > 160 && ballPosition.dx < 240 && ballPosition.dy > 70 && ballPosition.dy < 150) {
      return true;
    } else {
      return false;
    }
  }

  void _updateScore(Offset ballPosition) {
    if (_isScored(ballPosition)) {
      setState(() {
        _score++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (TapDownDetails details) {
        setState(() {
          _ballPosition = details.localPosition;
        });
      },
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          _ballPosition += details.delta;
        });
      },
      onPanEnd: (DragEndDetails details) {
        _updateScore(_ballPosition);
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: BasketballCourt(),
          ),
          Positioned(
            left: _ballPosition.dx,
            top: _ballPosition.dy,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  _ballPosition += details.delta;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              'Score: $_score',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Positioned(
            top: 0,
            left: 150,
            child: Container(
              width: 100,
              height: 20,
              color: Colors.orange,
            ),
          ),
          Positioned(
            top: 10,
            left: 160,
            child: Container(
              width: 80,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 150,
            child: Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

