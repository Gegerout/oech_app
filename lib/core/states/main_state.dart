import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../onboarding/data/repository/data_repository.dart';

final mainProvider = FutureProvider((ref) async {
  final data = await DataRepository().getShowed();
  return data;
});
