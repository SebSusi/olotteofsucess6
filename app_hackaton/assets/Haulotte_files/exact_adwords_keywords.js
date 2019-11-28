if (typeof(_gat)=="object") {
  var keywordTracker = _gat._getTracker("UA-1");
  keywordTracker._initData();
  
  if (document.location.search.match("gclid")||document.location.search.match("cpc")) {
    var eak_search_query = document.referrer.match(/(\?|&)(q|p|query)=([^&]*)/);
    if (eak_search_query) {
      var eak_keywords = decodeURIComponent(eak_search_query[3]);
      
      // Convert all characters to lower case
      eak_keywords = eak_keywords.toLowerCase();

      // Replace + with space and clear extra whitespace at both ends of the
      // search string
      eak_keywords = eak_keywords.replace(/\+/g,' ').replace(/^\s\s*/, '').replace(/\s\s*$/, '');

      // Set the User defined variable
      keywordTracker._setVar(eak_keywords);
    }
  }
}
