import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ReelsFeedScreen extends StatefulWidget {
  const ReelsFeedScreen({super.key});

  @override
  State<ReelsFeedScreen> createState() => _ReelsFeedScreenState();
}

class _ReelsFeedScreenState extends State<ReelsFeedScreen> {
  final PageController _pageController = PageController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              // Background Video or Image (Mocking as Image)
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: 'https://picsum.photos/600/1200?random=${index + 1}',
                  fit: BoxFit.cover,
                ),
              ),

              // Top progress indicator (Instagram Style)
              Positioned(
                top: 40,
                left: 16,
                right: 16,
                child: Row(
                  children: List.generate(
                    10,
                    (i) => Expanded(
                      child: Container(
                        height: 3,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: i <= index ? Colors.white : Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Right-side action buttons
              Positioned(
                right: 12,
                bottom: 100,
                child: Column(
                  children: [
                    _buildActionButton(Icons.favorite_border, '24.5K'),
                    const SizedBox(height: 10),
                    _buildActionButton(Icons.chat_bubble_outline, '1.2K'),
                    const SizedBox(height: 10),
                    _buildActionButton(Icons.send, 'Share'),
                    const SizedBox(height: 10),
                    _buildActionButton(Icons.more_horiz, ''),
                  ],
                ),
              ),

              // User profile and text at the bottom
              Positioned(
                left: 16,
                bottom: 48,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Breaking News Headline $index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Swipe up for more news updates',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: CachedNetworkImageProvider(
                            'https://picsum.photos/200?random=${index + 1}',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'News Channel',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Music: Trending News Theme',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: () {},
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
