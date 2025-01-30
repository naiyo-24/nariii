import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userImage;
  final bool isOnline;

  const ChatScreen({
    required this.userName,
    required this.userImage,
    required this.isOnline,
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    // Add some dummy messages
    _messages.addAll([
      {'message': 'Hey there! 👋', 'isSender': false},
      {'message': 'Hi! How are you?', 'isSender': true},
      {'message': 'I\'m doing great, thanks!', 'isSender': false},
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        toolbarHeight: 65,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, 
            size: 22, 
            color: Theme.of(context).textTheme.bodyLarge?.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.userImage),
                    radius: 20,
                  ),
                  if (widget.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10b981),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call_rounded, 
              color: Theme.of(context).textTheme.bodyLarge?.color),
            iconSize: 26,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call_rounded, color: Color(0xFF475569)),
            iconSize: 22,
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isFirstMessage = index == 0 || 
                    _messages[index - 1]['isSender'] != message['isSender'];
                final isLastMessage = index == _messages.length - 1 || 
                    _messages[index + 1]['isSender'] != message['isSender'];

                return Align(
                  alignment: message['isSender']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: isLastMessage ? 10 : 4,
                      top: isFirstMessage ? 10 : 0,
                      left: message['isSender'] ? 80 : 0,
                      right: message['isSender'] ? 0 : 80,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: message['isSender']
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message['message'],
                      style: TextStyle(
                        color: message['isSender'] 
                          ? Colors.white 
                          : Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  color: const Color(0xFF64748b),
                  iconSize: 24,
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFf1f5f9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF334155),
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Message',
                        hintStyle: TextStyle(
                          color: Color(0xFF94a3b8),
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3b82f6),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3b82f6).withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded),
                    iconSize: 18,
                    color: Colors.white,
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        setState(() {
                          _messages.add({
                            'message': _messageController.text,
                            'isSender': true,
                          });
                          _messageController.clear();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
