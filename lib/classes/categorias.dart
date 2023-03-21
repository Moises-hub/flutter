class Categorias {
  String? idCategoria;
  String? classificacao;
  String? descricao;

  Categorias({this.idCategoria, this.classificacao, this.descricao});

  Categorias.fromJson(Map<String, dynamic> json) {
    idCategoria = json['id_categoria'];
    classificacao = json['classificacao'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_categoria'] = this.idCategoria;
    data['classificacao'] = this.classificacao;
    data['descricao'] = this.descricao;
    return data;
  }
}
