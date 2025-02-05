import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/news_item.dart';

class ReelsFeedScreen extends StatefulWidget {
  const ReelsFeedScreen({super.key});

  @override
  State<ReelsFeedScreen> createState() => _ReelsFeedScreenState();
}

class _ReelsFeedScreenState extends State<ReelsFeedScreen> {
  final PageController _pageController = PageController();
  bool _isLoading = true;

  final List<NewsItem> newsItems = [
    NewsItem(
      title: "SpaceX Successfully Launches Starship",
      description: "SpaceX achieves major milestone with successful Starship test flight...",
      imageUrl: "https://picsum.photos/800/800?random=1",
      source: "Space News",
      sourceUrl: "https://www.space.com/news",
    ),
    NewsItem(
      title: "AI Breakthrough in Medical Research",
      description: "New AI model shows promising results in early disease detection...",
      imageUrl: "https://picsum.photos/800/800?random=2",
      source: "Tech Daily",
      sourceUrl: "https://www.techdaily.com/news",
    ),
    // Add more news items as needed
  ];

  Future<void> _navigateToSource(BuildContext context, String sourceUrl) async {
    try {
      final Uri url = Uri.parse(sourceUrl);
      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('News Source'),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                body: WebViewWidget(
                  controller: WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setBackgroundColor(const Color(0x00000000))
                    ..setNavigationDelegate(
                      NavigationDelegate(
                        onNavigationRequest: (NavigationRequest request) {
                          return NavigationDecision.navigate;
                        },
                        onWebResourceError: (WebResourceError error) {
                          debugPrint('WebView error: ${error.description}');
                        },
                      ),
                    )
                    ..loadRequest(url),
                ),
              ),
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error opening WebView: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not load the page: $e'),
          ),
        );
      }
    }
  }

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          final newsItem = newsItems[index];
          return GestureDetector(
            onTap: () => _navigateToSource(context, newsItem.sourceUrl),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.black12 : Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: 'news_$index',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: CachedNetworkImage(
                            imageUrl: newsItem.imageUrl,
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: isDark ? Colors.grey[850] : Colors.grey[200],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                isDark ? Colors.black.withOpacity(0.9) : Colors.black.withOpacity(0.7),
                              ],
                              stops: const [0.2, 1.0],
                            ),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            newsItem.title,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          newsItem.description,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                            letterSpacing: 0.2,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isDark 
                                  ? Colors.grey[800]?.withOpacity(0.8) 
                                  : Colors.grey[200]?.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                newsItem.source,
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.bookmark_outline_rounded),
                              onPressed: () {},
                              color: Theme.of(context).iconTheme.color,
                              iconSize: 24,
                            ),
                            IconButton(
                              icon: const Icon(Icons.share_rounded),
                              onPressed: () {},
                              color: Theme.of(context).iconTheme.color,
                              iconSize: 24,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
