var Template = function(input) {
    // この関数を実装してください
    var data = eval(input);
    this.source = data.source;
};

Template.prototype = {
    render: function(variables) {
        // この関数を実装してください
        var json = eval(variables);
        var title = json.title;
        var content = json.content;
        
        var html = this.source("{% title %}", title);
        html = html.replace("{% content %}", content);
        return html;
    }
};