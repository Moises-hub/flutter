class Produto {
  String? idProduto;
  String? descricao;
  String? codigoBarras;
  String? unidade;
  String? classificacao;
  String? impressora;

  Produto(
      {this.idProduto,
        this.descricao,
        this.codigoBarras,
        this.unidade,
        this.classificacao,
        this.impressora});

  Produto.fromJson(Map<String, dynamic> json) {
    idProduto = json['id_produto'];
    descricao = json['descricao'];
    codigoBarras = json['codigo_barras'];
    unidade = json['unidade'];
    classificacao = json['classificacao'];
    impressora = json['impressora'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_produto'] = this.idProduto;
    data['descricao'] = this.descricao;
    data['codigo_barras'] = this.codigoBarras;
    data['unidade'] = this.unidade;
    data['classificacao'] = this.classificacao;
    data['impressora'] = this.impressora;
    return data;
  }
}
