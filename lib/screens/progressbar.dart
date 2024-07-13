import 'package:backendapp/screens/task_progress_list.dart';
import 'package:backendapp/utils/navigators.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class EnhancedHalfCircleProgressBar extends StatelessWidget {
  final double progress;

  EnhancedHalfCircleProgressBar(this.progress);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text('Progress Indicator'),
        ListTile(
          leading: Text(
              'Progress Indicator',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                // decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),
            ),
            trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 20.0,
                ),
        ),
        GestureDetector(
          onTap: () {
            // Handle tap event
            print('Progress bar clicked');
            navigatorPush(context,  TasksScreen());
          },
          child: SfRadialGauge(
            // backgroundColor: Colors.teal,
            enableLoadingAnimation: true,
            // title: GaugeTitle(
            //   text: 'Progress',
            //   textStyle: TextStyle(
            //     fontSize: 20.0,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black,
            //   ),
            // ),
            axes: <RadialAxis>[
              RadialAxis(
                startAngle: 180,
                endAngle: 0,
                radiusFactor: 0.8,
                canScaleToFit: true,
                showLabels: false,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.1,
                  cornerStyle: CornerStyle.bothFlat,
                  color: Colors.grey.withOpacity(0.3),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: progress * 100,
                    width: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    cornerStyle: CornerStyle.bothFlat,
                    gradient: SweepGradient(
                      colors: <Color>[Colors.green, Colors.teal],
                      stops: <double>[0.25, 0.75],
                    ),
                    // shadowColor: Colors.black.withOpacity(0.3),
                    // shadowOffset: Offset(2, 2),
                    // shadowBlurRadius: 4,
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Container(
                      child: Text(
                        "${(progress * 100).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    angle: 90,
                    // angle: 10,
                    // positionFactor: 0.1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}


