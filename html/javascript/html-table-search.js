/**
	**options to have following keys:
		**searchText: this should hold the value of search text
		**searchPlaceHolder: this should hold the value of search input box placeholder
		
	Customized by Ian Leslie 2016/08/25
	I removed the code that created the search input and instead found the parent's parent 
	child with the class 'search_bar'.  This way the input can be in place right from the 
	beginning and the sticky table header code can find the location of the table header.
	
	Sample html:
	<div class="search_bar">
		<input type="text" placeholder="search" id="searchinput" />
		<a class="searchcancel" id="searchcancel"></a>
	</div>

	Also customized to search for all words in the search bar instead of the exact phrase 
	(or a custom regex). Using the regex pattern for a search bar entry of "word1 word2":
	(?=[\s\S]*word1[\s\S]*)(?=[\s\S]*word2[\s\S]*).+
	
**/
(function($){
	var caseSensitive;
	var tableObj;
	
    $('#searchcancel').click(function()  {
    	  inputText = $('input[type="text"]#searchinput');
    	  inputText.val('');
    	  $.fn.performSearch(inputText);
    	  inputText.focus();
    });
    
    $('#searchgo').click(function()  {
    	inputText = $('input[type="text"]#searchinput');
  	  	$.fn.performSearch(inputText);
  	  	inputText.focus();
    });
  
    $.fn.performSearch = function(inputText) {
		searchFieldVal = inputText.val();
		var searchPatternStr = "";
		var words = searchFieldVal.split(" ");
		if (words.length > 0)  {
			var foundAWord = false;
			for (var index = 0; index < words.length; index++) {
				if (words[index].length > 0  &&  words[index] != " ")  {
					searchPatternStr += "(?=[\\s\\S]*" + words[index] + "[\\s\\S]*)";
					foundAWord = true;
				}
			}
			if (foundAWord)  {
				searchPatternStr += ".+";
			}
		}
		pattern = (caseSensitive)?RegExp(searchPatternStr):RegExp(searchPatternStr, 'i');
		tableObj.find('tbody tr').hide().each(function(){
			if(pattern.test($(this).html())){
				$(this).show();
			}
		});
		
		if (typeof updateRowCount === "function") {
			//  Call the custom provided update method that allows customising the text
			updateRowCount ();
		}  else  {
			//  Use the default text
			$("#rowCount").text(($('tr:visible').length - 2) + " Rows");
		}
    }

	$.fn.tableSearch = function(options){
		if(!$(this).is('table')){
			return;
		}
		
		tableObj = $(this);
			searchText = (options.searchText)?options.searchText:'Search: ';
			searchPlaceHolder = (options.searchPlaceHolder)?options.searchPlaceHolder:'';
			inputObj = $(this).parent().parent().find('.search_bar').find('input');
			caseSensitive = (options.caseSensitive===true)?true:false;
			searchFieldVal = '';
			pattern = '';
		inputObj.off('keyup').on('keyup', function(e) {
			if(e.keyCode == 13) {
				$.fn.performSearch($(this));
			}  else if (e.keyCode == 27) {
				$(this).val('');
				$.fn.performSearch($(this));
			}
		});
		return tableObj;
	}
}(jQuery));
