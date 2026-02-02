import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../constants.dart';

class AIService {
  static final AIService _instance = AIService._internal();
  factory AIService() => _instance;
  AIService._internal();

  late final GenerativeModel _model;
  late final GenerativeModel _visionModel;

  void init() {
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: googleApiKey);
    _visionModel = GenerativeModel(model: 'gemini-1.5-flash', apiKey: googleApiKey);
  }

  Future<String> generateItinerary({
    required String destination,
    required String budget,
    required String duration,
    required String interests,
  }) async {
    final prompt = '''
      Create a detailed travel itinerary for a trip to $destination.
      Budget: $budget
      Duration: $duration
      Interests: $interests
      
      Please format the response in Markdown with clear daily schedules, recommended places, and estimated costs.
      Use emojis to make it engaging.
    ''';

    final content = [Content.text(prompt)];
    try {
      final response = await _model.generateContent(content);
      return response.text ?? 'Sorry, I could not generate an itinerary at this time.';
    } catch (e) {
      return 'Error: $e. Please check your API Key.';
    }
  }

  Future<String> chat(List<Content> history, String message) async {
    final chat = _model.startChat(history: history);
    try {
      final response = await chat.sendMessage(Content.text(message));
      return response.text ?? 'No response.';
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<String> identifyLandmark(Uint8List imageBytes) async {
    final prompt = 'Identify this landmark or place. Provide a brief description, location, and why it is famous. If it is not a landmark, describe what is in the image.';
    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', imageBytes),
      ])
    ];

    try {
      final response = await _visionModel.generateContent(content);
      return response.text ?? 'Could not identify the image.';
    } catch (e) {
      return 'Error: $e';
    }
  }
}
