package DDG::Goodie::Perimeter;

use DDG::Goodie;

triggers start => "perimeter", "circumference";

zci is_cached => 1;
zci answer_type => "perimeter";

handle query_lc => sub {
    if ($_ =~ m/^(?:circumference (?:of\s|)(?:circle\s|)(\d+(?:\.\d+)?))|(?:(perimeter) (?:of\s|)(?:(square|circle|pentagon|hexagon|octagon) (\d+(?:\.\d+)?)|(rectangle) (\d+(?:\.\d+)?)[,;]?\s(\d+(?:\.\d+)?)|(triangle) (\d+(?:\.\d+)?)[,;]?\s(\d+(?:\.\d+)?)[,;]?\s(\d+(?:\.\d+)?)))$/) {
        my %polygons = ("pentagon" => 5, "hexagon" => 6, "octagon" => 8);
        my $shape = $1 ? "circle" : $3 || $5 || $8;
        
        my $answerPrefix = "Perimeter of $shape: ";
        my $answer;

        if ($shape eq "square") {
            $answer = $4 * 4;
        } elsif ($shape eq "rectangle") {
            $answer = ($6 * 2) + ($7 * 2)
        } elsif ($shape eq "triangle") {
            $answer = $9 + $10 + $11;
        } elsif ($shape eq "circle") {
            $answerPrefix = "Circumference: ";
            $answer = (2 * 3.14159265358979323846) * ($1 || $4);
        } else {
        if (substr $shape, index($shape, "agon") eq "agon") {
            $answer = $4 * $polygons{$shape};
        }
        }

        
        return $answerPrefix.$answer;
    }
    return;
};

1;
