const Map<String, dynamic> authJson = {
  'grant_type': 'password',
  'client_id':
      '3MVG9QBLg8QGkFeo1WCfSyKAD0j71Umehp1aMtq2VxvPYez7qeN_nFLzNbRXe1h8lgxVkmHEaeFauNWgETWPX',
  'client_secret':
      '2159263A794A3F467C53D9CD88FBC62C94D8EA2FE1BE4580E2D34F6A4ADDB6F6',
  'username': 'customerconnect@guitarcenter.com.tracuat',
  'password': 'm0bileus3r2462YeTkhijiK2V4Tphw1B79mRo',
};

Map<String, String> authHeaders = {
  "Content-Type": "application/x-www-form-urlencoded"
};

const String authURL = '/services/oauth2/token';

const String kRubik = 'Rubik';

const String kAccessTokenKey = 'access_token';