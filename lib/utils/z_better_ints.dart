Map<int, String> betterInts(double minValue, double maxValue, String shortUnit) {
  if (minValue >= maxValue) return {};
  double diff = maxValue - minValue;

  int start;
  int step;

  Map<int, String> map = {};

  if (diff <= 10) {
    start = minValue.floor();
    for (int i = 0; i < 5; i++) {
      map[(start + i * 2)] = '${start + i * 2} $shortUnit';
    }
  } else if (diff <= 50) {
    start = ((minValue / 5).ceil()) * 5;
    step = 5;
    for (int i = 0; i < 10 && start + i * step <= maxValue; i++) {
      map[(start + i * step)] = '${start + i * step} $shortUnit';
    }
  } else if (diff <= 150) {
    start = ((minValue / 10).ceil()) * 10;
    step = 10;
    for (int i = 0; i < 10 && start + i * step <= maxValue; i++) {
      map[(start + i * step)] = '${start + i * step} $shortUnit';
    }
  } else {
    start = ((minValue / 50).ceil()) * 50;
    step = 50;
    for (int i = 0; i < 10 && start + i * step <= maxValue; i++) {
      map[(start + i * step)] = '${start + i * step} $shortUnit';
    }
  }
  return map;
}
