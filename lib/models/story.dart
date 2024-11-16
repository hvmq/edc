import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.g.dart';

@JsonSerializable()
class Story {
  final int storyId;
  final String storyType;
  final String? colorCode;
  final String? typeMedia;
  final String? urlMedia;
  final String? content;
  final String status;
  final String timeEnd;

  Story({
    required this.storyId,
    required this.storyType,
    required this.status,
    required this.timeEnd,
    this.colorCode,
    this.typeMedia,
    this.urlMedia,
    this.content,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    final story = _$StoryFromJson(json);

    return story;
  }

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
