import 'dart:convert';
import 'dart:developer' as console;
import 'dart:io';

import 'package:flutter/foundation.dart'; // For kDebugMode
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:wallet/wallet.dart';
import 'package:web3auth_flutter/output.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';
import 'package:web3dart/web3dart.dart';

Future<TorusUserInfo> getUserInfo() async {
  // Helper function to get RPC URL (from previous response)
  String getLocalRpcUrl() {
    String? rpcUrl = dotenv.env['LOCAL_RPC_URL'];
    if (rpcUrl != null && rpcUrl.isNotEmpty) {
      console.log("Using LOCAL_RPC_URL from .env: $rpcUrl");
      return rpcUrl;
    }

    // Fallback for different platforms if LOCAL_RPC_URL is not set
    if (kDebugMode && Platform.isAndroid) {
      // Use kDebugMode to ensure this only happens in debug builds
      rpcUrl = "http://10.0.2.2:8545/";
    } else {
      rpcUrl =
          "http://127.0.0.1:8545/"; // Works for iOS simulator and web, and physical iOS device if on same network and LOCAL_RPC_URL is not set
    }
    console.log(
      "LOCAL_RPC_URL not set, falling back to platform default: $rpcUrl",
    );
    return rpcUrl;
  }

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

// Helper function to get RPC URL (from previous response)
// Moved this function to be accessible by all relevant functions.
String _getLocalRpcUrl() {
  String? rpcUrl = dotenv.env['LOCAL_RPC_URL'];
  if (rpcUrl != null && rpcUrl.isNotEmpty) {
    console.log("Using LOCAL_RPC_URL from .env: $rpcUrl");
    return rpcUrl;
  }

  // Fallback for different platforms if LOCAL_RPC_URL is not set
  if (kDebugMode && Platform.isAndroid) {
    // Use kDebugMode to ensure this only happens in debug builds
    rpcUrl = "http://10.0.2.2:8545/";
  } else {
    // Works for iOS simulator and web, and physical iOS device if on same network and LOCAL_RPC_URL is not set
    rpcUrl = "http://127.0.0.1:8545/";
  }
  console.log(
    "LOCAL_RPC_URL not set, falling back to platform default: $rpcUrl",
  );
  return rpcUrl;
}

Future<EtherAmount> getBalance() async {
  try {
    console.log("getBalance called:");
    final rpcUrl = _getLocalRpcUrl();
    final client = Web3Client(rpcUrl, Client());
    final address = EthereumAddress.fromHex(
      "0x70997970C51812dc3A010C7d01b50e0d17dc79C8",
    ); // Hardhat Account #1

    // Get the balance in wei
    // NOTE: Actual balance
    final weiBalance = await client.getBalance(address);
    console.log("Balance for $address: $weiBalance");

    // NOTE: Converted balance, not suitable for transection
    final etherValue = weiBalance.getValueInUnit(EtherUnit.ether);
    console.log("Balance in Ether for ${address.with0x}: $etherValue");

    return weiBalance;
  } catch (e) {
    // Handle errors as needed
    console.log("Error getting balance: $e");
    rethrow; // Re-throw the error to be handled by the caller
  } finally {
    // It's good practice to close the client when done
    // However, if this function is called frequently, you might want to manage
    // the client lifecycle differently (e.g., a singleton Web3Client).
    // For now, let's assume it's okay to create and dispose per call.
    // client.dispose(); // Client is not in scope here, need to declare it outside try-catch
  }
}

// TODO: Testing txn flow
Future<String> sendATransaction() async {
  // Hardhat test account #1 private key (sender)
  // Private Key: 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d
  // 0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6
  final String privateKey =
      "0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6";
  final rpcUrl = _getLocalRpcUrl();

  final client = Web3Client(rpcUrl, Client());
  final credentials = EthPrivateKey.fromHex(privateKey);
  final senderAddress = credentials.address;

  // Contract details
  // This is the address of your deployed contract on Hardhat.
  // Make sure this matches the address where your contract is deployed.
  final EthereumAddress contractAddress = EthereumAddress.fromHex(
    '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512',
  ); // From user's context
  console.log("Attempting to call contract at: ${contractAddress.with0x}");

  try {
    // Load the contract ABI from the JSON asset
    final String abiString = await rootBundle.loadString(
      'lib/core/constants/megalodonAuctionContractAbi.json',
    );
    // console.log("ABI String: $abiString");
    final contractAbi = ContractAbi.fromJson(abiString, 'MegalodonAuction');
    final contract = DeployedContract(contractAbi, contractAddress);
    final startAuctionFunction = contract.function('startAuction');

    // Prepare arguments for the startAuction function
    final EthereumAddress artistAddress = EthereumAddress.fromHex(
      '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC',
    ); // Hardhat Account #2
    const String ipfsURI = "ipfs://QmVgB3Yg4f5D6h7j8k9l0m1n2o3p4q5r6s7t8u9v0w";
    final BigInt biddingDuration = BigInt.from(3600); // 1 hour in seconds

    // The contract requires msg.value > 0. Let's send 0.01 ETH.
    final EtherAmount valueToSend = EtherAmount.fromInt(
      EtherUnit.gwei,
      2000000,
    ); // 0.002 ETH

    final receipt = await client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: startAuctionFunction,
        parameters: [artistAddress, ipfsURI, biddingDuration],
        from: senderAddress, // Explicitly set sender
        value: valueToSend, // Value for payable function
      ),
      chainId: 1337, // Hardhat's default chainId
    );
    console.log("Transaction receipt: $receipt");
    return receipt;
  } catch (e) {
    console.log("Error sending transaction: $e");
    return "Error: ${e.toString()}";
  } finally {
    await client.dispose(); // Close the client when done
  }
}

Future<String> sendTransaction() async {
  final String privateKey = await Web3AuthFlutter.getPrivKey();
  // This function seems intended for a real network (Alchemy).
  // Keep its RPC URL as is, separate from local Hardhat.
  String rpcUrl =
      '${dotenv.env['POLYGON_AMOY_ALCHEMY_RPC_URL']}${dotenv.env['ALCHEMY_API_KEY']}';
  console.log("RPC URL for sendTransaction (Alchemy): $rpcUrl");

  final client = Web3Client(rpcUrl, Client());
  final credentials = EthPrivateKey.fromHex(privateKey);
  final address = credentials.address;
  try {
    final receipt = await client.sendTransaction(
      credentials,
      Transaction(
        // This is a simple value transfer, not a contract call
        from: address,
        to: EthereumAddress.fromHex(
          '0xeaA8Af602b2eDE45922818AE5f9f7FdE50cFa1A8',
        ),
        // gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, 100),
        value: EtherAmount.fromInt(EtherUnit.gwei, 5000000), // 0.005 ETH
      ),
      chainId: 11155111, // Sepolia/Amoy chain ID
    );
    console.log(receipt);
    return receipt;
  } catch (e) {
    return e.toString();
  } finally {
    await client.dispose();
  }
}
