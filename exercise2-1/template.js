var Template = function(input) {
    // ‚±‚ÌŠÖ”‚ğÀ‘•‚µ‚Ä‚­‚¾‚³‚¢
    var data = eval(input);
    this.source = data.source;
};

Template.prototype = {
    render: function(variables) {
        // ‚±‚ÌŠÖ”‚ğÀ‘•‚µ‚Ä‚­‚¾‚³‚¢
        var escape = {
			 '&': '&amp',
  			 '<': '&lt',
  			 '>': '&gt',
  			 '"':'&quot',
  			 "'":'&apos' 
        };
        var html = this.source;
        for(key in variables){
        	var keyword = variables[key] ;
            for(ch in escape){
        		keyword = keyword.replace(ch, escape[ch]);
        	}
        	var mark = "{% "+ key + " %}";
        	html = html.replace(mark, keyword);
        }        
        return html;
    }
};