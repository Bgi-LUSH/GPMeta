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



open IN2," BIN_PATH/samtools view $ARGV[0]|" or die $!;

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
	#my $acc=(split/-/,$a[1])[0];
	#my $chr=$a[2];
        next if($a[1] & 256); # 忽略256：not primary alignment 的reads
        next if($a[1]>=2048); # 忽略2048：supplementary alignmen 的reads
        my $ASscore;
        if($a[13]=~/AS:i:(\d+)/){$ASscore=$1;}else{$ASscore="0";}
	#my $mapq=$a[1]

	if(!exists $readhash{$a[0]}){
		#if (($a[1]&0x4) || $a[3] eq '*'){$total_unmapread;};
		$readhash{$a[0]}="$a[2];$ASscore";
		#$total_mapread++;
	}else{
		$readhash{$a[0]}.="\t$a[2];$ASscore";
	}
}
#	if($a[0] eq "U" ){$total_unmapread++;}else{
#	$total_mapread++;	
for(keys %readhash){
	if($_=~/^chr/){$human_read++;next;}
	my @acc=split/\t/,$readhash{$_};
        #my $accname=(split/-/,$_)[0];
        my $accname;
        if ($_ =~ /^(\S+)_(\d+)_(\d+)_/){$accname=$1;}

	my $star_num=0;
	my @best_reads=("nan","nan","nan");
	my @best_chr;
	for my $t(0..$#acc){
		my $chr_list=$acc[$t];
		my($chr,$as)=split/;/,$chr_list; 
		#if($chr eq "*"){$star_num++;next;}  #unmaped read

                if($t==0){
                        @best_reads=($chr,$as);
			@best_chr=($chr);
                }else{
                        if($as > $best_reads[1]){
                                @best_reads=($chr,$as);
				@best_chr=($chr);
                        }elsif($as == $best_reads[1]){
				push @best_chr,$chr;
			}else{;}
                }
	}
	#print"@best_reads";
	if($best_reads[0] eq "*"){$total_unmapread++;}
	else{
		$total_mapread++;
		my @shuf_chr=shuffle(@best_chr);
		if($spe{$shuf_chr[0]} eq $spe{$accname}){
			$correct_num++;
		}else{$no_correct_num++;}#print"$_\t@best_chr\t$readhash{$_}\n";}
=pod
		my $is_correct=0;
		for(@best_chr){
			if($spe{$_} eq $spe{$accname}){
				$is_correct=1;
				last;	
			}
		}
		$total_mapread++;
		if($is_correct){
			$correct_num++;
		}else{$no_correct_num++;print"$_\t@best_chr\t$readhash{$_}\n";}
=cut
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

