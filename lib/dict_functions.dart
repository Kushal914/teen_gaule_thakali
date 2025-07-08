Map<String, String> revertDict (Map<String, List<String>> ipDict){
    Map<String, String> opDict = {};
    
    ipDict.forEach((key, values) {
      if (values.isNotEmpty) {
        // Split the first element by semicolon and trim whitespace
        var firstValues = values.first.split(';').map((e) => e.trim()).toList();
        for (var value in firstValues) {
          // Check if the value is a single word (no spaces)
          if (value.isNotEmpty && !value.contains(' ')) {
            // If value already exists as a key, append the new key with a semicolon
            if (opDict.containsKey(value)) {
              opDict[value] = '${opDict[value]}; $key';
            } else {
              opDict[value] = key;
            }
          }
        }
      }
    });
    
    return opDict;
  }

Map<String, dynamic> sortDict(Map<String, dynamic> ipDict) {
  // Create a new map to store the sorted result
  Map<String, dynamic> opDict = {};

  // Get the keys and sort them
  List<String> sortedKeys = ipDict.keys.toList()..sort();

  // Add entries to opDict in sorted key order
  for (String key in sortedKeys) {
    opDict[key] = ipDict[key];
  }

  return opDict;
}