import 'package:flutter/material.dart';

class PortStatsWidget extends StatelessWidget {
 final int workers;
 final int vehicles;
 final double vehicleCost;
 final double serviceCost;
 final double serviceTime;
 final int docks;

  const PortStatsWidget(this.workers ,this.vehicles, this.vehicleCost, this.serviceCost, this.serviceTime, this.docks, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Number of docks: $docks",
            style: const TextStyle(
                fontSize: 14
            ),
          ),
          Text("Number of workers: $workers",
            style: const TextStyle(
                fontSize: 14
            ),
          ),
           Text("Number of vehicles: $vehicles",
            style: const TextStyle(
                fontSize: 14
            ),
          ),
          Text("Vehicle cost: $vehicleCost",
            style: const TextStyle(
                fontSize: 14
            ),
          ),
          Text("Service cost: $serviceCost",
            style: const TextStyle(
                fontSize: 14
            ),
          ),
          Text("Service time: $serviceTime hours",
            style: const TextStyle(
                fontSize: 14
            ),
          ),
        ],
      ),
    );
  }
}