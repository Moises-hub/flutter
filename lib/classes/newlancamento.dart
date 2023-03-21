class NewLancamento {
  String? idLanca;
  String? idCliente;
  String? nome;
  String? idComanda;

  NewLancamento({this.idLanca, this.idCliente, this.nome, this.idComanda});

  NewLancamento.fromJson(Map<String, dynamic> json) {
    idLanca = json['id_lanca'];
    idCliente = json['id_cliente'];
    nome = json['nome'];
    idComanda = json['id_comanda'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_lanca'] = this.idLanca;
    data['id_cliente'] = this.idCliente;
    data['nome'] = this.nome;
    data['id_comanda'] = this.idComanda;
    return data;
  }
}
