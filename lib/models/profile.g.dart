part of 'profile.dart';

class ProfileAdapter extends TypeAdapter<Profile> {
  @override
  final int typeId = 1;

  @override
  Profile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profile(
      id: fields[0] as String,
      name: fields[1] as String,
      musicDiary: fields[2] as String?,
      currentMood: fields[3] as String,
      lastUpdated: fields[4] as DateTime,
      favoriteGenres: (fields[5] as List).cast<String>(),
      totalSongsPlayed: fields[6] as int,
      totalListeningTime: fields[7] as Duration,
    );
  }

  @override
  void write(BinaryWriter writer, Profile obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.musicDiary)
      ..writeByte(3)
      ..write(obj.currentMood)
      ..writeByte(4)
      ..write(obj.lastUpdated)
      ..writeByte(5)
      ..write(obj.favoriteGenres)
      ..writeByte(6)
      ..write(obj.totalSongsPlayed)
      ..writeByte(7)
      ..write(obj.totalListeningTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
