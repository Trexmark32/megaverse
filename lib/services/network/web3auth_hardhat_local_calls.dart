import 'dart:convert';
import 'dart:developer' as console;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:wallet/wallet.dart';
import 'package:web3auth_flutter/output.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';
import 'package:web3dart/web3dart.dart';

Future<TorusUserInfo> getUserInfo() async {
  try {
    TorusUserInfo userInfo = await Web3AuthFlutter.getUserInfo();
    console.log("User info: $userInfo");
    // exp 0
    String js0 = jsonEncode(userInfo); //converts object to json
    console.log("User js0: $js0");
    // exp 1
    String js1 = JsonEncoder.withIndent(
      '',
    ).convert(userInfo); //converts object to json
    console.log("User js1 pptd: $js1");
    //exp2
    String js2 = jsonDecode(js1); //converts json to object
    console.log("User js2: $js2");

    return userInfo;
  } catch (e) {
    console.log("Error fetching user info: $e");
    return Future.error(Exception(e));
  }
}

Future<String> getAddress() async {
  final String privateKey = await Web3AuthFlutter.getPrivKey();
  console.log("Private key: $privateKey");
  if (privateKey.isNotEmpty) {
    final credentials = EthPrivateKey.fromHex(privateKey);
    console.log("credentials: $credentials");
    final address = credentials.address;
    console.log("address: $address");
    console.log("Address eip55With0x: ${address.eip55With0x}");
    return address.eip55With0x;
  } else {
    throw Exception("Private key is empty");
  }
}

Future<EtherAmount> getBalance() async {
  try {
    console.log("getBalance called:");
    // final String privateKey = await Web3AuthFlutter.getPrivKey();
    // console.log("Private key: $privateKey");

    // String rpcUrl =
    //     '${dotenv.env['POLYGON_AMOY_ALCHEMY_RPC_URL']}${dotenv.env['ALCHEMY_API_KEY']}';
    // console.log("rpcUrl: $rpcUrl");

    // Account #1: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 (10000 ETH)
    // Private Key: 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d
    final String privateKey =
        "59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d";
    String rpcUrl = "http://192.168.1.238:8545/";

    final client = Web3Client(rpcUrl, Client());
    // console.log("client: $client");

    final credentials = EthPrivateKey.fromHex(privateKey);
    // console.log("credentials: $credentials");

    final address = credentials.address;

    // Get the balance in wei
    // NOTE: Actual balance
    final weiBalance = await client.getBalance(address);
    console.log("Balance for $address: $weiBalance");

    // NOTE: Converted balance, not suitable for transection
    final etherValue = weiBalance.getValueInUnit(EtherUnit.ether);
    console.log("Balance in Ether: $etherValue");
    getMyBal(client); // to test my acc
    return weiBalance;
  } catch (e) {
    // Handle errors as needed
    console.log("Error getting balance: $e");
    return EtherAmount.zero();
  }
}

Future<String> sendATransaction() async {
  // final String privateKey = await Web3AuthFlutter.getPrivKey();
  //   Account #1: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 (10000 ETH)
  // Private Key: 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d
  final String privateKey =
      "59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d";
  String rpcUrl = "http://127.0.0.1:8545/";
  console.log("rpcUrl: $rpcUrl");
  final client = Web3Client(rpcUrl, Client());
  final credentials = EthPrivateKey.fromHex(privateKey);
  final address = credentials.address;
  try {
    final receipt = await client.sendTransaction(
      credentials,
      Transaction(
        from: address,
        to: EthereumAddress.fromHex(
          '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512', //meg auction local host
        ),
        // gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, 100),
        value: EtherAmount.fromInt(EtherUnit.gwei, 5000000), // 0.005 ETH
        // data: ,
      ),
      chainId: 11155111,
    );
    console.log(receipt);
    // setState(() {
    //   _result = receipt;
    // });
    return receipt;
  } catch (e) {
    // setState(() {
    //   _result = e.toString();
    // });
    return e.toString();
  }
}

Future<String> sendTransaction() async {
  final String privateKey = await Web3AuthFlutter.getPrivKey();
  String rpcUrl =
      '${dotenv.env['POLYGON_AMOY_ALCHEMY_RPC_URL']}${dotenv.env['ALCHEMY_API_KEY']}';
  console.log("rpcUrl: $rpcUrl");
  final client = Web3Client(rpcUrl, Client());
  final credentials = EthPrivateKey.fromHex(privateKey);
  final address = credentials.address;
  try {
    final receipt = await client.sendTransaction(
      credentials,
      Transaction(
        from: address,
        to: EthereumAddress.fromHex(
          '0xeaA8Af602b2eDE45922818AE5f9f7FdE50cFa1A8',
        ),
        // gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, 100),
        value: EtherAmount.fromInt(EtherUnit.gwei, 5000000), // 0.005 ETH
      ),
      chainId: 11155111,
    );
    console.log(receipt);
    // setState(() {
    //   _result = receipt;
    // });
    return receipt;
  } catch (e) {
    // setState(() {
    //   _result = e.toString();
    // });
    return e.toString();
  }
}

getMyBal(Web3Client client) {
  // -------------------------- just testing --------------------------
  // Example wallet address as a string
  // final String walletAddress = "0x4y5934hrfjkdsabfkjbsjkhdf";

  // // Convert to EthereumAddress
  // final EthereumAddress ethAddress = EthereumAddress.fromHex(walletAddress);

  // client
  //     .getBalance(ethAddress)
  //     .then((balance) {
  //       console.log("Balance for $walletAddress: $balance");
  //       final etherValue = balance.getValueInUnit(EtherUnit.ether);
  //       console.log("Balance in Ether: $etherValue");

  //       // Optional: Show in gwei
  //       final gweiValue = balance.getValueInUnit(EtherUnit.gwei);
  //       console.log("Balance in Gwei: $gweiValue");
  //     })
  //     .catchError((error) {
  //       console.log("Error fetching balance: $error");
  //     });
  // -------------------------- end testing --------------------------
}
