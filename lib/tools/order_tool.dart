import 'dart:math';
import 'package:agenix/agenix.dart';

class OrderTool extends Tool {
  OrderTool()
      : super(
          name: 'order_tool',
          description:
              'Use to place an order. Requires {item: String, quantity: int}.',
          parameters: [
            ParameterSpecification(
              name: 'item',
              type: 'String',
              description: 'Dish name to order',
              required: true,
            ),
            ParameterSpecification(
              name: 'quantity',
              type: 'int',
              description: 'Number of portions',
              required: true,
            ),
          ],
        );

  @override
  Future<ToolResponse> run(Map<String, dynamic> params) async {
    final item = params['item']?.toString();
    final qty = int.tryParse(params['quantity']?.toString() ?? '1') ?? 1;

    final orderId = "ORD-${100000 + Random().nextInt(899999)}";
    // In a real app, persist to backend; for demo we just return a confirmation.
    return ToolResponse(
      toolName: name,
      isRequestSuccessful: true,
      message: "✅ Order placed: $qty × $item\nOrder ID: $orderId",
      data: {"orderId": orderId, "item": item, "quantity": qty},
      needsFurtherReasoning: false,
    );
  }
}
