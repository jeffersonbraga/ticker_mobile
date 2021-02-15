import 'dart:ui';

class Ticker {
  final String ticker;
  final double valorAtual;
  final double quantidade;
  final String logo;
  final Color color;

  Ticker({this.ticker, this.valorAtual, this.quantidade, this.logo, this.color});
  factory Ticker.fromJson(Map<String, dynamic> json) {
    return Ticker(
      ticker: json['ticker'],
      valorAtual: json['valorAtual'],
      quantidade: json['quantidade'],
      logo: json['logoUrl'],
      color: json['color'],
    );
  }
}