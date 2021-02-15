class Ticker {
  final String ticker;
  final double valorAtual;
  final double quantidade;
  final String logo;

  Ticker({this.ticker, this.valorAtual, this.quantidade, this.logo});
  factory Ticker.fromJson(Map<String, dynamic> json) {
    return Ticker(
      ticker: json['ticker'],
      valorAtual: json['valorAtual'],
      quantidade: json['quantidade'],
      logo: json['logoUrl'],
    );
  }
}