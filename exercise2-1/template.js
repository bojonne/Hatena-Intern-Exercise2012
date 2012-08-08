var Template = function(input) {
    // ���̊֐����������Ă�������
    var data = eval(input);
    this.source = data.source;
};

Template.prototype = {
    render: function(variables) {
        // ���̊֐����������Ă�������
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