
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:lab_3_4/view/addPortPage/addPortPage.dart';
import 'package:lab_3_4/view/mainPage/widgets/portTitleWidget.dart';
import 'package:lab_3_4/viewModel/mainPageViewModel.dart';
import 'package:lab_3_4/view/mainPage/widgets/portStatsWidget.dart';
import 'package:lab_3_4/view/mainPage/widgets/portActionsButtonArrayWidget.dart';
import '../editPortPage/editPortPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState(title);
}

class _MainPageState extends State<MainPage> {
  final MainPageViewModel _viewModel;
  _MainPageState(String title): _viewModel = MainPageViewModel.defaultPort(title);
  int topPortListIndex = 0;
  int bottomPortListIndex = 0;

  void _incrementPort(index) {
    setState(() {
      _viewModel.incrementPort(index);
    });
  }

  void _changePort(int index, bool isTop, bool isNext) {
    setState(() {
      if((isNext && index >= _viewModel.ports.length-1) || (!isNext && index <= 0))return;
      if(isNext){
        isTop ? topPortListIndex++ : bottomPortListIndex++;
      }
      else{
        isTop ? topPortListIndex-- : bottomPortListIndex--;
      }

    });
  }

  void _deletePort(index, bool isTop) {
    setState(() {
      if(isTop) {
        topPortListIndex = _viewModel.deletePort(topPortListIndex);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Port has been deleted!!!")));
        if (bottomPortListIndex > _viewModel.ports.length - 1) {
          bottomPortListIndex = _viewModel.ports.length - 1;
        }
      }
      else{
       bottomPortListIndex = _viewModel.deletePort(bottomPortListIndex);
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Port has been deleted!!!")));
       if (topPortListIndex > _viewModel.ports.length - 1) {
         topPortListIndex = _viewModel.ports.length - 1;
       }
      }
    });
  }

  void _copyPort(int index){
    setState(() {
      _viewModel.copyPort(index);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Copy of a port has been added to the list!!")));
    });

  }

