import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:whats_app/registration/screens/barrel_widgets.dart';


class Countries extends StatefulWidget {
  const Countries({Key? key}) : super(key: key);

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  @override
  void initState() {
    super.initState();
    filteredCountries = countries;
    searchController.addListener(searchCountry);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.chooseTheCountry,
            filled: false,
            fillColor: Colors.white,
          ),
        ),
        Expanded(
          child: SizedBox(
            width: 400,
            child: ListView.separated(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: filteredCountries.length,
              separatorBuilder: (_, __) => const Divider(color: Colors.grey),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            Constants.assetForFlagImage(
                              filteredCountries[index].code.toLowerCase(),
                            ),
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            filteredCountries[index].name,
                            softWrap: true,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            '+' + filteredCountries[index].dialCode,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      ],
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(onTap: () => onTapElement(index)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  final searchController = TextEditingController();

  var filteredCountries = <Country>[];

  static const countries = ListCountry.countries;

  void searchCountry() {
    var query = searchController.text;
    if (query.isNotEmpty) {
      filteredCountries = countries.where((Country country) {
        return country.name.toUpperCase().contains(query.toUpperCase());
      }).toList();
    } else {
      filteredCountries = countries;
    }
    setState(() {});
  }

  void onTapElement(int index) {
    BlocProvider.of<InputPhoneBloc>(context).add(
      CountrySelected(filteredCountries[index]),
    );
    context.router.pop();
  }
}
