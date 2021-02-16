import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_state_management/blocs/delivery/delivery_bloc.dart';
import 'package:flutter_bloc_state_management/blocs/delivery/delivery_state.dart';
import 'package:flutter_bloc_state_management/blocs/delivery/delivery_event.dart';
import 'package:flutter_bloc_state_management/models/city_model.dart';
import 'package:flutter_bloc_state_management/models/province_model.dart';
import 'package:flutter_bloc_state_management/pages/delivery_cost_page.dart';
import 'package:flutter_bloc_state_management/widgets/button_widget.dart';
import 'package:flutter_bloc_state_management/widgets/dropdown_item.dart';
import 'package:flutter_bloc_state_management/widgets/dropdown_widget.dart';
import 'package:flutter_bloc_state_management/widgets/exception_widget.dart';
import 'package:flutter_bloc_state_management/widgets/loading_widget.dart';
import 'package:flutter_bloc_state_management/widgets/text_input_widget.dart';
import 'package:provider/provider.dart';

class DeliveryPage extends StatelessWidget {
  final _weightController = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    context.read<DeliveryBloc>().add(FetchAllProvincesEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text("BLoC in Shipping Charges"),
        centerTitle: true,
      ),
      body: BlocBuilder<DeliveryBloc, DeliveryState>(
        builder: (context, state) {
          if (state is SuccessState) {
            return SingleChildScrollView(
              child: Column(
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
                                    context: context,
                                  ))
                          .toList(),
                      value: state.selectedProvince,
                      onChanged: (province) => context
                          .read<DeliveryBloc>()
                          .add(SelectProvinceEvent(province))),
                  DropdownWidget<City>(
                    items: state.cities
                        .map<DropdownMenuItemWidget<City>>(
                            (city) => DropdownMenuItemWidget<City>(
                                  text: city.name,
                                  value: city,
                                  context: context,
                                ))
                        .toList(),
                    value: state.selectedCity,
                    onChanged: (city) =>
                        context.read<DeliveryBloc>().add(SelectCityEvent(city)),
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
                                    context: context,
                                  ))
                          .toList(),
                      value: state.selectedDestinationProvince,
                      onChanged: (province) => context
                          .read<DeliveryBloc>()
                          .add(SelectDestionationProvinceEvent(province))),
                  DropdownWidget<City>(
                    items: state.destinationCities
                        .map<DropdownMenuItemWidget<City>>(
                            (city) => DropdownMenuItemWidget<City>(
                                  text: city.name,
                                  value: city,
                                  context: context,
                                ))
                        .toList(),
                    value: state.selectedDestinationCity,
                    onChanged: (city) => context
                        .read<DeliveryBloc>()
                        .add(SelectDestionationCityEvent(city)),
                  ),
                  TextInputWidget(
                      label: "Berat barang dalam satuan gram",
                      controller: _weightController,
                      inputType: TextInputType.number),
                  ButtonWidget(
                      text: "CALCULATE COST",
                      onClick: () {
                        final weight =
                            int.tryParse(_weightController.text) ?? 0;

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
              ),
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
