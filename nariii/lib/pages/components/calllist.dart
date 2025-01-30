import 'package:flutter/material.dart';

class CallList extends StatefulWidget {
  const CallList({super.key});

  @override
  State<CallList> createState() => _CallListState();
}

class _CallListState extends State<CallList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).colorScheme.background
          : Colors.grey[100],
      body: _buildCallsList(),
    );
  }

  Widget _buildCallsList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      itemCount: 10,
      itemBuilder: (context, index) {
        bool isMissedCall = index % 3 == 0;
        bool isVideoCall = index % 2 == 0;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 12),
          child: Material(
            elevation: 0,
            color: isDark ? Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withOpacity(0.3)
                                : Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          'https://picsum.photos/200?random=$index',
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User ${index + 1}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isMissedCall
                                      ? (isDark ? Colors.red.withOpacity(0.2) : Colors.red.withOpacity(0.1))
                                      : (isDark ? Colors.green.withOpacity(0.2) : Colors.green.withOpacity(0.1)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      isMissedCall
                                          ? Icons.call_missed_outgoing
                                          : Icons.call_received,
                                      size: 14,
                                      color: isMissedCall
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      isMissedCall ? "Missed" : "Received",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isMissedCall
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.blue.withOpacity(0.2)
                                : Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            isVideoCall ? Icons.videocam : Icons.call,
                            size: 20,
                            color: isDark ? Colors.blue[400] : Colors.blue[700],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${(index + 1) * 2}m ago",
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
