use strict;


open IN2,"BIN_PATH/samtools view $ARGV[0]|" or die $!;
my $gap=50;
my %readhash;

my $total_reads=0;
my $total_mapread=0;
my $hcorect=0;
my $hnotcorect=0;
my $pcorect=0;
my $pnotcorect=0;

while(<IN2>){
        chomp;
        my @a=split/\t/;
        #print"$a[2]\t$spe{$a[2]}\t$ge{$a[2]}\n";
        if(!exists $readhash{$a[0]}){
		$readhash{$a[0]}=1;
		$total_reads++;
		next if (($a[1]&0x4) || $a[3] eq '*');
                next if($a[1] & 256); # 忽略256：not primary alignment 的reads
                next if($a[1]>=2048); # 忽略2048：supplementary alignmen 的reads

            	$total_mapread++;
		my ($chr,$pos,$pos2);
		my $map_chr=$a[2];my $map_pos=$a[3];
		if($a[0]=~/^chr/){#($chr,$pos,$pos2)=(split/_/,$a[0])[0,1,2];
			#if($chr eq $map_chr){$hcorect++;}else{$hnotcorect++;}
			$hcorect++;
		}
		else{$chr=(split/-/,$a[0])[0];
			if($chr eq $map_chr){$pcorect++;}else{$pnotcorect++;}
		}
	#	print"$chr\t$pos\t$map_chr\t$map_pos\n";
		#if($chr eq $map_chr){$corect++;}else{$notcorect++;}
		#if($chr eq $map_chr && abs($pos-$map_pos) < $gap){$corect++;}else{$notcorect++;print"$chr\t$pos\t$pos2\t$map_chr\t$map_pos\n";}
	}else{next;}
}


print"$total_reads\t$total_mapread\t$hcorect\t$hnotcorect\t$pcorect\t$pnotcorect\n";
