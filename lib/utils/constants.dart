const Map<String, dynamic> authJson = {
  'grant_type': 'password',
  'client_id':
      '3MVG9KI2HHAq33RxCZsmOszHULYFbzfZ5N3n.ZbXHHObojG0a1tIEz7c5k749ZRW5n2xGcGxqy2OYw8zI0VGj',
  'client_secret':
      'E062FCA77D3FE219F8E4AE7A09B74ADEDC45032D2107FC1360DB24EFB693E502',
  'username': 'eaisupport@guitarcenter.com',
  'password': 'T!bC0$6$#3!R0$j6xZ5WbXCZYNJOCFpRfesG3S',
};

Map<String, String> authHeaders = {
  "Content-Type": "application/x-www-form-urlencoded"
};

const String authURL = '/services/oauth2/token';
