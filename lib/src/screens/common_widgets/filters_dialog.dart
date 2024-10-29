import 'package:brasil_fields/brasil_fields.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';
import 'package:inovarescan/src/screens/common_widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

class FiltersDialog<T> extends StatefulWidget {
  const FiltersDialog({
    super.key,
    required this.controller,
    this.isOrder = false,
  });

  final T controller;
  final bool isOrder;

  @override
  State<FiltersDialog> createState() => _FiltersDialogState();
}

class _FiltersDialogState extends State<FiltersDialog> {
  final dataIniController = TextEditingController();
  final dataEndController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dataIniController.text = DateFormat('dd/MM/yyyy').format(widget.controller.dateIni);
    dataEndController.text = DateFormat('dd/MM/yyyy').format(widget.controller.dateEnd);

    return Dialog(
      insetPadding: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Período de Analise Atual',
              style: TextStyle(
                fontSize: 24,
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
                    groupValue: widget.controller.typeData,
                    activeColor: CustomColors.customSwathColor,
                    onChanged: (v) {
                      setState(() {
                        widget.controller.typeData = v ?? widget.controller.typeData;
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
                widget.controller.dateIni = dates.first;
                widget.controller.dateEnd = dates.last;
                dataIniController.text = DateFormat('dd/MM/yyyy').format(widget.controller.dateIni);
                dataEndController.text = DateFormat('dd/MM/yyyy').format(widget.controller.dateEnd);
              },
              value: [widget.controller.dateIni, widget.controller.dateEnd],
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
                      Get.back();
                      widget.controller.refreshData();
                    },
                    child: Text('Aplicar'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}