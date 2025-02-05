import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nariii/pages/components/calllist.dart';
import 'package:nariii/pages/components/chatlist.dart';
import 'package:nariii/pages/components/explorefeed.dart';
import 'package:nariii/pages/components/modernfeed.dart';
import 'package:nariii/route/routes.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'dart:ui';
import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0; // renamed from _currentIndex
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController(); // new
  bool _isLoading = true; // Simulate loading state

  @override
  void initState() {
    super.initState();
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose(); // new
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Add this line
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        children: [
          const ModernFeed(),
          ReelsFeedScreen(),
          ChatList(),
          CallList(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: DotCurvedBottomNav(
          scrollController: _scrollController,
          hideOnScroll: true,
          indicatorColor: Colors.lightBlueAccent ,
          backgroundColor: Colors.blueGrey,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.ease,
          selectedIndex: _currentPage,
          indicatorSize: 5,
          borderRadius: 25,
          height: 65,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          items: [
            Icon(
              Icons.home_rounded,
              color: _currentPage == 0 
                ? Colors.lightBlueAccent 
                : Colors.white,
              size: 28,
            ),
            Icon(
              Icons.explore_rounded,
              color: _currentPage == 1 
                ? Colors.lightBlueAccent 
                : Colors.white,
              size: 28,
            ),
            Icon(
              Icons.chat_bubble_rounded,
              color: _currentPage == 2 
                ? Colors.lightBlueAccent 
                : Colors.white,
              size: 28,
            ),
            Icon(
              Icons.call_rounded,
              color: _currentPage == 3 
                ? Colors.lightBlueAccent 
                : Colors.white,
              size: 28,
            ),
          ],
        ),
      ),
      // floatingActionButton: _buildCustomFAB(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode 
              ? [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
                ]
              : [Colors.white, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode 
                  ? [Colors.grey.shade800, Colors.grey.shade900]
                  : [Colors.grey.shade100, Colors.grey.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: isDarkMode 
                    ? Colors.black.withOpacity(0.2)
                    : Colors.white,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'NARIII',
              style: GoogleFonts.jaldi(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: isDarkMode 
                ? Colors.grey.shade900.withOpacity(0.5)
                : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: _buildNotificationBadge(context),
          ),
          const SizedBox(width: 12),
          _buildProfileAvatar(context),
        ],
      ),
    );
  }

  Widget _buildNotificationBadge(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded),
          color: Theme.of(context).textTheme.bodyLarge?.color,
          onPressed: () {},
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.redAccent : Colors.red,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isDarkMode ? Colors.redAccent : Colors.red).withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              '3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.profile);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Theme.of(context).cardColor,
          child: Icon(
            Icons.person_outline_rounded,
            color: Theme.of(context).textTheme.bodyLarge?.color,
            size: 24,
          ),
        ),
      ),
    );
  }
}
  