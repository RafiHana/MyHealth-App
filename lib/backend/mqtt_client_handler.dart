import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttClientHandler {
  MqttServerClient? client;
  String broker;
  int port = 1883;
  String clientId = 'flutter_client';
  String temperatureTopic = 'suhu';
  String humidityTopic = 'kelembapan';
  String co2Topic = 'karbon_dioksida';
  String smokeTopic = 'asap';

  Function(String)? onTemperatureUpdate;
  Function(String)? onHumidityUpdate;
  Function(String)? onCo2Update;
  Function(String)? onSmokeUpdate;
  Function(bool)? onConnectionStatus;

  MqttClientHandler(this.broker);

  Future<void> connect() async {
    client = MqttServerClient(broker, clientId);
    client!.port = port;
    client!.keepAlivePeriod = 60;
    client!.onDisconnected = onDisconnected;

    final connMess = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client!.connectionMessage = connMess;

    try {
      await client!.connect();
    } catch (e) {
      print('Exception: $e');
      client!.disconnect();
      onConnectionStatus?.call(false);
      return;
    }

    if (client!.connectionStatus!.state == MqttConnectionState.connected) {
      print('Connected to MQTT broker at $broker');
      onConnectionStatus?.call(true);
      subscribeToTopics();
    } else {
      print('Failed to connect');
      onConnectionStatus?.call(false);
    }

    client!.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String payload =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      if (c[0].topic == temperatureTopic) {
        onTemperatureUpdate?.call(payload);
      } else if (c[0].topic == humidityTopic) {
        onHumidityUpdate?.call(payload);
      } else if (c[0].topic == co2Topic) {
        onCo2Update?.call(payload);
      } else if (c[0].topic == smokeTopic) {
        onSmokeUpdate?.call(payload);
      }
    });
  }

  void onDisconnected() {
    print('Disconnected from MQTT broker');
    onConnectionStatus?.call(false);
  }

  void subscribeToTopics() {
    client!.subscribe(temperatureTopic, MqttQos.atLeastOnce);
    client!.subscribe(humidityTopic, MqttQos.atLeastOnce);
    client!.subscribe(co2Topic, MqttQos.atLeastOnce);
    client!.subscribe(smokeTopic, MqttQos.atLeastOnce);
  }

  void disconnect() {
    client?.disconnect();
  }
}