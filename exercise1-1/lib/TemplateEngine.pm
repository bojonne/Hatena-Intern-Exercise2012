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
	my $this = shift;
	if( $_[0] ){
		$this->{title} = $_[0];
	}
	my $title = $this->{title}->{title};
	my $content = shift->{content};
	#print "$title\n";
	#print "$content\n";
	
	#ファイル処理
	open(FILE, "<:utf8",$this->{file}) or die "$!";
	my @newfile =<FILE>;
	foreach my $line (@newfile) {
		$line =~ s/{% title %}/$title/g;
		$line =~ s/{% content %}/$content/g;
	}
	close(FILE);
	return @newfile;
}


1;
