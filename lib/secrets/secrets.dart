class Config {
  static const Map<String, dynamic> firebaseEnviroments = {
    "dev": {
      "apiKey": "AIzaSyCAiIbf8QrkbDwQqYa39N1Xh1tqSQIiBIg",
      "appId": "1:129479836273:ios:eef0fe27bfaeec0107d1d0",
      "messagingSenderId": "129479836273",
      "projectId": "tedalal-dev"
    },
    "stage": {
      "apiKey": "AIzaSyBphEy6Yltq-rR3kxIjmAzsrFQadB4h32Q",
      "appId": "1:265517983656:ios:7a1598ff225adc67f85f9d",
      "messagingSenderId": "265517983656",
      "projectId": "tedalal-staging"
    }
  };

  static const Map<String, dynamic> baseApiUrl = {
    "local": {
      "dev": "tedalal-dev/us-central1/api",
      "stage": "tedalal-staging/us-central1/api",
      "prod": "tedalal-prod/us-central1/api"
    },
    "online": {
      "dev": "https://us-central1-tedalal-dev.cloudfunctions.net/api",
      "stage": "https://us-central1-tedalal-staging.cloudfunctions.net/api",
      "prod": ""
    }
  };
}


// flutter build ios --dart-define=API_MODE=online --dart-define=ENV_MODE=stage --dart-define=EMU_MODE=off