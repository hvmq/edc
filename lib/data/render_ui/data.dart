import 'package:flutter/material.dart';

enum MediaType { image, text }

class StoryTemp {
  final MediaType mediaType;
  String? url;
  final double duration;
  final String caption;
  final String date;
  final Color color;

  StoryTemp({
    required this.mediaType,
    required this.caption,
    required this.date,
    this.url,
    this.duration = 5.0,
    this.color = Colors.grey,
  });
}

class UserTemp {
  final String name;
  final String imgUrl;
  final List<StoryTemp> stories;

  const UserTemp({
    required this.name,
    required this.imgUrl,
    required this.stories,
  });
}

final user_temps = [
  UserTemp(
    name: 'Gary',
    imgUrl: 'http://dummyimage.com/170x100.png/ff4444/ffffff',
    stories: _stories,
  ),
  UserTemp(
    name: 'Michael',
    imgUrl: 'http://dummyimage.com/232x100.png/cc0000/ffffff',
    stories: _stories2,
  ),
  UserTemp(
    name: 'John',
    imgUrl: 'http://dummyimage.com/224x100.png/cc0000/ffffff',
    stories: _stories,
  ),
  UserTemp(
    name: 'Emma',
    imgUrl: 'http://dummyimage.com/132x100.png/ff4444/ffffff',
    stories: _stories2,
  ),
];

final _stories = [
  StoryTemp(
    mediaType: MediaType.image,
    url: 'https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif',
    caption: 'Check this out',
    date: '2 hours ago',
  ),
  StoryTemp(
    mediaType: MediaType.text,
    caption: 'What an amazing day it was...',
    color: Colors.indigo,
    date: 'Just now',
  ),
  StoryTemp(
    mediaType: MediaType.image,
    url:
        'https://images.unsplash.com/photo-1604092039551-ddf6d449e29d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80',
    caption: 'Totally Cool',
    date: '2 hours ago',
  ),
  StoryTemp(
    mediaType: MediaType.image,
    url:
        'https://images.unsplash.com/photo-1593642532744-d377ab507dc8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80',
    caption: 'Mindblowing',
    date: '2 hours ago',
  ),
  StoryTemp(
    mediaType: MediaType.image,
    url: 'https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif',
    caption: 'Check this out',
    date: '6 hours ago',
  ),
  StoryTemp(
    mediaType: MediaType.text,
    caption: 'Thank You For Watching...',
    color: Colors.purple,
    date: 'Just now',
  ),
];

final _stories2 = [
  StoryTemp(
    mediaType: MediaType.image,
    url:
        'https://images.unsplash.com/photo-1593642532744-d377ab507dc8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80',
    caption: 'Mindblowing',
    date: '2 hours ago',
  ),
  StoryTemp(
    mediaType: MediaType.text,
    caption: 'What an amazing day it was...',
    color: Colors.indigo,
    date: 'Just now',
  ),
  StoryTemp(
    mediaType: MediaType.image,
    url:
        'https://images.unsplash.com/photo-1604092039551-ddf6d449e29d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80',
    caption: 'Totally Cool',
    date: '2 hours ago',
  ),
  StoryTemp(
    mediaType: MediaType.image,
    url: 'https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif',
    caption: 'Check this out',
    date: '2 hours ago',
  ),
  StoryTemp(
    mediaType: MediaType.text,
    caption: 'Thank You For Watching...',
    color: Colors.purple,
    date: 'Just now',
  ),
];
