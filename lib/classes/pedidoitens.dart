class PedidosItens {
  String? lancamento;
  String? codBarras;
  String? classificacao;
  String? descricao;
  String? qnt;
  String? total;

  PedidosItens(
      {this.lancamento,
        this.codBarras,
        this.classificacao,
        this.descricao,
        this.qnt,
        this.total});

  PedidosItens.fromJson(Map<String, dynamic> json) {
    lancamento = json['lancamento'];
    codBarras = json['cod_barras'];
    classificacao = json['classificacao'];
    descricao = json['descricao'];
    qnt = json['qnt'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lancamento'] = this.lancamento;
    data['cod_barras'] = this.codBarras;
    data['classificacao'] = this.classificacao;
    data['descricao'] = this.descricao;
    data['qnt'] = this.qnt;
    data['total'] = this.total;
    return data;
  }
}
