import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/models/city_model.dart';
import 'package:flutter_provider/models/province_model.dart';
import 'package:flutter_provider/pages/delivery_cost_page.dart';
import 'package:flutter_provider/providers/delivery_provider.dart';
import 'package:flutter_provider/widgets/button_widget.dart';
import 'package:flutter_provider/widgets/dropdown_item.dart';
import 'package:flutter_provider/widgets/dropdown_widget.dart';
import 'package:flutter_provider/widgets/exception_widget.dart';
import 'package:flutter_provider/widgets/loading_widget.dart';
import 'package:flutter_provider/widgets/text_input_widget.dart';
import 'package:provider/provider.dart';

class DeliveryPage extends StatelessWidget {
  final _weightController = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 56);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Provider in Shipping Charges"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: DeliveryProvider.read(context).getAllRegion(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;

            String message = error.toString();

            if (error is DioError) {
              message =
                  error.response.data["rajaongkir"]["status"]["description"];
            }

            return ExceptionWidget(message: message);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          }

          return Consumer<DeliveryProvider>(
            builder: (context, provider, _) {
              final state = provider.state;

              if (state is Error) {
                return ExceptionWidget(message: state.message);
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Text("Pengirim"),
                      ),
                      DropdownWidget<Province>(
                          items: provider.provinces
                              .map<DropdownMenuItemWidget<Province>>(
                                  (province) =>
                                      DropdownMenuItemWidget<Province>(
                                        text: "Provinsi ${province.name}",
                                        value: province,
                                        width: width,
                                      ))
                              .toList(),
                          value: provider.selectedProvince,
                          onChanged: (value) => provider.selectProvince(value)),
                      DropdownWidget<City>(
                        items: provider.cities
                            .map<DropdownMenuItemWidget<City>>(
                                (city) => DropdownMenuItemWidget<City>(
                                      text: "${city.type} ${city.name}",
                                      value: city,
                                      width: width,
                                    ))
                            .toList(),
                        value: provider.selectedCity,
                        onChanged: (value) => provider.selectCity(value),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Text("Penerima"),
                      ),
                      DropdownWidget<Province>(
                          items: provider.destinationProvinces
                              .map<DropdownMenuItemWidget<Province>>(
                                  (province) =>
                                      DropdownMenuItemWidget<Province>(
                                        text: "Provinsi ${province.name}",
                                        value: province,
                                        width: width,
                                      ))
                              .toList(),
                          value: provider.selectedDestinationProvince,
                          onChanged: (value) =>
                              provider.selectDestionationProvince(value)),
                      DropdownWidget<City>(
                        items: provider.destinationCities
                            .map<DropdownMenuItemWidget<City>>(
                                (city) => DropdownMenuItemWidget<City>(
                                      text: "${city.type} ${city.name}",
                                      value: city,
                                      width: width,
                                    ))
                            .toList(),
                        value: provider.selectedDestinationCity,
                        onChanged: (value) =>
                            provider.selectDestionationCity(value),
                      ),
                      TextInputWidget(
                          label: "Berat barang dalam satuan gram",
                          controller: _weightController,
                          inputType: TextInputType.number),
                      (state is Loading)
                          ? Padding(
                              padding: const EdgeInsets.all(16),
                              child: LoadingWidget(),
                            )
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
                                                origin: provider.selectedCity,
                                                destination: provider
                                                    .selectedDestinationCity,
                                                weight: weight,
                                              )));
                                } else {
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          "Berat barang tidak boleh kurang dari 100 gram")));
                                }
                              }),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
