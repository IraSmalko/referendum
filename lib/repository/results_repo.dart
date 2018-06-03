import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart';
import 'package:referendum/data/poll.dart';
import 'package:web3dart/web3dart.dart';

class Repo {
  static final num = 18;
  static final repo = Repo();
  static Web3Client _client;
  static Credentials _cred;

  static final String ADDR = "0x375a03D2b519E9058678732AA184297F9149990d";
  static final String API_URL = "http://192.168.4.51:7545";

  static ContractABI _abi;
  static DeployedContract _contract;

  static int _poll;

  void setData(String privateKeyHex, int poll) {
    var httpClient = new Client();

    _poll = poll;

    _cred = Credentials.fromHexPrivateKey(privateKeyHex);
    _client = new Web3Client(API_URL, httpClient);
  }

  Future getContract() async {
    final abiJson = await rootBundle.loadString('assets/Referendum.json');
    _abi = ContractABI.parseFromJSON(abiJson, "Referendum");
    _contract = new DeployedContract(_abi, ADDR, _client, _cred);
  }

  List<PollItem> getPollList() {
    return [
      PollItem(1, "Super Team", 3.0),
      PollItem(2, "Chemical brothers", 2.0),
      PollItem(3, "4 place", 6.0),
      PollItem(4, "Hrestek", 3.0),
      PollItem(5, "Code Crowd", 1.0),
      PollItem(6, "Team 7", 3.0),
    ];
  }

//  Stream<List<double>> getResults() async* {
////    if (_contract == null) await getContract();
//
//    final random = new Random();
//    final results = <double>[];
//
//    for (var i = 0; i < 5; i++) {
//      results.add(random.nextDouble());
//    }
//
//    yield results;
//
//    for (var i = 0; i < results.length; i++) {
//      results[i] = results[i] + 0.15;
//    }
//
//    yield results;
//  }

  Stream<List<PollItem>> getResults() async* {
//    final random = new Random();
//    final results = <double>[];

    List<PollItem> results = [
      PollItem(1, "Super Team", 3.0),
      PollItem(2, "Chemical brothers", 2.0),
      PollItem(3, "4 place", 6.0),
      PollItem(4, "Hrestek", 3.0),
      PollItem(5, "Code Crowd", 1.0),
      PollItem(6, "Team 7", 3.0),
    ];

    yield results;
  }
}
