import 'package:young_devotionals/utils/category.dart';

Category fromStringToCategory(String category) {
  switch (category) {
    case 'young':
      return Category.young;
    default:
      return Category.none;
  }
}
