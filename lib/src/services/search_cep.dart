import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:search_cep/search_cep.dart';

mixin SearchCep {
  static Future<ViaCepInfo?> searchCep(String cep) async {
    final searchCep = ViaCepSearchCep();
    final infoCep = await searchCep.searchInfoByCep(cep: cep);
    if (infoCep.isLeft()) {
      Utils.showToast(message: infoCep.fold((e) => e.errorMessage, (data) => ''), isError: true);
    }
    return infoCep.fold((_) => null, (data) => data);
  }
}
