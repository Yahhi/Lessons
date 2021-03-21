import 'general_repo.dart';

class LocalRepo extends GeneralRepo {
  @override
  Future<String> fetchCatFact() async {
    if (GeneralRepo.data.length < 1) return null;
    GeneralRepo.data.shuffle();
    return GeneralRepo.data.first;
  }

  @override
  String get repoName => 'local';
}
