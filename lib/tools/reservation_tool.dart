import 'dart:math';
import 'package:agenix/agenix.dart';

class ReservationTool extends Tool {
  ReservationTool()
      : super(
          name: 'reservation_tool',
          description:
              'Use to book a table. Requires {people: int, time: String}.',
          parameters: [
            ParameterSpecification(
              name: 'people',
              type: 'int',
              description: 'Number of guests',
              required: true,
            ),
            ParameterSpecification(
              name: 'time',
              type: 'String',
              description: 'Reservation time, e.g., "8:00 PM"',
              required: true,
            ),
          ],
        );

  @override
  Future<ToolResponse> run(Map<String, dynamic> params) async {
    final people = int.tryParse(params['people']?.toString() ?? '2') ?? 2;
    final time = params['time']?.toString() ?? '8:00 PM';
    final code = "RSV-${1000 + Random().nextInt(9000)}";

    return ToolResponse(
      toolName: name,
      isRequestSuccessful: true,
      message:
          "📅 Table reserved for $people at $time.\nConfirmation Code: $code",
      data: {"code": code, "people": people, "time": time},
      needsFurtherReasoning: false,
    );
  }
}
