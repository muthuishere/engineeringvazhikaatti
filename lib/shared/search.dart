class Search{

  static bool  hasAnyCommonItems<T>(List<T>? itemsToBeSearched, List<T>? comparableElements) {

    if (validateEmpty(itemsToBeSearched, comparableElements))
      return false;

    for (T element in itemsToBeSearched!) {
      for (T elementToBeCompared in comparableElements!) {
        if (element == elementToBeCompared) return true;
      }
    }
    return false;
  }

  static bool validateEmpty<T>(List<T>? listToBeSearched, List<T>? comparableElements) => null == listToBeSearched || null == comparableElements || comparableElements.length <= 0|| listToBeSearched.length <= 0;
}