  void _showCalculateDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    int currentIntValue = 10;
    double profitValue = _viewModel.ports[topPortListIndex].calculateProfit(currentIntValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Calculate profit'),
              content: Column(
                children: [
                  const Text("Number of ships to calculate"),
                  NumberPicker(
                    value: currentIntValue,
                    minValue: 0,
                    maxValue: 100,
                    step: 5,
                    haptics: true,
                    onChanged: (value) => setState(() {
                      currentIntValue = value;
                      profitValue = _viewModel.ports[topPortListIndex].calculateProfit(currentIntValue);
                    }
                    ),
                  ),
              Text(_viewModel.ports[topPortListIndex].name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              PortStatsWidget(
                  _viewModel.ports[topPortListIndex].workers,
                  _viewModel.ports[topPortListIndex].vehicles,
                  _viewModel.ports[topPortListIndex].vehicleCost,
                  _viewModel.ports[topPortListIndex].serviceCost,
                  _viewModel.ports[topPortListIndex].serviceTime,
                  _viewModel.ports[topPortListIndex].docks
              ),
                  Text("Profit for $currentIntValue ships: $profitValue", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ],
              ),
              actions: <Widget>[
                RawMaterialButton(
                  child: const Text('Close'),
                  onPressed: () {
                      Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showCompareDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    int result = _viewModel.ports[topPortListIndex].compareTo(_viewModel.ports[bottomPortListIndex]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Compare results'),
              content: SizedBox(
                height: 150,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${_viewModel.ports[topPortListIndex].name} VS ${_viewModel.ports[bottomPortListIndex].name}",),
                  const Divider(thickness: 0, height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Using Port.CompareTo the result is: $result",
                      ),
                      Text(
                        "Using <= the result is: ${_viewModel.ports[topPortListIndex] <= _viewModel.ports[bottomPortListIndex]}",
                      ),
                      Text(
                        "Using >= the result is: ${_viewModel.ports[topPortListIndex] >= _viewModel.ports[bottomPortListIndex]}",
                      ),
                    ],
                  ),
                ],
                )
              ),
              actions: <Widget>[
                RawMaterialButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future _goToAddPortPage() async {
      final Map<String, String> result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const AddPortPage(title: "Add port")),
      );
      setState(() {
      String addResult = _viewModel.addPort(
        inName: result["name"]??"",
        inAddress: result["address"]??"",
        inWorkers: result["workers"]??"",
        inVehicles: result["vehicles"]??"",
        inServiceCost: result["serviceCost"]??"",
        inVehicleCost: result["vehicleCost"]??"",
        inServiceTime: result["serviceTime"]??"",
        inDocks: result["docks"]??""
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(addResult)));
    });
  }

  Future _goToEditPortPage(int index) async {
    final Map<String, String> result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => EditPortPage(title: "Edit port", port: _viewModel.ports[index],)),
    );
    setState(() {
      String editResult = _viewModel.editPort(
          inName: result["name"]??"",
          inAddress: result["address"]??"",
          inWorkers: result["workers"]??"",
          inVehicles: result["vehicles"]??"",
          inServiceCost: result["serviceCost"]??"",
          inVehicleCost: result["vehicleCost"]??"",
          inServiceTime: result["serviceTime"]??"",
          inDocks: result["docks"]??"",
          index: index
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(editResult)));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_viewModel.title),
      ),

      body: (_viewModel.ports.isNotEmpty)
        ?SingleChildScrollView(
        child: Column(
          children: [
            PortTitleWidget(
              names: _viewModel.ports.map((port) => port.name).toList(),
              addresses: _viewModel.ports.map((port) => port.address).toList(),
              onPrevPressed: () => _changePort(topPortListIndex, true, false),
              onNextPressed:() => _changePort(topPortListIndex, true, true),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Column(
                    children: [
                      PortStatsWidget(
                          _viewModel.ports[topPortListIndex].workers,
                          _viewModel.ports[topPortListIndex].vehicles,
                          _viewModel.ports[topPortListIndex].vehicleCost,
                          _viewModel.ports[topPortListIndex].serviceCost,
                          _viewModel.ports[topPortListIndex].serviceTime,
                          _viewModel.ports[topPortListIndex].docks
                      ),
                    ],
                  ),
                  PortActionsButtonArrayWidget(
                      onIncrementPressed:() =>  _incrementPort(topPortListIndex),
                      onDeletePressed:() =>  _deletePort(topPortListIndex, true),
                      onCopyPressed:() => _copyPort(topPortListIndex),
                      onEditPressed:() => _goToEditPortPage(topPortListIndex),
                  ),
                ]
            ),
            const Divider(height: 20,color: Colors.black, thickness: 3,),
            PortTitleWidget(
              names: _viewModel.ports.map((port) => port.name).toList(),
              addresses: _viewModel.ports.map((port) => port.address).toList(),
              onPrevPressed: () => _changePort(bottomPortListIndex, false, false),
              onNextPressed: () => _changePort(bottomPortListIndex, false, true),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Column(
                    children: [

                      PortStatsWidget(
                          _viewModel.ports[bottomPortListIndex].workers,
                          _viewModel.ports[bottomPortListIndex].vehicles,
                          _viewModel.ports[bottomPortListIndex].vehicleCost,
                          _viewModel.ports[bottomPortListIndex].serviceCost,
                          _viewModel.ports[bottomPortListIndex].serviceTime,
                          _viewModel.ports[bottomPortListIndex].docks
                      ),
                    ],
                  ),
                  PortActionsButtonArrayWidget(
                      onIncrementPressed:() => _incrementPort(bottomPortListIndex),
                      onDeletePressed:() => _deletePort(bottomPortListIndex, false),
                      onCopyPressed:() => _copyPort(bottomPortListIndex),
                      onEditPressed: () => _goToEditPortPage(bottomPortListIndex),
                  ),
                ]
            ),
          ],
        ),
      )
        : const Text("Port List is empty!!!"),

    floatingActionButton: SpeedDial(
        backgroundColor: Colors.amberAccent,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            backgroundColor: Colors.amberAccent,
            child: const Icon(Icons.add),
            label: 'Add port',
            onTap: () =>   _goToAddPortPage()
          ),
          SpeedDialChild(
            backgroundColor: Colors.amberAccent,
            child: const Icon(Icons.calculate),
            label: 'Calculate profit',
            onTap: () => _showCalculateDialog(context),
          ),
          SpeedDialChild(
            backgroundColor: Colors.amberAccent,
            child: const Icon(Icons.compare),
            label: 'Compare ports',
            onTap: () => _showCompareDialog(context),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}