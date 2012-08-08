package TemplateEngine;
use strict;
use warnings;
use utf8;
binmode(STDOUT, ":utf8");

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
	my ($this, $data) = @_;
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
	
	#ファイル処理
	open(FILE, $this->{file}) or die "$!";
	my @newfile =<FILE>;
	
	#リファレンス処理からraplace
	my %content = %$data;
	
	#replace候補のエスケープ
	foreach my $key (keys %content){
		$content{$key} =~ s/$regex/$table{$1}/g;	
	}
		
	#replace
	foreach my $line (@newfile) {
		foreach my $key (keys %content){
			my $lf = "{% ";
			my $rg = " %}";
			my $str = $lf . $key . $rg;
			#print "$str\n";
			
			$line =~ s/$str/$content{$key}/g;
		}
	}
	close(FILE);
	return @newfile;
}


1;