enum Environments { DEVELOPMENT, UAT, PRO }

class APIConfig {
  static Environments? environmentBuild;

  static String urlsConfig() {
    switch (environmentBuild) {
      case Environments.DEVELOPMENT:
        return "https://express.insakal.com/api/";
        //"https://express.insakal.com/api/";
      case Environments.UAT:
        return "https://api.hoveeattendance.com/api/";
        //"https://express.insakal.com/api/";
      case Environments.PRO:
        return "https://api.hoveeattendance.com/api/";
        //"https://express.insakal.com/api/";
      default:
        return "https://api.hoveeattendance.com/api/";
        //"https://express.insakal.com/api/";
    }
  }

  static String environmentConfig() {
    switch (environmentBuild) {
      case Environments.DEVELOPMENT:
        return "DEVELOPMENT";
      case Environments.UAT:
        return "UAT";
      case Environments.PRO:
        return "PRO";
      default:
        return "UAT";
    }
  }
}