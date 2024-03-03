class AppMethods {
  static String getTextReadableDate(DateTime date) {
    const Map<int, String> months = {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "May",
      6: "Jun",
      7: "Jul",
      8: "Aug",
      9: "Sep",
      10: "Oct",
      11: "Nov",
      12: "Dec",
    };
    return "${months[date.month]}  ${date.day}, ${date.year}";
  }
}
