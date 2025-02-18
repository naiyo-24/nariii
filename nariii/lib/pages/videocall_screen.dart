import 'package:flutter/material.dart';
import 'dart:ui';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _isMuted = false;
  bool _isVideoOff = false;
  final Duration _duration = const Duration(milliseconds: 200);

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool isActive,
    Color? backgroundColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              child: AnimatedContainer(
                duration: _duration,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: backgroundColor?.withOpacity(0.7) ?? 
                         (isActive ? Colors.red.withOpacity(0.7) : Colors.white.withOpacity(0.2)),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isActive ? Colors.white : Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Main video feed
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              image: const DecorationImage(
                image: NetworkImage('https://picsum.photos/1920/1080'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Floating self-view
          Positioned(
            top: 50,
            right: 16,
            child: Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.grey[700],
                  child: const Center(
                    child: Icon(Icons.person, size: 50, color: Colors.white54),
                  ),
                ),
              ),
            ),
          ),

          // Top status bar
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.lock, color: Colors.white, size: 16),
                        SizedBox(width: 5),
                        Text(
                          'End-to-end encrypted',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildControlButton(
                        icon: _isMuted ? Icons.mic_off : Icons.mic,
                        onPressed: () => setState(() => _isMuted = !_isMuted),
                        isActive: _isMuted,
                      ),
                      _buildControlButton(
                        icon: Icons.call_end,
                        onPressed: () => Navigator.pop(context),
                        isActive: true,
                        backgroundColor: Colors.red,
                      ),
                      _buildControlButton(
                        icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
                        onPressed: () => setState(() => _isVideoOff = !_isVideoOff),
                        isActive: _isVideoOff,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}