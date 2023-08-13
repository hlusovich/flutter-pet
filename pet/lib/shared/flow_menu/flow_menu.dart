import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet/shared/flow_menu/entities/menu_item.entity.dart';
import 'package:pet/shared/flow_menu/enum/flow_delegate_controller.dart';
import 'package:pet/shared/flow_menu/enum/flow_menu.enum.dart';

class FlowMenu extends StatefulWidget {
  const FlowMenu({super.key, required this.direction, required this.menuItems});

  final FlowMenuDirectionsEnum direction;
  final List<FlowMenuItem> menuItems;

  @override
  State<FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu> with TickerProviderStateMixin {
  static const _maxMenuItemWidth = 60.0;

  late final AnimationController animationController;

  bool _isOpened = false;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
  }

  void _toggleMenu() {
    setState(() {
      animationController.status == AnimationStatus.completed
          ? animationController.reverse()
          : animationController.forward();
      _isOpened = !_isOpened;
    });
  }

  double _defineItemWidth(double itemSize) {
    return itemSize > _maxMenuItemWidth ? _maxMenuItemWidth : itemSize;
  }

  Widget flowMenuItem(FlowMenuItem item, List<FlowMenuItem> menuItems) {
    const externalPaddingsWidth = 8 * 2;
    final double buttonDiameter = (MediaQuery.of(context).size.width -
            menuItems.length * 16.0 -
            externalPaddingsWidth) /
        menuItems.length;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: RawMaterialButton(
        fillColor: Colors.red,
        splashColor: Colors.amber[100],
        shape: const CircleBorder(),
        constraints: BoxConstraints.tight(
          Size(
            _defineItemWidth(buttonDiameter),
            _defineItemWidth(buttonDiameter),
          ),
        ),
        onPressed: item.handler,
        child: Icon(
          item.icon,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }

  IconData _getItemForMenuToggle() {
    return widget.direction == FlowMenuDirectionsEnum.left
        ? Icons.arrow_right
        : Icons.arrow_left;
  }

  @override
  Widget build(BuildContext context) {
    final toggleItem = FlowMenuItem(
      icon: _isOpened ? _getItemForMenuToggle() : Icons.settings,
      handler: _toggleMenu,
    );
    final List<FlowMenuItem> menuItems = [...widget.menuItems, toggleItem];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Flow(
        delegate: CustomFlowDelegate(
            animation: animationController, direction: widget.direction),
        children: menuItems
            .map<Widget>(
                (FlowMenuItem menuItem) => flowMenuItem(menuItem, menuItems))
            .toList(),
      ),
    );
  }
}
