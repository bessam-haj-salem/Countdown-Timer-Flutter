import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? timer;
  var minute = 0;
  var seconds = 0;
  late int totalTime;

  void startTimer() {
    final oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (timer) {
      print(minute);
      totalTime = minute * 60 + seconds;
      setState(() {
        if (totalTime < 1) {
          timer.cancel();
        } else {
          totalTime -= 1;
          print(totalTime);
          minute = (totalTime / 60).floor();

          seconds = (totalTime % 60);
          ;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.deepPurple),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Countdown Timer'),
        ),
        body: Center(
            child: Text('$minute:$seconds',
                style: Theme.of(context).textTheme.headline1)),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => SimpleDialog(
                        contentPadding: EdgeInsets.all(15),
                        children: [
                          Text('Set your time'),
                          DropdownButton(
                            value: minute,
                            icon: Text('Minute'),
                            items: List.generate(100, (index) {
                              return DropdownMenuItem(
                                value: index,
                                child: Text(index.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                minute = value as int;
                              });
                            },
                          ),
                          DropdownButton(
                            value: seconds,
                            icon: Text('Seconds'),
                            items: List.generate(60, (index) {
                              return DropdownMenuItem(
                                value: index,
                                child: Text(index.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                seconds = value as int;
                              });
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                startTimer();
                                Navigator.of(context).pop();
                              },
                              child: Text('Start'))
                        ],
                      ));
            },
            child: Icon(Icons.alarm_add_outlined)),
      ),
    );
  }
}
