package TemplateEngine;
use strict;
use warnings;
use utf8;

# コンストラクタ
sub new{
	#クラス名
	my $this = shift;
	my %arg = @_;
	
	my ($file) = $arg{'file'};
	my $tmpl = {"file" => $file };
	bless $tmpl, $this;
	return $tmpl;	
}

#デストラクタ
sub DESTROY{
    my $this = shift;
}

#renderメソッド
sub render{
	#もう少し機能拡張したら使う
	my $mday;
	#引数から年・月の取得
	my ($mon, $year) = @_;
	my $this = shift;
	#日付数える
	my $day;
	#終わりのフラグ
	my $end;
	#html構造のテンプレ
	my $frame;
	
	#ファイル処理
	open(FILE, $this->{file}) or die "$!";
	my @tmpfile =<FILE>;
	close (FILE);
	# 現在の年月
	($mday, $mon, $year) = (localtime(time))[3 .. 5];
	$mon++;
	$year += 1900;

	#HTMLリファレンス表
	my %table = (
	'&' => '&amp;',
	'<' => '&lt;',
	'>' => '&gt;',
	'"' => '&quot;',
	"'" => '&#39;',
	);
	#正規表現
	my $regex = join '', '([', keys(%table), '])';
	my $key;
	#replace候補のエスケープ
	$mon =~ s/$regex/$table{$key}/g;
	$year =~ s/$regex/$table{$key}/g;
	#1日の日付
	my $week = 3;
	#最終日
	my $last = 31;
	my $flg = 0; 
	my $line;
	#日付設定部分
	my $loop;
	my @newfile;
	foreach $line(@tmpfile) {
		if ($line =~ /<!-- calen_begin -->/) {
			$flg = 1;
			next;
		}
		if ($line =~ /<!-- calen_end -->/) {
			$flg = 0;
			my $k;
			my $i;
			($day, $end) = (0, 0);
			# 第1週から第6週（最大で）分
			foreach $k (1 .. 6) {
				#テンプレート情報
				my $tmp = $loop;	
				last if ($end);
				
				#日から土まで7日分
				foreach my $i (0 .. 6) {
					if (($k == 1 && $i < $week) || $end) {
						$tmp =~ s/!$i!/&nbsp;/;
					} else {
						$day++;
						#ここで具体的にカレンダーの構造を追加
						$tmp =~ s/!$i!/&day($i, $day)/e;
					}
					if ($day >= $last) { $end = 1; }
				}
				push(@newfile, $tmp);
			}
			next;
		}
		if($flg){
			$loop .= $line;
			next;
		}
		# 年月日の置き換え
		$line =~ s/!year!/$year/g;
		$line =~ s/!mon!/$mon/g;
		push (@newfile, $line);
	}
	return @newfile;
}


#-------------------------------------------------
#  カレンダーのhtml構造
#-------------------------------------------------
sub day {
	# 0=日 1=月 ... 6=土 7=祝
	my %col;
	$col{0} = "#ff0000";
	$col{1} = "#000000";
	$col{2} = "#000000";
	$col{3} = "#000000";
	$col{4} = "#000000";
	$col{5} = "#000000";
	$col{6} = "#0000ff";
	my $col = shift;
	my $day = shift;
	return qq|<span style="color:$col{$col}">$day</span>|;
}

1;