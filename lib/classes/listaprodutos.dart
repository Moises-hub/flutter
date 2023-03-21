class ListaProdutos {
  String? codigoBarra;
  String? descricao;
  String? preco;

  ListaProdutos({this.codigoBarra, this.descricao, this.preco});

  ListaProdutos.fromJson(Map<String, dynamic> json) {
    codigoBarra = json['codigo_barra'];
    descricao = json['descricao'];
    preco = json['preco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo_barra'] = this.codigoBarra;
    data['descricao'] = this.descricao;
    data['preco'] = this.preco;
    return data;
  }
}
