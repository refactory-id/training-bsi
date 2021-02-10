import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/entities/city_entity.dart';
import 'package:flutter_clean_architecture/domain/entities/province_entity.dart';
import 'package:flutter_clean_architecture/ui/features/delivery/delivery_cubit.dart';
import 'package:flutter_clean_architecture/ui/features/delivery/delivery_state.dart';
import 'package:flutter_clean_architecture/ui/features/delivery_cost/delivery_cost_page.dart';
import 'package:flutter_clean_architecture/ui/widgets/button_widget.dart';
import 'package:flutter_clean_architecture/ui/widgets/dropdown_item.dart';
import 'package:flutter_clean_architecture/ui/widgets/dropdown_widget.dart';
import 'package:flutter_clean_architecture/ui/widgets/exception_widget.dart';
import 'package:flutter_clean_architecture/ui/widgets/loading_widget.dart';
import 'package:flutter_clean_architecture/ui/widgets/text_input_widget.dart';
import 'package:provider/provider.dart';

class DeliveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weightController = TextEditingController(text: "0");
    final width = (MediaQuery.of(context).size.width - 56);

    context.read<DeliveryCubit>().fetchProvinces();

    return Scaffold(
      appBar: AppBar(
        title: Text("Clean Architecture in Shipping Charges"),
        centerTitle: true,
      ),
      body: BlocBuilder<DeliveryCubit, DeliveryState>(
        builder: (context, state) {
          if (state is SuccessState) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text("Alamat Pengirim"),
                ),
                DropdownWidget<Province>(
                    items: state.provinces
                        .map<DropdownMenuItemWidget<Province>>(
                            (province) => DropdownMenuItemWidget<Province>(
                                  text: province.name,
                                  value: province,
                                  width: width,
                                ))
                        .toList(),
                    value: state.selectedProvince,
                    onChanged: (province) =>
                        context.read<DeliveryCubit>().selectProvince(province)),
                DropdownWidget<City>(
                  items: state.cities
                      .map<DropdownMenuItemWidget<City>>(
                          (city) => DropdownMenuItemWidget<City>(
                                text: city.name,
                                value: city,
                                width: width,
                              ))
                      .toList(),
                  value: state.selectedCity,
                  onChanged: (city) =>
                      context.read<DeliveryCubit>().selectCity(city),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Text("Alamat Penerima"),
                ),
                DropdownWidget<Province>(
                    items: state.destinationProvinces
                        .map<DropdownMenuItemWidget<Province>>(
                            (province) => DropdownMenuItemWidget<Province>(
                                  text: province.name,
                                  value: province,
                                  width: width,
                                ))
                        .toList(),
                    value: state.selectedDestinationProvince,
                    onChanged: (province) => context
                        .read<DeliveryCubit>()
                        .selectDestinationProvince(province)),
                DropdownWidget<City>(
                  items: state.destinationCities
                      .map<DropdownMenuItemWidget<City>>(
                          (city) => DropdownMenuItemWidget<City>(
                                text: city.name,
                                value: city,
                                width: width,
                              ))
                      .toList(),
                  value: state.selectedDestinationCity,
                  onChanged: (city) =>
                      context.read<DeliveryCubit>().selectDestinationCity(city),
                ),
                TextInputWidget(
                    label: "Berat barang dalam satuan gram",
                    controller: weightController,
                    inputType: TextInputType.number),
                ButtonWidget(
                    text: "CALCULATE COST",
                    onClick: () {
                      final weight = int.tryParse(weightController.text) ?? 0;

                      if (weight >= 100) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DeliveryCostPage(
                                      origin: state.selectedCity,
                                      destination:
                                          state.selectedDestinationCity,
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
            );
          } else if (state is ErrorState) {
            return ExceptionWidget(
              message: state.message,
            );
          } else {
            return LoadingWidget();
          }
        },
      ),
    );
  }
}
