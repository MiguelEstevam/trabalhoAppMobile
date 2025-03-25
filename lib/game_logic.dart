String determineWinner(String user, String app) {
  if (user == app) {
    return "empate";
  }

  if ((user == "pedra" && app == "tesoura") ||
      (user == "tesoura" && app == "papel") ||
      (user == "papel" && app == "pedra")) {
    return "user";
  } else {
    return "app";
  }
}
