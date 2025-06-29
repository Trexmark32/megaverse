import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:megaverse/models/owned_token_model.dart';
import 'package:megaverse/models/wallet_model.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  final WalletModel mockWallet = WalletModel(
    publicKey: '0x123abc456def7890123abc456def7890123abc45',
    balance: 10.5,
    ownedTokens: [
      OwnedTokenModel(name: 'MegaCoin', symbol: 'MGC', amount: 1000.0),
      OwnedTokenModel(name: 'Ethereum', symbol: 'ETH', amount: 5.0),
      OwnedTokenModel(name: 'Wrapped BTC', symbol: 'WBTC', amount: 0.1),
    ],
  );

  TextSpan _formatPublicKey(String publicKey) {
    if (publicKey.length <= 20) {
      return TextSpan(
        text: publicKey,
        style: const TextStyle(color: Colors.white, fontSize: 24),
      );
    }
    return TextSpan(
      children: [
        const TextSpan(
          text: '0x',
          style: TextStyle(color: Colors.greenAccent, fontSize: 24),
        ),
        TextSpan(
          text:
              '${publicKey.substring(2, 10)}...${publicKey.substring(publicKey.length - 10)}',
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Public Key:',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: _formatPublicKey(mockWallet.publicKey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.copy,
                      size: 20,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: mockWallet.publicKey),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Public Key copied to clipboard!'),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Balance:',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 4),
              Text(
                '${mockWallet.balance} ETH',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Owned Tokens:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (mockWallet.ownedTokens.isEmpty)
                const Text(
                  'No tokens owned.',
                  style: TextStyle(color: Colors.white70),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mockWallet.ownedTokens.length,
                  itemBuilder: (context, index) {
                    final token = mockWallet.ownedTokens[index];
                    return Card(
                      color: Colors.grey[900],
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        title: Text(
                          token.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          token.symbol,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: Text(
                          token.amount.toStringAsFixed(2),
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
