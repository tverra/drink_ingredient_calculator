String generateString(String pattern, int repetitions) {
  final StringBuffer buffer = StringBuffer();

  for (int i = 0; i < repetitions; i++) {
    buffer.write(pattern);
  }
  return buffer.toString();
}
