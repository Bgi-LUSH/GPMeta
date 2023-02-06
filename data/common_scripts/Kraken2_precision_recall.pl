use strict;

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
	if($a[1]=~/^chr/){$human_read++;next;}
	#my $acc=(split/-/,$a[1])[0];
        my $acc;
        if ($a[1] =~ /^(\S+)_(\d+)_(\d+)_/){$acc=$1;}

	#my $chr=$a[2];
	if($a[0] eq "U" ){$total_unmapread++;}else{
	$total_mapread++;	
        if(exists $tax_spe{$a[2]}  && exists $spe{$acc}){
		if($tax_spe{$a[2]} eq $spe{$acc}){$correct_num++;}
		else{$no_correct_num++;}
	}else{
		$noexists++;	}
	}
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



