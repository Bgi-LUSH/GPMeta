use strict;
use List::Util qw(shuffle); #用于随机打乱数组


open IN,"CONFIG_PATH/acc.taxid.genus.species.txt" or die $!;

my %hash;my %spe;
my %tax_spe;

while(<IN>){
        chomp;
        my($chr,$tax,$genus,$species)=split/\t/;
        $spe{$chr}=$species;
	$tax_spe{$tax}=$species;
}close IN;



open IN2," $ARGV[0]" or die $!;

my %readhash;

my $total_mapread=0;
my $total_unmapread=0;
my $correct_num=0;
my $no_correct_num=0;
my $noexists=0;
my $human_read=0;

while(<IN2>){
        chomp;
        my @a=split/\t/;
	next if(/readID/);
	my $acc=(split/-/,$a[1])[0];
	#my $chr=$a[2];
	if(!exists $readhash{$a[0]}){
		$readhash{$a[0]}=$a[2];
		$total_mapread++ if($a[0]!~/^chr/ && $a[1]!~/^unclassified/);
		$total_unmapread++ if($a[0]!~/^chr/ && $a[1]=~/^unclassified/);
	}else{
		$readhash{$a[0]}.="\t$a[2]";
	}
}
#	if($a[0] eq "U" ){$total_unmapread++;}else{
#	$total_mapread++;	
for(keys %readhash){
	if($_=~/^chr/){$human_read++;next;}
	my @acc=split/\t/,$readhash{$_};
	#my $is_correct=0;
       # my $accname=(split/-/,$_)[0];
        my $accname;
        if ($_=~ /^(\S+)_(\d+)_(\d+)_/){$accname=$1;}

#	for my $tax(@acc){
#        	if($tax_spe{$tax} eq $spe{$accname}){
#			$is_correct=1;
#			last;
#		}
#	}
#	如果存在多个结果，则随机取一个作为结果
	srand 3;
        my @shuf_chr=shuffle(@acc);
	if($tax_spe{$shuf_chr[0]} eq $spe{$accname}){$correct_num++;}
        else{$no_correct_num++;}
	
}

my $precision=$correct_num/$total_mapread;
my $recall=$correct_num/($total_mapread+$total_unmapread);
print"
total_mapread:$total_mapread
total_unmapread:$total_unmapread
correct_num:$correct_num
no_correct_num:$no_correct_num
noexists:$noexists
human_read:$human_read
precision:$precision
recall:$recall
";



