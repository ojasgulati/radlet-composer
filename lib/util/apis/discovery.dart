import 'dart:convert';

import './helper.dart' as helper;
import './urls.dart' as urls;
import '../data/Device.dart';

Future<List<Device>> getDiscoveredList([Map<String, String> data = const {}]) {
  return helper.makeGetRequest(urls.DISCOVERY_ENDPOINT, data).then((response) {
    if (response.statusCode != 200) {
      // Server responded with error code
      throw Exception();
    }

    var parsedJson = jsonDecode(response.body);

    List<Device> devices = new List<Device>();
    if (parsedJson["devices"] is List) {
      for (var item in parsedJson["devices"]) {
        devices.add(new Device(item["id"], item["type"], item["title"], item["description"]));
      }
    }

    return devices;
  }).catchError((onError) {
    throw Exception();
  });
}
