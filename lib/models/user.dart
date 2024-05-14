class User {
  final int _userId;
  final String _fullName;
  final String _role;
  final int _managerId;
  final int _referenceId;
  final double _subRevenue;
  final double _perRevenue;
  final String _token;

  User(
      {userId,
      fullName,
      role,
      managerId,
      referenceId,
      subRevenue,
      perRevenue,
      token})
      : _userId = userId,
        _fullName = fullName,
        _role = role,
        _managerId = managerId,
        _referenceId = referenceId,
        _subRevenue = subRevenue,
        _perRevenue = perRevenue,
        _token = token;

  int get managerId => _managerId;
  int get referenceId => _referenceId;
  double get subRevenue => _subRevenue;
  double get perRevenue => _perRevenue;
  String get fullName => _fullName;
  int get userId => _userId;
  String get token => token;

  static User fromJson(Map<String, dynamic> json) {
    final sub = double.parse(json['SubRevenue']);
    final per = double.parse(json['PerRevenue']);
    String tokenJson = 'citrusaurantiifolia';
    if (json['token'] != '') {
      tokenJson = '';
    }
    return User(
        userId: json['UserID'],
        fullName: json['FullName'],
        role: json['Role'],
        managerId: json['ManagerID'] ?? 0,
        referenceId: json['ReferencesID'] ?? 0,
        subRevenue: sub,
        perRevenue: per,
        token: tokenJson);
  }
}
