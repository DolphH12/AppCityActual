import 'package:flutter/material.dart';
import 'package:muroappmod/theme.dart';
import 'package:muroappmod/utils/utils.dart';

class WrapWidgetDemo extends StatefulWidget {
  //
  final String title = 'INTERESES';

  @override
  State<StatefulWidget> createState() => _WrapWidgetDemoState();
}

class _WrapWidgetDemoState extends State<WrapWidgetDemo> {
  //

  GlobalKey<ScaffoldState> _key;
  List<String> _dynamicChips;
  bool _isSelected;
  List<Company> _companies;
  List<String> _filters;
  int _defaultChoiceIndex;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<ScaffoldState>();
    _isSelected = false;
    _defaultChoiceIndex = 0;
    _filters = <String>[];
    _companies = <Company>[
      const Company('Proyecto de Deporte'),
      const Company('Apple'),
      const Company('Microsoft'),
      const Company('Sony'),
      const Company('Amazon'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              children: companyWidgets.toList(),
            ),
            Text('Selected: ${_filters.join(', ')}'),
            const SizedBox(height: 200,),
            _crearBoton(),
          ],
        ),
      ),
    );
  }


  Iterable<Widget> get companyWidgets sync* {
    for (Company company in _companies) {
      yield Padding(
        padding: const EdgeInsets.all(8.0),
        child: FilterChip(
          backgroundColor: Colors.green,
          checkmarkColor: Colors.red,
          selectedColor: Colors.orange,
          avatar: CircleAvatar(
            child: Text(company.name[0].toUpperCase(), style: const TextStyle(color: Colors.green),),
            backgroundColor: Colors.white,

          ),
          label: Text(company.name),
          selected: _filters.contains(company.name),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(company.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == company.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  Widget chip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(6.0),
    );
  }

  Widget chipForRow(String label, Color color) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Chip(
        labelPadding: EdgeInsets.all(5.0),
        avatar: CircleAvatar(
          backgroundColor: Colors.grey.shade600,
          child: Text(label[0].toUpperCase()),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: color,
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(6.0),
      ),
    );
  }

  Widget _crearBoton() {

    return RaisedButton(
      onPressed: () {
        pasardeVentana(context, 'home', 'wrap');
      },
      color: MyColors.primaryColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Next',
              style: TextStyle(color: Colors.white),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: MyColors.primaryColorLight,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            )
          ],
        ),
      ),
    );

  }
}

class Company {
  const Company(this.name);
  final String name;
}