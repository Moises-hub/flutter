class Pedidos {
  String? total;
  String? lancamento;
  String? data;

  Pedidos({this.total, this.lancamento, this.data});

  Pedidos.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    lancamento = json['lancamento'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['lancamento'] = this.lancamento;
    data['data'] = this.data;
    return data;
  }
}
