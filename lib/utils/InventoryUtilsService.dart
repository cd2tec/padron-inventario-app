class InventoryUtilsService {
  String removeSpecialCharacters(String text) {
    return text
        .replaceAll('ã', 'a')
        .replaceAll('õ', 'o')
        .replaceAll('â', 'a')
        .replaceAll(RegExp(r'[çÇ]'), 'c');
  }

  String formatData(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  Map<String, dynamic> multipleRules(dynamic quantidadeexposicao, Map<String, dynamic> changes, String department) {
    quantidadeexposicao = int.parse(quantidadeexposicao);

    if (quantidadeexposicao != null && quantidadeexposicao > 3) {
      var novaQuantidade = quantidadeexposicao - 1;
      changes['quantidadeexposicao'] = novaQuantidade.toString();
      changes['multiplo'] = '2';
    }else {
      changes['multiplo'] = '1';
    }

    // Se for esmalte
    if (int.parse(department) == 9) {
      // Se for menor ou igual a 5, usamos a regra geral
      if (quantidadeexposicao <= 5) {
        // Não fazemos nada pois já foi alterado acima
      }

      if (quantidadeexposicao == 6) {
        changes['quantidadeexposicao'] = '3';
        changes['multiplo'] = '6';
      }

      // Se está entre 7 e 10,
      if (quantidadeexposicao > 6 && quantidadeexposicao <= 10) {
        changes['quantidadeexposicao'] = '4';
        changes['multiplo'] = '6';
      }

      // Se está entre 11 e 12,
      if (quantidadeexposicao > 10 && quantidadeexposicao <= 12) {
        changes['quantidadeexposicao'] = '7';
        changes['multiplo'] = '6';
      }

      // Se está entre 13 e 18,
      if (quantidadeexposicao > 12 && quantidadeexposicao <= 18) {
        changes['quantidadeexposicao'] = '13';
        changes['multiplo'] = '6';
      }

      // Se está entre 19 e 24,
      if (quantidadeexposicao > 18 && quantidadeexposicao <= 24) {
        changes['quantidadeexposicao'] = '19';
        changes['multiplo'] = '6';
      }

      // Se está entre 25 e 36,
      if (quantidadeexposicao > 24 && quantidadeexposicao <= 36) {
        changes['quantidadeexposicao'] = '29';
        changes['multiplo'] = '6';
      }

    }

    return changes;
  }

}
