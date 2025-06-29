import 'package:megaverse/models/owned_token_model.dart';

class WalletModel {
  final String publicKey;
  final double balance;
  final List<OwnedTokenModel> ownedTokens;

  WalletModel({
    required this.publicKey,
    required this.balance,
    required this.ownedTokens,
  });
}
