package TemplateEngine;
use strict;
use warnings;
use utf8;
use Carp;
binmode(STDOUT, ":utf8");

# コンストラクタ
sub new{
	#クラス名
	#my $this = shift;
	#my %arg = @_;
	#my ($file) = $arg{'file'};
	#my $tmpl = {"file" => $file };
	#bless $tmpl, $this;
	#return $tmpl;
    
    #------改良------
    my ($class, %args) = @_;
    my $self = bless { file => $args{file} }, $class;
    $self->setting($self->{file});
    return $self;
}

#デストラクタ
sub DESTROY{
    my $this = shift;
}

sub setting{
    my $self = shift;
    my $path = shift;
    
    my $file = IO::File->new($path, '<:encoding(utf-8)');
    croak "ERROR: Can't open file $path." unless (defined $file); #後置のUnless
    my @template = $file->getlines;
    $file->close;

    $self->{template} = join '', @template;
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
	
	my @newfile =$this->{template};
	
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
	return @newfile;
}


1;