import 'package:flutter/material.dart';

class AddPortPage extends StatefulWidget {
  const AddPortPage({super.key, required this.title});

  final String title;

  @override
  State<AddPortPage> createState() => _AddPortPageState();
}

class _AddPortPageState extends State<AddPortPage> with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _workersController = TextEditingController();
  final TextEditingController _vehiclesController = TextEditingController();
  final TextEditingController _vehicleCostController = TextEditingController();
  final TextEditingController _serviceCostController = TextEditingController();
  final TextEditingController _serviceTimeController = TextEditingController();
  final TextEditingController _docksController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = "Unknown";
    _addressController.text = "Unknown";
    _workersController.text = "1";
    _vehiclesController.text = "1";
    _vehicleCostController.text = "1";
    _serviceCostController.text = "1";
    _serviceTimeController.text = "1";
    _docksController.text = "1";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: SlideTransition(
          position: _offsetAnimation,
          child: Column(
            children: <Widget>[
              TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
              TextFormField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address')),
              TextFormField(controller: _workersController, decoration: const InputDecoration(labelText: 'Workers'), keyboardType: TextInputType.number,),
              TextFormField(controller: _vehiclesController, decoration: const InputDecoration(labelText: 'Vehicles'), keyboardType: TextInputType.number,),
              TextFormField(controller: _vehicleCostController, decoration: const InputDecoration(labelText: 'Vehicle Cost'), keyboardType: TextInputType.number,),
              TextFormField(controller: _serviceCostController, decoration: const InputDecoration(labelText: 'Service Cost'), keyboardType: TextInputType.number,),
              TextFormField(controller: _serviceTimeController, decoration: const InputDecoration(labelText: 'Service Time'), keyboardType: TextInputType.number,),
              TextFormField(controller: _docksController, decoration: const InputDecoration(labelText: 'Docks'), keyboardType: TextInputType.number,),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'address': _addressController.text,
                    'workers': _workersController.text,
                    'vehicles': _vehiclesController.text,
                    'vehicleCost': _vehicleCostController.text,
                    'serviceCost': _serviceCostController.text,
                    'serviceTime': _serviceTimeController.text,
                    'docks': _docksController.text,
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
