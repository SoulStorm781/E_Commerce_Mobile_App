class FPricingCalculator {
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCostForLocation(location);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  //----calculate shipping cost
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCostForLocation(location);
    return shippingCost.toStringAsFixed(2);
  }

  //---calculate tax amount

  static String calculateTaxAmount(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    return 0.15;
  }

  static double getShippingCostForLocation(String location) {
    return 8.0;
  }
}
