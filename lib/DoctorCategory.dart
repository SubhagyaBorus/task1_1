import 'package:hive/hive.dart';

//part 'doctor_category.g.dart'; // Required for code generation

@HiveType(typeId: 0)
class DoctorCategory extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

  DoctorCategory({required this.id, required this.name});

  factory DoctorCategory.fromJson(Map<String, dynamic> json) {
    return DoctorCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}

class DoctorCategoryAdapter extends TypeAdapter<DoctorCategory> {
  @override
  final int typeId = 0;

  @override
  DoctorCategory read(BinaryReader reader) {
    return DoctorCategory(
      id: reader.readInt(),
      name: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, DoctorCategory category) {
    var categories;
    writer.writeInt(categories.id);
    writer.writeString(category.name);
  }

  void saveDataLocally(List<DoctorCategory> categories) async {
    final box = await Hive.openBox<DoctorCategory>('categories');
    await box.clear(); // Clear existing data
    box.addAll(categories);
  }
}
// This is required for code generation

