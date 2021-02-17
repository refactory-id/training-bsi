import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/domain/entities/city_entity.dart';
import 'package:flutter_clean_arch/domain/entities/province_entity.dart';
import 'package:flutter_clean_arch/framework/di/di/app_container.dart';
import 'package:flutter_clean_arch/ui/features/delivery/delivery_controller.dart';
import 'package:flutter_clean_arch/ui/features/delivery_cost/delivery_cost_page.dart';
import 'package:flutter_clean_arch/ui/widgets/button_widget.dart';
import 'package:flutter_clean_arch/ui/widgets/dropdown_item.dart';
import 'package:flutter_clean_arch/ui/widgets/dropdown_widget.dart';
import 'package:flutter_clean_arch/ui/widgets/loading_widget.dart';
import 'package:flutter_clean_arch/ui/widgets/text_input_widget.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DeliveryPage extends View {
  @override
  State<StatefulWidget> createState() =>
      _DeliveryPageState(AppContainer.injector.get());
}

class _DeliveryPageState extends ViewState<DeliveryPage, DeliveryController> {
  final DeliveryController _controller;

  _DeliveryPageState(this._controller) : super(_controller);

  TextEditingController _weightController = TextEditingController(text: "0");

  @override
  void didChangeDependencies() {
    _controller.getProvinces();

    super.didChangeDependencies();
  }

  @override
  Widget get view {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shipping Charges"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text("Alamat Pengirim"),
            ),
            ControlledWidgetBuilder<DeliveryController>(
                builder: (context, controller) => controller.provinces == null
                    ? LoadingWidget(
                        iosStyle: true,
                      )
                    : DropdownWidget<Province>(
                        items: controller.provinces
                            .map<DropdownMenuItemWidget<Province>>(
                                (province) => DropdownMenuItemWidget<Province>(
                                      text: province.name,
                                      value: province,
                                      context: context,
                                    ))
                            .toList(),
                        value: controller.selectedProvince,
                        onChanged: (province) =>
                            controller.selectProvince(province))),
            ControlledWidgetBuilder<DeliveryController>(
              builder: (context, controller) => controller.cities == null
                  ? LoadingWidget(
                      iosStyle: true,
                    )
                  : DropdownWidget<City>(
                      items: controller.cities
                          .map<DropdownMenuItemWidget<City>>(
                              (city) => DropdownMenuItemWidget<City>(
                                    text: city.name,
                                    value: city,
                                    context: context,
                                  ))
                          .toList(),
                      value: controller.selectedCity,
                      onChanged: (city) => controller.selectCity(city),
                    ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text("Alamat Penerima"),
            ),
            ControlledWidgetBuilder<DeliveryController>(
              builder: (context, controller) => controller
                          .destinationProvinces ==
                      null
                  ? LoadingWidget(
                      iosStyle: true,
                    )
                  : DropdownWidget<Province>(
                      items: controller.destinationProvinces
                          .map<DropdownMenuItemWidget<Province>>(
                              (province) => DropdownMenuItemWidget<Province>(
                                    text: province.name,
                                    value: province,
                                    context: context,
                                  ))
                          .toList(),
                      value: controller.selectedDestinationProvince,
                      onChanged: (province) =>
                          controller.selectDestinationProvince(province)),
            ),
            ControlledWidgetBuilder<DeliveryController>(
              builder: (context, controller) =>
                  controller.destinationCities == null
                      ? LoadingWidget(
                          iosStyle: true,
                        )
                      : DropdownWidget<City>(
                          items: controller.destinationCities
                              .map<DropdownMenuItemWidget<City>>(
                                  (city) => DropdownMenuItemWidget<City>(
                                        text: city.name,
                                        value: city,
                                        context: context,
                                      ))
                              .toList(),
                          value: controller.selectedDestinationCity,
                          onChanged: (city) =>
                              controller.selectDestinationCity(city),
                        ),
            ),
            TextInputWidget(
                label: "Berat barang dalam satuan gram",
                controller: _weightController,
                inputType: TextInputType.number),
            ControlledWidgetBuilder<DeliveryController>(
              builder: (context, controller) => controller.isLoading
                  ? LoadingWidget()
                  : ButtonWidget(
                      text: "CALCULATE COST",
                      onClick: () {
                        final weight =
                            int.tryParse(_weightController.text) ?? 0;

                        if (weight >= 100) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DeliveryCostPage(
                                        origin: controller.selectedCity,
                                        destination:
                                            controller.selectedDestinationCity,
                                        weight: weight,
                                      )));
                        } else {
                          Scaffold.of(context).removeCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Berat barang tidak boleh kurang dari 100 gram")));
                        }
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
