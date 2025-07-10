// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongAdapter extends TypeAdapter<Song> {
  @override
  final int typeId = 0;

  @override
  Song read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Song(
      id: fields[0] as String,
      title: fields[1] as String,
      artist: fields[2] as String,
      album: fields[3] as String,
      albumArtPath: fields[4] as String,
      audioPath: fields[5] as String,
      duration: fields[6] as Duration,
      isFavorite: fields[7] as bool,
      emojiReactions: (fields[8] as List).cast<String>(),
      moodTags: (fields[9] as List).cast<String>(),
      tinyReview: fields[10] as String?,
      lyrics: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Song obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.album)
      ..writeByte(4)
      ..write(obj.albumArtPath)
      ..writeByte(5)
      ..write(obj.audioPath)
      ..writeByte(6)
      ..write(obj.duration)
      ..writeByte(7)
      ..write(obj.isFavorite)
      ..writeByte(8)
      ..write(obj.emojiReactions)
      ..writeByte(9)
      ..write(obj.moodTags)
      ..writeByte(10)
      ..write(obj.tinyReview)
      ..writeByte(11)
      ..write(obj.lyrics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
