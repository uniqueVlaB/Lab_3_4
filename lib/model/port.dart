class Port implements Comparable<Port> {
  String name;
  String address;
  int workers;
  int vehicles;
  double vehicleCost;
  double serviceCost;
  double serviceTime;
  int docks;


  Port(this.name,this.address, this.workers, this.vehicles, this.vehicleCost,
      this.serviceCost, this.serviceTime, this.docks);

  Port.defaultVal(): name = "Unknown",
  address = "Unknown",
  workers = 15,
  vehicles = 5,
  vehicleCost = 1,
  serviceCost = 1,
  serviceTime = 1,
  docks = 1;

  Port.copy(Port other)
      : this(other.name, other.address, other.workers, other.vehicles, other.vehicleCost,
      other.serviceCost, other.serviceTime, other.docks);


  double calculateProfit(int ships) {
    double income = ships * serviceCost;
    double salary = workers * 200;
    double depreciation = vehicles * vehicleCost * 0.01;
    double profit = income - salary - depreciation;
    return profit;
  }

  @override
  int compareTo(Port other) {
    if (docks > other.docks) {
      return 1;
    }
    else if (docks < other.docks) {
      return -1;
    }
    else{
      return 0;
    }
  }

  Port operator +(int val){
docks+=val;
vehicles+=5*val;
return this;
}

  bool operator <=(Port other){
    if (docks <= other.docks) return true;
    return false;
  }

  bool operator >=(Port other){
    if (docks >= other.docks) return true;
    return false;
  }

@override
String toString() {
  return "Назва порту: $name\n"
      "Адреса порту: $address\n"
      "Кількість робочих: $workers\n"
      "Кількість одиниць техніки: $vehicles\n"
      "Вартість одної одиниці техніки: $vehicleCost\n"
      "Вартість обслуговування корабля: $serviceCost\n"
      "Час обслуговування корабля: $serviceTime\n"
      "Кількість причалів: $docks\n";
}
}
