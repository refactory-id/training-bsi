import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/domain/entities/city_entity.dart';
import 'package:flutter_clean_arch/domain/entities/courier_entity.dart';
import 'package:flutter_clean_arch/domain/entities/service_entity.dart';
import 'package:flutter_clean_arch/framework/di/di/app_container.dart';
import 'package:flutter_clean_arch/ui/features/delivery_cost/delivery_cost_controller.dart';
import 'package:flutter_clean_arch/ui/widgets/button_widget.dart';
import 'package:flutter_clean_arch/ui/widgets/dropdown_item.dart';
import 'package:flutter_clean_arch/ui/widgets/dropdown_widget.dart';
import 'package:flutter_clean_arch/ui/widgets/loading_widget.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DeliveryCostPage extends View {
  final int weight;
  final City origin, destination;

  DeliveryCostPage({this.weight, this.origin, this.destination});

  @override
  State<StatefulWidget> createState() => _DeliveryCostPageState(
      weight, origin, destination, AppContainer.injector.get());
}

class _DeliveryCostPageState
    extends ViewState<DeliveryCostPage, DeliveryCostController> {
  final int _weight;
  final City _origin, _destination;
  final DeliveryCostController _controller;

  _DeliveryCostPageState(
      this._weight, this._origin, this._destination, this._controller)
      : super(_controller);

  @override
  void didChangeDependencies() {
    _controller.calculateCost(_origin.id, _destination.id, _weight);

    super.didChangeDependencies();
  }

  Widget get view => Scaffold(
        appBar: AppBar(
          title: Text("Shipping Charges"),
          centerTitle: true,
        ),
        body: ControlledWidgetBuilder<DeliveryCostController>(
          builder: (context, controller) => controller.isLoading
              ? LoadingWidget()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                          "Alamat penerima: ${_origin.type} ${_origin.name}, ${_origin.province}"),
                    ),
                    Icon(
                      Icons.swap_calls,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                          "Alamat pengirim: ${_destination.type} ${_destination.name}, ${_destination.province}"),
                    ),
                    DropdownWidget<Courier>(
                      items: controller.couriers
                          .map<DropdownMenuItemWidget<Courier>>(
                              (courier) => DropdownMenuItemWidget<Courier>(
                                    text: courier.code.toUpperCase(),
                                    value: courier,
                                    context: context,
                                  ))
                          .toList(),
                      value: controller.selectedCourier,
                      onChanged: (courier) => controller.selectCourier(courier),
                    ),
                    controller.services.isNotEmpty
                        ? DropdownWidget<Service>(
                            items: controller.services
                                .map<DropdownMenuItemWidget<Service>>((item) {
                              final cost = item.costs.first;

                              return DropdownMenuItemWidget(
                                  text:
                                      "${item.service}: IDR ${cost.value}, etd: ${cost.etd}",
                                  value: item,
                                  context: context);
                            }).toList(),
                            value: controller.selectedService,
                            onChanged: (service) =>
                                controller.selectService(service),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Service tidak tersedia",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.red[900]),
                            ),
                          ),
                    if (controller.services.isNotEmpty)
                      ButtonWidget(
                        text:
                            "CHECKOUT IDR ${controller.selectedService.costs.first.value}",
                        onClick: () {},
                      ),
                  ],
                ),
        ),
      );
}
