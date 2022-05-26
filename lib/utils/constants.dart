const Map<String, dynamic> authJson = {
  'grant_type': 'password',
  'client_id':
      '3MVG9Fy_1ZngbXqNlrXOhqeBwQrrqaj4EhIUP3_y7bEGFXyyBhlfNqG42ij2H8vmp_KoU1roTlPzndiINXRhC',
  'client_secret':
      'FC8D0C7C1289B520E06606FA3A6911CCB78D5D02CB1A7454694AE884B6EF0C8B',
  'username': 'amol.pawar@guitarcenter.com.ap',
  'password': 'Apptware@40',
};

Map<String, String> authHeaders = {
  "Content-Type": "application/x-www-form-urlencoded"
};

const String authURL = '/services/oauth2/token';

const String kRubik = 'Rubik';

const String kAccessTokenKey = 'access_token';