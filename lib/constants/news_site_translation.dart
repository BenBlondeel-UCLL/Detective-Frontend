const Map<String, String> biasTranslations = {
  'extreme-right': 'extreem-rechts',
  'right': 'rechts',
  'right-center': 'midden-rechts',
  'center': 'midden',
  'left-center': 'midden-links',
  'left': 'links',
  'extreme-left': 'extreem-links',
  'conspiracy': 'complot',
  'satire': 'satire',
  'pro-science': 'pro-wetenschap',
};

const Map<String, String> factualTranslations = {
  'very high': 'zeer hoog',
  'high': 'hoog',
  'mostly_factual': 'meestal feitelijk',
  'mostly': 'meestal feitelijk',
  'mixed': 'gemengd',
  'low': 'laag',
  'VeryLow': 'zeer laag',
};

const Map<String, String> credibilityTranslations ={
  'high credibility': 'hoge betrouwbaarheid',
  'medium credibility': 'gemiddelde betrouwbaarheid',
  'low credibility': 'lage betrouwbaarheid',
};

String getTranslatedBias(String bias) {
  return biasTranslations[bias] ?? bias;
}

String getTranslatedFactual(String bias) {
  return factualTranslations[bias] ?? bias;
}

String getTranslatedCredibility(String bias) {
  return credibilityTranslations[bias] ?? bias;
}
