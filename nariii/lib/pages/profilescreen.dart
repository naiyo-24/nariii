import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nariii/controllers/theme_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final ThemeController themeController = Get.find();

  void _showVideoPlayer(BuildContext context, String videoUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(child: Icon(Icons.play_circle_outline, size: 50, color: Colors.white)),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: IconButton(
                    icon: const Icon(Icons.download, color: Colors.white),
                    onPressed: () {/* Implement download */},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                  _buildSettingsSection('Account', [
                    {'icon': Icons.person_outline, 'title': 'Edit Profile'},
                    {'icon': Icons.lock_outline, 'title': 'Privacy'},
                    {'icon': Icons.notifications_none, 'title': 'Notifications'},
                  ]),
                  _buildSettingsSection('Preferences', [
                    {'icon': Icons.language, 'title': 'Language'},
                    {
                      'icon': Icons.dark_mode_outlined,
                      'title': 'Dark Mode',
                      'trailing': Obx(() => Switch(
                            value: themeController.isDarkMode,
                            onChanged: (value) {
                              themeController.toggleTheme();
                            },
                          )),
                    },
                    {'icon': Icons.security, 'title': 'Security'},
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ),
        ...items.map((item) => ListTile(
              leading: Icon(
                item['icon'] as IconData,
                color: Get.theme.primaryColor,
              ),
              title: Text(
                item['title'] as String,
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.grey[200] : Colors.grey[800],
                ),
              ),
              trailing: item['trailing'] ?? const Icon(Icons.chevron_right),
              onTap: () {},
            )),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, 
            color: Theme.of(context).textTheme.bodyLarge?.color,
            size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, 
              color: Theme.of(context).textTheme.bodyLarge?.color,
              size: 22),
            onPressed: () => _showSettingsDialog(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        children: [
          // Profile Header
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 2
                  ),
                ),
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Theme.of(context).cardColor,
                  backgroundImage: const NetworkImage('https://placeholder.com/150'),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '@johndoe',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Stats Row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('255', 'Posts', Theme.of(context).textTheme.bodyLarge?.color),
                _buildVerticalDivider(Theme.of(context).dividerColor),
                _buildStatItem('12.8K', 'Followers', Theme.of(context).textTheme.bodyLarge?.color),
                _buildVerticalDivider(Theme.of(context).dividerColor),
                _buildStatItem('1.2K', 'Following', Theme.of(context).textTheme.bodyLarge?.color),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Recorded Videos Section
          Text(
            'Recent Recordings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _buildRecordedVideos(context, Theme.of(context).textTheme.bodyLarge?.color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String count, String title, Color? color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: color?.withOpacity(0.6),
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider(Color? color) {
    return Container(
      height: 24,
      width: 1,
      color: color,
    );
  }

  List<Widget> _buildRecordedVideos(BuildContext context, Color? color) {
    final demoVideos = [
      {'thumbnail': 'https://picsum.photos/300/200', 'duration': '12:30', 'title': 'Team Meeting'},
      {'thumbnail': 'https://picsum.photos/300/201', 'duration': '45:15', 'title': 'Presentation'},
      {'thumbnail': 'https://picsum.photos/300/202', 'duration': '28:45', 'title': 'Review'},
    ];

    return demoVideos.map((video) => Container(
      margin: const EdgeInsets.only(right: 16),
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Image.network(
                  video['thumbnail'] as String,
                  height: 100,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      video['duration'] as String,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            video['title'] as String,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    )).toList();
  }
}