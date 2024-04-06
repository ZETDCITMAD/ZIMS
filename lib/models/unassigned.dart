class UnassignedOrders {
  final String network_SERVICE_NUMBER;
  final String network_SERVICE_SUBTYPE;
  final String situation;
  final String creation_DATE_INC;
  final String reference_ELEMENT_ADDRESS;
  final String voltage_LEVEL;
  final String hood_LABEL_INC;
  final String node_ID_INC;
  final int order_ID;

  UnassignedOrders(
      {this.network_SERVICE_SUBTYPE, 
      this.situation, 
      this.network_SERVICE_NUMBER, 
      this.creation_DATE_INC, 
      this.reference_ELEMENT_ADDRESS,
      this.voltage_LEVEL,
      this.hood_LABEL_INC,
      this.node_ID_INC,
      this.order_ID});

  toOrderList(json) {
    List<UnassignedOrders> orders = [];
    for (var data in json) {
      Map<dynamic, dynamic> order = {
        'network_SERVICE_NUMBER': data['network_SERVICE_NUMBER'],
        'network_SERVICE_SUBTYPE': data['network_SERVICE_SUBTYPE'],
        'situation': data['situation'],
        'creation_DATE_INC': data['creation_DATE_INC'],
        'reference_ELEMENT_ADDRESS': data['reference_ELEMENT_ADDRESS'],
        'voltage_LEVEL': data['voltage_LEVEL'],
        'hood_LABEL_INC': data['hood_LABEL_INC'],
        'node_ID_INC': data['node_ID_INC'],
        'order_ID': data['order_ID']
      };
      orders.add(UnassignedOrders(
        network_SERVICE_NUMBER: order['network_SERVICE_NUMBER'],
        network_SERVICE_SUBTYPE: order['network_SERVICE_SUBTYPE'],
        situation: order['situation'],
        creation_DATE_INC: order['creation_DATE_INC'],
        reference_ELEMENT_ADDRESS: order['reference_ELEMENT_ADDRESS'],
        voltage_LEVEL: order['voltage_LEVEL'],
        hood_LABEL_INC: order['hood_LABEL_INC'],
        node_ID_INC: order['node_ID_INC'],
        order_ID: order['order_ID']
      ));
    }
    return orders;
  }
}
