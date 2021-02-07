import 'package:flutter/material.dart';
import 'package:xsbg/models/battle_token.dart';
import 'package:dartx/dartx.dart';
import 'package:xsbg/models/battle_token_attribute.dart';
import 'package:xsbg/widgets/icon_search.dart';
import 'package:xsbg/widgets/token_avatar.dart';

class TokenDetail extends StatefulWidget {
  final BattleToken token;
  TokenDetail(this.token);

  @override
  State<StatefulWidget> createState() => _TokenDetailState();
}

class _TokenDetailState extends State<TokenDetail> {
  BattleToken editToken;
  TextEditingController _newAttrNameController = TextEditingController();
  TextEditingController _newAttrValueController = TextEditingController();

  bool editing = false;
  List<BattleTokenAttribute> selectedAttributes = [];

  @override
  void initState() {
    super.initState();
    editToken = BattleToken.fromBattleToken(widget.token);
  }

  Widget _attrValue(BattleTokenAttribute attr) {
    if (editing) {
      return TextField(
        decoration: InputDecoration(
          hintText: attr.value,
        ),
        onChanged: (newValue) {
          setState(() {
            attr.value = newValue;
          });
        },
      );
    }

    return Text(attr.value);
  }

  DataRow _addAttrRow() {
    return DataRow(
      cells: [
        DataCell(TextField(controller: _newAttrNameController)),
        DataCell(TextField(controller: _newAttrValueController)),
      ],
    );
  }

  void _searchIcons() async {
    final route =
        MaterialPageRoute<AvailableIcon>(builder: (_) => IconSearch());
    final selectedIcon = await Navigator.of(context).push(route);
    if (selectedIcon == null) {
      return;
    }
    setState(() {
      editToken.icon = selectedIcon.glyph;
    });
  }

  void _updateName(String name) {
    setState(() {
      editToken.name = name;
    });
  }

  Widget _tokenIcon() {
    final colors = {
      'Red': Colors.red.value,
      'Orange': Colors.orange.value,
      'Yellow': Colors.yellow.value,
      'Green': Colors.green.value,
      'Blue': Colors.blue.value,
      'Indigo': Colors.indigo.value,
      'Purple': Colors.purple.value
    };

    final colorOptions = colors.keys.map(
      (e) => DropdownMenuItem<String>(
        value: colors[e].toRadixString(16),
        child: Row(
          children: [
            Container(
              color: Color(colors[e]),
              width: 16,
              height: 16,
              margin: EdgeInsets.only(right: 5),
            ),
            Text(e)
          ],
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            if (editing) Text('Tap to change icon'),
            GestureDetector(
              onTap: editing ? _searchIcons : null,
              child: TokenAvatar(token: editToken, selected: false),
            ),
            DropdownButton(
              items: colorOptions.toList(),
              value: editToken.hexColor,
              onChanged: !editing
                  ? null
                  : (String newColor) {
                      setState(() {
                        editToken.hexColor = newColor;
                      });
                    },
            ),
          ],
        ),
        if (!editing)
          Text(editToken.name, style: Theme.of(context).textTheme.headline5),
        if (editing)
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: TextField(
                onChanged: _updateName,
                decoration: InputDecoration(hintText: editToken.name),
              ),
            ),
          )
      ],
    );
  }

  bool get hasNewAttr =>
      _newAttrNameController.text.isNotBlank &&
      _newAttrValueController.text.isNotBlank;

  void _assignNewAttr() {
    if (!hasNewAttr) {
      return;
    }
    setState(() {
      final name = _newAttrNameController.text;
      final value = _newAttrValueController.text;
      editToken.attributes.add(
        BattleTokenAttribute(
          name: name,
          value: value,
          timestamp: DateTime.now(),
        ),
      );

      _newAttrValueController.text = '';
      _newAttrNameController.text = '';
    });
  }

  void _cancelEdit() {
    setState(() {
      editToken = BattleToken.fromBattleToken(widget.token);
      editing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final attributes = editToken.attributes.sortedBy((attr) => attr.timestamp);
    final table = DataTable(columns: [
      DataColumn(label: Text('Attr')),
      DataColumn(label: Text('Value')),
    ], rows: [
      ...attributes.map(
        (e) => DataRow(
          selected: selectedAttributes.contains(e),
          onSelectChanged: (selected) {
            setState(() {
              selected
                  ? selectedAttributes.add(e)
                  : selectedAttributes.remove(e);
            });
          },
          cells: [
            DataCell(Text(e.name)),
            DataCell(_attrValue(e)),
          ],
        ),
      ),
      if (editing) _addAttrRow()
    ]);

    final editActions = [
      ElevatedButton(
        onPressed: _cancelEdit,
        child: Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: () {
          _assignNewAttr();
          Navigator.of(context).pop(editToken);
        },
        child: Text('Save'),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(editToken.name),
        actions: editing
            ? editActions
            : [
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        editing = true;
                      });
                    })
              ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _tokenIcon(),
            table,
            TextButton(
              onPressed: editing ? () => _assignNewAttr() : null,
              child: Text('Add New'),
            ),
            TextButton(
              onPressed: selectedAttributes.isEmpty
                  ? null
                  : () {
                      setState(() {
                        editing = true;
                        editToken.attributes.removeWhere(
                          (attr) => selectedAttributes.contains(attr),
                        );
                      });
                    },
              child: Text('Delete Selected'),
            )
          ],
        ),
      ),
    );
  }
}
