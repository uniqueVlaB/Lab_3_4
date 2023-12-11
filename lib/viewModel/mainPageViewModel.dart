import 'package:lab_3_4/model/port.dart';

class MainPageViewModel{
String title;
List<Port> ports;
MainPageViewModel(this.title, this.ports);
MainPageViewModel.defaultPort(this.title):ports = List<Port>.generate(3, (_) => Port.defaultVal(), growable: true);

void incrementPort(int index){
ports[index]++;
}

int deletePort(int index){
  if(index >= 0 && index < ports.length)ports.removeAt(index);
  if(index > ports.length-1)return index - 1;
  return index;
}

String addPort({required String inName,
                 required String inAddress,
                 required String inWorkers,
                 required String inVehicles,
                 required String inVehicleCost,
                 required String inServiceCost,
                 required String inServiceTime,
                 required String inDocks,
                 })
{
  int? workers = int.tryParse(inWorkers);
  if(workers == null) return "Workers input isn`t correct!!!";

  int? vehicles = int.tryParse(inVehicles);
  if(vehicles == null) return "Vehicles input isn`t correct!!!";

  double? vehicleCost = double.tryParse(inVehicleCost);
  if(vehicleCost == null) return "Vehicle cost input isn`t correct!!!";

  double? serviceCost = double.tryParse(inServiceCost);
  if(serviceCost == null) return "Service cost input isn`t correct!!!";

  double? serviceTime = double.tryParse(inServiceTime);
  if(serviceTime == null) return "Service time input isn`t correct!!!";

  int? docks = int.tryParse(inDocks);
  if(docks == null) return "Docks input isn`t correct!!!";

  ports.add(Port(
      inName,
      inAddress,
      workers,
      vehicles,
      vehicleCost,
      serviceCost,
      serviceTime,
      docks
  ));
  return "New port has been successfully added!!!";
}
void copyPort(int index){
  ports.add(Port.copy(ports[index]));
}

String editPort({required String inName,
  required String inAddress,
  required String inWorkers,
  required String inVehicles,
  required String inVehicleCost,
  required String inServiceCost,
  required String inServiceTime,
  required String inDocks,
  required int index,
})
{
  int? workers = int.tryParse(inWorkers);
  if(workers == null) return "Workers input isn`t correct!!!";

  int? vehicles = int.tryParse(inVehicles);
  if(vehicles == null) return "Vehicles input isn`t correct!!!";

  double? vehicleCost = double.tryParse(inVehicleCost);
  if(vehicleCost == null) return "Vehicle cost input isn`t correct!!!";

  double? serviceCost = double.tryParse(inServiceCost);
  if(serviceCost == null) return "Service cost input isn`t correct!!!";

  double? serviceTime = double.tryParse(inServiceTime);
  if(serviceTime == null) return "Service time input isn`t correct!!!";

  int? docks = int.tryParse(inDocks);
  if(docks == null) return "Docks input isn`t correct!!!";

  ports[index] = Port(
      inName,
      inAddress,
      workers,
      vehicles,
      vehicleCost,
      serviceCost,
      serviceTime,
      docks
  );
  return "Port has been successfully edited!!!";
}
}