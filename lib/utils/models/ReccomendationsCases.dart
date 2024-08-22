// recommendation_cases.dart

import 'package:flutter/material.dart';

Map<String, String> getTestResults({
  required String selectedCitology,
  required String selectedHPV,
}) {
  // Defina a lógica para determinar os resultados dos testes
  String citologyResult = selectedCitology; // Você pode modificar isso de acordo com sua lógica
  String hpvResult = selectedHPV; // Você pode modificar isso de acordo com sua lógica

  return {
    'Citology': citologyResult,
    'HPV': hpvResult,
  };
}

List<Map<String, dynamic>> getRecommendations({
  required bool hasPreviousScreeningResult,
  required String selectedCitology,
  required String selectedHPV,
}) {
  // Defina a lógica para determinar as recomendações
  List<Map<String, dynamic>> recommendations = [];

  if (hasPreviousScreeningResult) {
    recommendations.add({
      'title': 'Agendar consulta para acompanhamento após o tratamento.',
      'icon': Icons.event,
    });
  }

  if (selectedHPV == 'Positivo') {
    recommendations.add({
      'title': 'Manter acompanhamento regular para monitoramento de resultados.',
      'icon': Icons.medical_services,
    });
  }

  recommendations.add({
    'title': 'Realizar nova avaliação após um ano.',
    'icon': Icons.calendar_today,
  });

  return recommendations;
}
