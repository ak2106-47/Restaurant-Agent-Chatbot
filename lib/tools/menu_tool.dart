import 'package:agenix/agenix.dart';

class MenuTool extends Tool {
  MenuTool()
      : super(
          name: 'menu_tool',
          description:
              'Use when the user asks about dishes, prices, or ingredients.',
        );

  static const _menu = [
    {"item": "Margherita Pizza", "price": 299, "tags": ["veg", "classic"]},
    {"item": "Penne Alfredo Pasta", "price": 349, "tags": ["veg"]},
    {"item": "Chicken Tikka Pizza", "price": 379, "tags": ["non-veg", "spicy"]},
    {"item": "Greek Salad", "price": 249, "tags": ["veg", "fresh"]},
  ];

  @override
  Future<ToolResponse> run(Map<String, dynamic> params) async {
    final q = (params['query'] as String?)?.toLowerCase() ?? '';
    final filtered = q.isEmpty
        ? _menu
        : _menu.where((m) {
            return (m['item'] as String).toLowerCase().contains(q) ||
                   (m['tags'] as List).any((t) => t.toString().contains(q));
          }).toList();

    final lines = filtered.map((m) => "• ${m['item']} — ₹${m['price']}").join("\n");
    return ToolResponse(
      toolName: name,
      isRequestSuccessful: true,
      message: lines.isEmpty
          ? "No matching items. Try 'pizza', 'pasta', or 'salad'."
          : "Here’s our menu:\n$lines",
      data: {"menu": filtered},
      needsFurtherReasoning: false,
    );
  }
}
