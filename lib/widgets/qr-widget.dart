import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'circular_progress_indicator_widget.dart';

class QrImageWidget extends StatelessWidget {
  const QrImageWidget({
    Key key,
    @required this.function,
    @required this.size,
    @required StreamController<double> progressController,
  })  : _progressController = progressController,
        super(key: key);
  final Future<String> function;
  final Size size;
  final StreamController<double> _progressController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Container(
          width: size.width * .8,
          height: size.width * .8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: FutureBuilder(
                    future: function,
                    builder: (context, snapshot) =>
                        snapshot.hasData
                            ? ShaderMask(
                                blendMode: BlendMode.srcATop,
                                shaderCallback: (rect) => LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black,
                                    Colors.green,
                                  ],
                                ).createShader(rect),
                                child: QrImage(
                                  data: snapshot.data,
                                  size: size.width * .6,
                                ),
                              )
                            : CircularProgresIndicatorWidget(),
                  ),
                ),
              ),
              StreamBuilder<double>(
                initialData: 1,
                stream: _progressController.stream,
                builder: (context, snapshot) {
                  return LinearProgressIndicator(
                    value: snapshot.data,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}