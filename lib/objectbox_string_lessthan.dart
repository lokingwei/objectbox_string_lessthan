import 'package:objectbox/objectbox.dart';

@Entity()
class Doc {
  int? id;

  @Index(type: IndexType.value)
  String key;
  Doc({
    required this.key,
  });
}
