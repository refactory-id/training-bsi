import 'package:flutter/material.dart';
import 'package:flutter_provider/models/city_model.dart';
import 'package:flutter_provider/models/raja_ongkir_model.dart';
import 'package:flutter_provider/providers/delivery_cost_provider.dart';
import 'package:flutter_provider/widgets/button_widget.dart';
import 'package:flutter_provider/widgets/dropdown_item.dart';
import 'package:flutter_provider/widgets/dropdown_widget.dart';
import 'package:flutter_provider/widgets/exception_widget.dart';
import 'package:flutter_provider/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class DeliveryCostPage extends StatelessWidget {
  final int weight;
  final City origin, destination;

  const DeliveryCostPage({Key key, this.origin, this.destination, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 56);

    return Scaffold(
      appBar: AppBar(
        title: Text("Provider in Shipping Charges"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: DeliveryCostProvider.read(context)
            .fetchAllCouriers(origin.id, destination.id, weight),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return ExceptionWidget(message: snapshot.error.toString());

          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingWidget();

          return Consumer<DeliveryCostProvider>(
            builder: (context, provider, _) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                      "Alamat penerima: ${origin.type} ${origin.name}, ${origin.province}"),
                ),
                Icon(
                  Icons.swap_calls,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                      "Alamat pengirim: ${destination.type} ${destination.name}, ${destination.province}"),
                ),
                DropdownWidget<DeliveryCost>(
                    items: provider.couriers
                        .map<DropdownMenuItemWidget<DeliveryCost>>(
                            (courier) => DropdownMenuItemWidget<DeliveryCost>(
                                  text: courier.code.toUpperCase(),
                                  value: courier,
                                  width: width,
                                ))
                        .toList(),
                    value: provider.selectedCourier,
                    onChanged: (courier) => DeliveryCostProvider.read(context)
                        .selectCourier(courier)),
                provider.services.isNotEmpty
                    ? DropdownWidget<Cost>(
                        items: provider.services
                            .map<DropdownMenuItemWidget<Cost>>((item) {
                          final cost = item.cost.first;

                          return DropdownMenuItemWidget(
                              text:
                                  "${item.service}: IDR ${cost.value}, etd: ${cost.etd}",
                              value: item,
                              width: width);
                        }).toList(),
                        value: provider.selectedService,
                        onChanged: (service) =>
                            DeliveryCostProvider.read(context)
                                .selectService(service))
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Service tidak tersedia",
                          style:
                              TextStyle(fontSize: 14, color: Colors.red[900]),
                        ),
                      ),
                if (provider.services.isNotEmpty)
                  ButtonWidget(
                    text:
                        "CHECKOUT IDR ${provider.selectedService.cost.first.value}",
                    onClick: () {},
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
