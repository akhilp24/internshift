var now = new DateTime.now();

String returnGreeting() {
  if (now.hour < 12) {
    return ('Good Morning');
  } else if (now.hour < 17) {
    return ('Good Afternoon');
  } else
    return ('Good Evening');
}
