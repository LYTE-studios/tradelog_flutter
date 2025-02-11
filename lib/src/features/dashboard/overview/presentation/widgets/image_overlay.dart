import 'package:flutter/material.dart';

class ConnectedAccountsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> accounts;
  final VoidCallback onAddAccount;
  final VoidCallback onMoreOptions;

  const ConnectedAccountsWidget({
    super.key,
    required this.accounts,
    required this.onAddAccount,
    required this.onMoreOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (accounts.isEmpty)
          _buildAddButton()
        else ...[
          SizedBox(
            width: 150, // Add a fixed width here
            height: 50, // Fixed height to constrain the Stack
            child: Stack(
              children: [
                for (int i = 0;
                    i < (accounts.length > 3 ? 3 : accounts.length);
                    i++)
                  Positioned(
                    left: i * 30.0, // Adjust overlap spacing
                    child: _buildAccountAvatar(accounts[i]),
                  ),
                Positioned(
                  left: 3 * 30.0, // Adjust overlap spacing
                  child: _buildAddButton(),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAccountAvatar(Map<String, dynamic> account) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundColor: account['backgroundColor'] ?? Colors.grey,
        child: Image.asset(
          account['image'],
          width: 50,
          height: 50,
        ),
      ),
    );
  }

  Widget _buildMoreAccountsCircle(int count) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundColor: Colors.grey[800],
        child: Text('+$count', style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: Color(0xFF272835),
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        onTap: onAddAccount,
        child: const CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(Icons.add, color: Color(0xFF666D80)),
        ),
      ),
    );
  }
}
