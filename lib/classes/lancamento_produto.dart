class ListaLancamento {
  String? id_produto;
  String? descricao;
  String? codigobarras;
  String? unidade;
  String? classificacao;
  String? qnt;
  String? obs;
  String? impressora;

  ListaLancamento(
      {required this.id_produto, required this.descricao,required this.codigobarras,this.unidade,this.classificacao, this.qnt, this.obs,this.impressora});
}