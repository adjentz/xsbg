import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IconSearchState();
}

class _IconSearchState extends State<IconSearch> {
  List<AvailableIcon> availableIcons = [];
  List<AvailableIcon> filteredIcons = [];

  @override
  void initState() {
    super.initState();
    loadList();
  }

  void loadList() async {
    final jsonText = await rootBundle.loadString('assets/icons.json');
    final Map<String, dynamic> map = json.decode(jsonText);
    availableIcons = map.keys
        .map((e) => AvailableIcon.fromJson(e, map[e]))
        .where((element) => element.styles.contains('solid'))
        .toList();
    setState(() {
      filteredIcons = availableIcons;
    });
  }

  void _narrowOptions(String filter) {
    String normalizedFilter = filter.toUpperCase();
    setState(() {
      if (filter.isEmpty) {
        filteredIcons = availableIcons;
        return;
      }

      filteredIcons = availableIcons
          .where((icon) =>
              icon.name.toUpperCase().contains(normalizedFilter) ||
              icon.searchTerms.any(
                (tag) => tag.toUpperCase().contains(normalizedFilter),
              ))
          .toList();
    });
  }

  void _iconSelected(AvailableIcon icon) {
    Navigator.of(context).pop(icon);
  }

  Widget iconTile(AvailableIcon icon) {
    return ListTile(
      leading:
          FaIcon(IconDataSolid(icon.glyph), color: Colors.black, size: 32.0),
      title: Text(icon?.name),
      subtitle: Text(icon.searchTerms?.join(', ')),
      onTap: () => _iconSelected(icon),
    );
  }

  Widget _body() {
    if (availableIcons == null || availableIcons.isEmpty) {
      return Text('Loading...');
    }

    return Column(
      children: [
        TextField(
          onChanged: _narrowOptions,
          decoration: InputDecoration(
            hintText: 'Search',
            suffixIcon: Icon(Icons.search),
          ),
        ),
        Expanded(
          child: ListView(
            children: filteredIcons.map(iconTile).toList(),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Icon Search'),
        ),
        body: _body());
  }
}

class AvailableIcon {
  String name;
  List<String> searchTerms;
  String unicode;
  List<String> styles;

  AvailableIcon();

  factory AvailableIcon.fromJson(String name, Map<String, dynamic> json) {
    final List<dynamic> searchTerms = json['search']['terms'];
    return AvailableIcon()
      ..name = name
      ..searchTerms = searchTerms.whereType<String>().toList()
      ..unicode = json['unicode']
      ..styles = json['styles'].whereType<String>().toList();
  }

  int get glyph => int.parse(unicode, radix: 16);
}
