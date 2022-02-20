class Environments {
  static const String PRODUCTION = 'https://hapi-note-api.herokuapp.com';
  static const String DEV = 'https://hapi-note-api.herokuapp.com';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.DEV;
  static const List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.DEV,
      'url': 'https://hapi-note-api.herokuapp.com/',
    },
    {
      'env': Environments.PRODUCTION,
      'url': 'https://hapi-note-api.herokuapp.com/',
    },
  ];

  static String? getEnvironments() {
    return _availableEnvironments
        .firstWhere(
          (d) => d['env'] == _currentEnvironments,
        )
        .values
        .last
        .toString();
  }
}
