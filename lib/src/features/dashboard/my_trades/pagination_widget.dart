import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalItems;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onPageSizeChanged;

  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalItems,
    required this.onPageChanged,
    required this.onPageSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D12), // Dark background
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: page size dropdown and info.
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Show",
                style: TextStyle(color: Color(0xFF666D80), fontSize: 14),
              ),
              const SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF15161E),
                  border: Border.all(color: Color(0xFF1F1F1F)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<int>(
                  value: pageSize,
                  dropdownColor: const Color(0xFF1A1A1A), // Dropdown background
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  underline: Container(), // Remove default underline
                  onChanged: (value) {
                    if (value != null) {
                      onPageSizeChanged(value);
                    }
                  },
                  items: [10, 25, 50, 100]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "from $totalItems trades",
                style: const TextStyle(
                    color: Color(0xFF666D80),
                    fontFamily: 'Inter',
                    fontSize: 14),
              ),
            ],
          ),
          // Right: pagination controls.
          Row(
            children: [
              _paginationButton("<< First", () => onPageChanged(1)),
              _paginationButton("< Prev", () {
                if (currentPage > 1) {
                  onPageChanged(currentPage - 1);
                }
              }),
              // Show up to 4 pages.
              for (int i = 1; i <= totalPages && i <= 4; i++)
                _pageNumber(i, isSelected: i == currentPage),
              if (totalPages > 4)
                const Text(
                  "...",
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
              _paginationButton("Next >", () {
                if (currentPage < totalPages) {
                  onPageChanged(currentPage + 1);
                }
              }),
              _paginationButton("Last >>", () => onPageChanged(totalPages)),
            ],
          )
        ],
      ),
    );
  }

  Widget _paginationButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor:
              const Color(0xFF666D80), // Replaced primary with foregroundColor
          backgroundColor: Colors.transparent, // Transparent fill
          side: const BorderSide(color: Color(0xFF15161E)), // Border color
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, color: Color(0xFF666D80)),
        ),
      ),
    );
  }

  Widget _pageNumber(int number, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor:
              const Color(0xFF666D80), // Replaced primary with foregroundColor
          backgroundColor: Colors.transparent,
          side: const BorderSide(color: Color(0xFF15161E)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => onPageChanged(number),
        child: Text(
          number.toString(),
          style: const TextStyle(fontSize: 14, color: Color(0xFF666D80)),
        ),
      ),
    );
  }
}
