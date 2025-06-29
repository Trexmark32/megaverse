# Megaverse App

## Project Overview

Megaverse is a cutting-edge Flutter application designed to be a social platform with a strong emphasis on Web3 and blockchain technology. It allows users to share posts, engage in NFT auctions, and manage their Web3 wallet.

## Features

### Authentication
- Seamless login experience using Web3Auth.
- Supports social logins (Google, Apple, Facebook, Twitter).
- Email/OTP passwordless login.

### Home Feed
- Displays a feed of user-generated posts.
- Designed for continuous scrolling to discover new content.

### NFT Auction Platform
- **Bidding Page:** Lists posts that are trending or highly liked and are available for auction.
- **Business Logic:** Posts automatically transition to auction status (`readyToBid`) based on like thresholds and user monetization settings. Users can then start auctions for these posts.
- **Smart Contracts:** Integrates with custom Solidity smart contracts (`MegalodonAuction.sol` and `MegalodonNFT.sol`) for secure and decentralized bidding, NFT minting, and fund distribution.
- **Auction States:** Posts can be `inPost`, `readyToBid`, `inBidding`, or `postSold`.
- **Auction Tabs:** Separate views for "Ongoing Bids" and "Bidding Complete" (sold NFTs).

### User Profile
- Displays user profile information including profile picture, posts count, followers, and following.
- Resembles a typical social media profile page.

### Wallet
- Provides a view of the user's Web3Auth-generated wallet.
- Displays public key (formatted with ellipses and colored prefix), balance, and owned tokens.

### Post Creation
- Allows users to add new posts to the platform.

## Technical Stack

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** Riverpod
- **Web3 Integration:** `web3auth_flutter`, `web3dart`
- **Networking:** `dio`, `http`
- **Environment Variables:** `flutter_dotenv`
- **Smart Contracts:** Solidity (deployed on Polygon-Amoy)

## Getting Started

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Trexmark32/megaverse.git
    cd megaverse
    ```
2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Environment Setup:**
    - Create a `.env` file in the project root.
    - Add your `WEB3AUTH_CLIENT_ID` (and any other necessary environment variables) to this file.
      ```
      WEB3AUTH_CLIENT_ID="YOUR_WEB3AUTH_CLIENT_ID"
      ```
4.  **Run the Application:**
    ```bash
    flutter run
    ```

## Project Structure

- `lib/core/`: Core functionalities (routing, theme, constants, utilities).
- `lib/features/`: Feature-specific modules (auth, feed, post, profile, settings).
- `lib/models/`: Data models for the application.
- `lib/pages/`: Main application screens.
- `lib/providers/`: Riverpod state management providers.
- `lib/services/`: Services for external interactions (auth, network, web3).
- `lib/widgets/`: Reusable UI components.
- `assets/images/`: Application image assets.

## Smart Contract Details

This application interacts with the following Solidity smart contracts:

- **`MegalodonAuction.sol`:** Manages the decentralized NFT auction process, including starting bids, handling bids, ending auctions, and distributing funds. Hosted on Polygon-Amoy.
- **`MegalodonNFT.sol`:** An ERC-721 compliant NFT contract responsible for minting unique NFT tokens for sold posts. Only the `MegalodonAuction` contract can mint NFTs through this contract.

For more details on the smart contracts, refer to the [megalodon-auction repository](https://github.com/Trexmark32/megalodon-auction).

## Contributing

[Add contributing guidelines here if applicable]

## License

[Add license information here]
