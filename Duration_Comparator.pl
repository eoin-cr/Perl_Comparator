use warnings;
use strict;
use Data::Dumper qw(Dumper);

my @files = glob("*.csv");
foreach my $filename (@files) {

    my $runtotal = 0;
    my $pagenumb = 0;
    my $pagetotal = 0;
    my $duration = 0;  #changed from ""
    my $rowNumber = 0;
    my $page = 0;
    my $diff = 0;
    my $diffpage = 0;
    my $rowone= '';
    my $rowonepages = '';

    open(my $fh, '<:encoding(UTF-8)', $filename)
        or die "Could not open file '$filename' $!";
    while (my $row = <$fh>) {
        chomp $row;

        my $number = 0;
        my @words = split /;|\r|\t/, $row;
        my $wordIdx = 0;

        if ($rowNumber == 0) { #first row should just be used for getting titles
            foreach my $word (@words) {
                if ($word eq "Duration") { #setting the duration to the column with duration written at the top
                    $duration = $wordIdx;
                }
                if ($word eq "NbPage") { #setting the page var to the column with NbPage written at the top
                    $page = $wordIdx;
                }
                $wordIdx = $wordIdx + 1;
            };
        }
        elsif ($rowNumber == 1) { #finding the totals at the top of the file
            $rowone = $words[$duration];
            $rowonepages = $words[$page];
        }
        elsif (@words > 0) { #adding up all the duration and page numbers in all lines except the first or second

            $number = $words[$duration];

            $runtotal += $number;
            $pagenumb = $words[$page];
            $pagetotal += $pagenumb;
        }
        $rowNumber = $rowNumber + 1;
    }
    print "\n ~~~~~~~~~~ \n \n $filename\n \n"; #Just printing all the data in a readable format
    print "total at top of file: $rowone\n";
    print "cumulative total of all numbers at bottom: $runtotal\n";

    if ($runtotal < $rowone) {
        $diff = $rowone - $runtotal;
        print "The actual total is less than the total at the top by: $diff\n \n";
    }
    elsif ($rowone < $runtotal) {
        $diff = $runtotal - $rowone;
        print "The actual total is more than the total at the top by: $diff\n \n";
    }
    else {
      print "The actual total is the same as the total at the top!";
    }
    print "NbPage:\n";
    print "total at top of file: $rowonepages\n";
    print "cumulative total of all numbers at bottom: $pagetotal\n";

    if ($pagetotal < $rowonepages) {
        $diffpage = $rowonepages - $pagetotal;
        print "The actual total is less than the total at the top by: $diffpage\n \n";
    }
    elsif ($rowonepages < $pagetotal) {
        $diffpage = $pagetotal - $rowonepages;
        print "The actual total is more than the total at the top by: $diffpage\n \n";
    }
    else{
      print "The actual total is the same as the total at the top!"
    }
    close $fh;
}
