use strict;
use warnings;

use Test::More;
use FindBin::libs;


use_ok 'TemplateEngine';

my $template = TemplateEngine->new( file => 'templates/main.html' );
isa_ok $template, 'TemplateEngine';

my $expected = <<'HTML';
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=shift_jis">
    <meta http-equiv="content-style-type" content="text/css">
    <style type="text/css">
    <!--
    body, td ,th{
      background: eee
    }
    
.day {
	width: 60px;	
	height: 60px;	
	text-align: center;
	vertical-align: top;
	font-weight: bold;
	font-size: 15px;
	background: #fff;
}
.today {
	background: #ffb9b9;
}
.week {
	width: 60px;	
	height: 30px;	
	background: #fddebb;
}
.sun {
	color: #ff0000;
}
.sat {
	color: #0000ff;
}
-->
</style>
    <title>カレンダー</title>
  </head>
  <body>
    <!--<p>{% content %}</p>-->
   <div align="center">
    <h2>カレンダー</h2>

    <h4>2012年8月</h4>

    <table border="1" cellspacing="0">
      
    <tr><th class="week sun">日</th>
	<th class="week">月</th>
	<th class="week">火</th>
	<th class="week">水</th>
	<th class="week">木</th>
	<th class="week">金</th>
	<th class="week sat">土</th></tr>
    <tr>
    <td class="day">&nbsp;</td>
	<td class="day">&nbsp;</td>
	<td class="day">&nbsp;</td>
	<td class="day"><span style="color:#000000">1</span></td>
	<td class="day"><span style="color:#000000">2</span></td>
	<td class="day"><span style="color:#000000">3</span></td>
	<td class="day"><span style="color:#0000ff">4</span></td>
    </tr>
    <tr>
    <td class="day"><span style="color:#ff0000">5</span></td>
	<td class="day"><span style="color:#000000">6</span></td>
	<td class="day"><span style="color:#000000">7</span></td>
	<td class="day"><span style="color:#000000">8</span></td>
	<td class="day"><span style="color:#000000">9</span></td>
	<td class="day"><span style="color:#000000">10</span></td>
	<td class="day"><span style="color:#0000ff">11</span></td>
    </tr>
    <tr>
    	<td class="day"><span style="color:#ff0000">12</span></td>
	<td class="day"><span style="color:#000000">13</span></td>
	<td class="day"><span style="color:#000000">14</span></td>
	<td class="day"><span style="color:#000000">15</span></td>
	<td class="day"><span style="color:#000000">16</span></td>
	<td class="day"><span style="color:#000000">17</span></td>
	<td class="day"><span style="color:#0000ff">18</span></td>
    </tr>
    <tr>
    	<td class="day"><span style="color:#ff0000">19</span></td>
	<td class="day"><span style="color:#000000">20</span></td>
	<td class="day"><span style="color:#000000">21</span></td>
	<td class="day"><span style="color:#000000">22</span></td>
	<td class="day"><span style="color:#000000">23</span></td>
	<td class="day"><span style="color:#000000">24</span></td>
	<td class="day"><span style="color:#0000ff">25</span></td>
    </tr>
    <tr>
    	<td class="day"><span style="color:#ff0000">26</span></td>
	<td class="day"><span style="color:#000000">27</span></td>
	<td class="day"><span style="color:#000000">28</span></td>
	<td class="day"><span style="color:#000000">29</span></td>
	<td class="day"><span style="color:#000000">30</span></td>
	<td class="day"><span style="color:#000000">31</span></td>
	<td class="day">&nbsp;</td>
    </tr>
    </table>
  </div>
 </body>
</html>





HTML

cmp_ok $template->render({
    year   => '2012',
    month => '8&<>"',
}), 'eq', $expected; 

done_testing();
