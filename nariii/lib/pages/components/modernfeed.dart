import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ModernFeed extends StatefulWidget {
  const ModernFeed({super.key});

  @override
  State<ModernFeed> createState() => _ModernFeedState();
}

class _ModernFeedState extends State<ModernFeed> {
  bool _isLoading = true;
  List<String> _loadedImageUrls = [];

  @override
  void initState() {
    super.initState();
    _simulateDataLoading();
  }

  void _simulateDataLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 22, color: Theme.of(context).brightness == Brightness.dark 
            ? Colors.grey[300] 
            : Colors.grey[800]),
        if (label.isNotEmpty) ...[
          const SizedBox(width: 6),
          Text(label, style: TextStyle(
            fontSize: 14, 
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.grey[300] 
                : Colors.grey[800])),
        ],
      ],
    );
  }

  Widget _buildStoryCircle(int index, bool isAdd) {
    if (isAdd) {
      return _buildAddStoryCircle();
    }

    final imageUrl = 'https://picsum.photos/200/200?random=${index + 40}';
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Skeletonizer(
        enabled: _isLoading,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.pink.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'User $index',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.grey[300] 
                    : Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddStoryCircle() {
    // Keep add story circle static as it doesn't depend on network
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Theme.of(context).brightness == Brightness.dark 
                ? Colors.grey[800] 
                : Colors.grey[100],
            child: Icon(
              Icons.add, 
              size: 30, 
              color: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.grey[300] 
                  : Colors.grey[800]
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add Story',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.grey[300] 
                  : Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, int adjustedIndex) {
    final postImageUrl = 'https://picsum.photos/600/400?random=${adjustedIndex + 20}';
    final avatarImageUrl = 'https://picsum.photos/200/200?random=${adjustedIndex + 10}';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      elevation: 0.5,
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.grey[900] 
          : Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header with Skeletonizer for network content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Skeletonizer(
                  enabled: _isLoading,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.grey[800]! 
                            : Colors.grey[200]!, 
                        width: 2
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: _isLoading 
                      ? CircleAvatar(radius: 24, backgroundColor: Colors.grey[300])
                      : CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(avatarImageUrl),
                        ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User ${adjustedIndex + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '📍 Location • ${adjustedIndex + 1}h ago',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark 
                              ? Colors.grey[500] 
                              : Colors.grey[500],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                // Keep static elements unchanged
                IconButton(
                  icon: Icon(Icons.more_horiz_rounded, color: Colors.grey[400]),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Post Image with Skeletonizer
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Stack(
              children: [
                if (_isLoading)
                  Skeletonizer(
                    enabled: true,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                if (!_isLoading)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      postImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // Keep static elements unchanged
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                _buildActionButton(Icons.favorite_outline, '${adjustedIndex + 100}'),
                const SizedBox(width: 20),
                _buildActionButton(Icons.chat_bubble_outline_rounded, '${adjustedIndex + 20}'),
                const SizedBox(width: 20),
                _buildActionButton(Icons.send_rounded, ''),
                const Spacer(),
                Icon(Icons.bookmark_outline_rounded, color: Colors.grey[400]),
              ],
            ),
          ),

          // Caption
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark 
                      ? Colors.grey[300] 
                      : Colors.grey[800], 
                  fontSize: 15
                ),
                children: [
                  TextSpan(
                    text: 'User ${adjustedIndex + 1} ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const TextSpan(
                    text: '✨ This is a modern and sleek caption with stylish hashtags! ',
                  ),
                  TextSpan(
                    text: '#sleek #modern #design',
                    style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 11, // increased by 1 to accommodate stories
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              height: 115,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 8,
                itemBuilder: (context, storyIndex) {
                  return _buildStoryCircle(storyIndex, storyIndex == 0);
                },
              ),
            );
          }
          // Adjust index for the remaining content
          final adjustedIndex = index - 1;
          return _buildPostCard(context, adjustedIndex);
        },
      ),
    );
  }
}
