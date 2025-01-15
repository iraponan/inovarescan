import 'package:brasil_fields/brasil_fields.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/controllers/filter_data.dart';
import 'package:inovarescan/src/controllers/home.dart';
import 'package:inovarescan/src/controllers/order.dart';
import 'package:inovarescan/src/helpers/mssql/querys_columns.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';
import 'package:inovarescan/src/screens/common_widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

class FiltersDialog extends StatefulWidget {
  const FiltersDialog({
    super.key,
    this.isHome = false,
    this.isOrder = false,
    this.isStoke = false,
  });

  final bool isHome;
  final bool isOrder;
  final bool isStoke;

  @override
  State<FiltersDialog> createState() => _FiltersDialogState();
}

class _FiltersDialogState extends State<FiltersDialog> {
  final dataIniController = TextEditingController();
  final dataEndController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filterDataController = Get.find<FilterDataController>();
    final homeController = Get.find<HomeController>();

    dataIniController.text = DateFormat('dd/MM/yyyy').format(filterDataController.dateIni.value);
    dataEndController.text = DateFormat('dd/MM/yyyy').format(filterDataController.dateEnd.value);

    return Dialog(
      insetPadding: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filtro de Dados',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(() {
                return ExpansionTile(
                  shape: RoundedRectangleBorder(),
                  expansionAnimationStyle: AnimationStyle(
                    curve: Curves.fastEaseInToSlowEaseOut,
                    duration: Duration(seconds: 1),
                  ),
                  title: Text(
                    'Filiais',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: homeController.authController.user.accessCompanies?.map((option) {
                        return CheckboxListTile(
                          title: Text(option[QueryUserAccessCompaniesColumnsNames.nameCompany]),
                          activeColor: CustomColors.customSwathColor,
                          value: filterDataController.companyOptions[option[QueryUserAccessCompaniesColumnsNames.idCompany]],
                          onChanged: (bool? newValue) {
                            filterDataController.companyOptions[option[QueryUserAccessCompaniesColumnsNames.idCompany]] = newValue!;
                          },
                        );
                      }).toList() ??
                      [],
                );
              }),
              Visibility(
                visible: widget.isOrder,
                child: Obx(() {
                  return ExpansionTile(
                    shape: RoundedRectangleBorder(),
                    expansionAnimationStyle: AnimationStyle(
                      curve: Curves.fastEaseInToSlowEaseOut,
                      duration: Duration(seconds: 1),
                    ),
                    title: Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: filterDataController.statusMov.entries.map((entry) {
                      return CheckboxListTile(
                        title: Text(entry.key.isNotEmpty ? entry.key.first : 'Sem título'),
                        value: entry.value,
                        onChanged: (bool? value) {
                          setState(() {
                            filterDataController.statusMov[entry.key] = value!;
                          });
                        },
                      );
                    }).toList(),
                  );
                }),
              ),
              Text(
                'Tipo de Datas',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: VariablesUtils.dateOptions.map((e) {
                  return Flexible(
                    child: RadioListTile(
                      title: Text(
                        VariablesUtils.dateOptions.firstWhere((element) => element == e),
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      value: VariablesUtils.dateOptions.firstWhere((element) => element == e),
                      groupValue: filterDataController.typeData.value,
                      activeColor: CustomColors.customSwathColor,
                      onChanged: (v) {
                        setState(() {
                          filterDataController.typeData.value = v ?? filterDataController.typeData.value;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: 'Data Inicial',
                        prefixIcon: Icons.swipe_right_alt_rounded,
                        isReadOnly: true,
                        textInputFormatter: DataInputFormatter(),
                        controller: dataIniController,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: CustomTextField(
                        labelText: 'Data Final',
                        suffixIcon: Icons.swipe_left_alt_rounded,
                        isReadOnly: true,
                        textInputFormatter: DataInputFormatter(),
                        controller: dataEndController,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.range,
                  animateToDisplayedMonthDate: true,
                  daySplashColor: CustomColors.customContrastColor,
                  selectedDayHighlightColor: CustomColors.customSwathColor,
                  selectedRangeHighlightColor: CustomColors.customSwathColor.shade300,
                  weekdayLabels: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
                  rangeBidirectional: true,
                ),
                onValueChanged: (dates) {
                  filterDataController.dateIni.value = dates.first;
                  filterDataController.dateEnd.value = dates.last;
                  dataIniController.text = DateFormat('dd/MM/yyyy').format(filterDataController.dateIni.value);
                  dataEndController.text = DateFormat('dd/MM/yyyy').format(filterDataController.dateEnd.value);
                },
                value: [
                  filterDataController.dateIni.value,
                  filterDataController.dateEnd.value,
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Cancelar'),
                    ),
                    VerticalDivider(),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.isHome) {
                          Get.find<HomeController>().refreshData();
                        }
                        if (widget.isOrder) {
                          Get.find<OrderController>().refreshData();
                        }
                        Get.back();
                      },
                      child: Text('Aplicar'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
