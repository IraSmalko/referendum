import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart';
import 'package:referendum/data/poll.dart';
import 'package:web3dart/web3dart.dart';

class Repo {
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

  Future<List<PollItem>> getPollList() async {
    if (_contract == null) {
      final x = await getContract();
    }

    //    final f = _contract.findFunctionsByName("newPoll").first;
//
//    final response = await new Transaction(keys: _cred, maximumGas: 0).prepareForCall(_contract, f, [
//      [0x4707469662031, 0x4707469662032, 0x470746966203],
//      2
//    ]).call(_client);

//    print(response);

//    final acc = await _();
//    final results = <PollItem>[];
//    for (var a in acc) {
//      results.add(PollItem(a.toString()));
//    }
//    return results;

    return [
      PollItem("Helper class which implements 1"),
      PollItem("Helper class which implements 2"),
      PollItem("Helper class which implements 3"),
      PollItem("Helper class which implements 4"),
      PollItem("Helper class which implements 5"),
    ];
  }

  Stream<List<double>> getResults() async* {
//    if (_contract == null) await getContract();

    final random = new Random();
    final results = <double>[];

    for (var i = 0; i < 5; i++) {
      results.add(random.nextDouble());
    }

    yield results;

    for (var i = 0; i < results.length; i++) {
      results[i] = results[i] + 0.15;
    }

    yield results;
  }
}
