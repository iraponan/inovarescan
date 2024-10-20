import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/models/company.dart';
import 'package:inovarescan/src/models/user.dart';
import 'package:inovarescan/src/repositories/parse_server/company.dart';
import 'package:inovarescan/src/results/company.dart';

class CompanyController extends GetxController {
  final CompanyRepository _companyRepository = CompanyRepository();

  List<Company> companies = [];
  Company company = Company();

  Future<void> gelAllCompanies() async {
    CompanyResult<List<Company>> result = await _companyRepository.getAllCompanies();

    result.when(
      success: (companies) {
        this.companies = companies;
        update();
      },
      error: (message) {
        if (message.isNotEmpty) {
          Utils.showToast(message: message, isError: true);
        }
      },
    );
  }

  Future<bool> getCompanyFromCNPJ(String cnpj) async {
    CompanyResult<Company> result = await _companyRepository.getCompanyFromCNPJ(cnpj);
    result.when(
      success: (company) {
        this.company = company;
      },
      error: (message) {
        if (message.isNotEmpty) {
          Utils.showToast(message: message, isError: true);
        }
      },
    );
    return company.id?.isNotEmpty ?? false;
  }

  Future<bool> getCompanyFromUser(User user) async {
    CompanyResult<Company> result = await _companyRepository.getCompanyFromUser(user);
    result.when(
      success: (company) {
        this.company = company;
      },
      error: (message) {
        if (message.isNotEmpty) {
          Utils.showToast(message: message, isError: true);
        }
      },
    );
    return company.id?.isNotEmpty ?? false;
  }
}
