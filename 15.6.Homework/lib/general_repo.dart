abstract class GeneralRepo {
  static final List<String> data = [];

  String get repoName;

  Future<String> fetchCatFact();
}
