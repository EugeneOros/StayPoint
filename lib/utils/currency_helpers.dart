String formatPrice(int priceInCents, String? currencyCode) {
    final price = (priceInCents / 100).toStringAsFixed(2);
    final parts = price.split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];

    String formatted = '';
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        formatted += '.';
      }
      formatted += integerPart[i];
    }

    final formattedPrice = '$formatted,$decimalPart';
    final symbol = _getCurrencySymbol(currencyCode);
    return '$formattedPrice $symbol';
  }

  String _getCurrencySymbol(String? currencyCode) {
    if (currencyCode == null || currencyCode.isEmpty) {
      return '€';
    }

    switch (currencyCode.toUpperCase()) {
      case 'EUR':
        return '€';
      case 'USD':
        return '\$';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'PLN':
        return 'zł';
      case 'CHF':
        return 'CHF';
      default:
        return currencyCode;
    }
  }