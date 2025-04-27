Mygrep Script
This script mimics the grep command in Linux.

Usage: ./mygrep [options] pattern filename

The script supports three options: -h, -v, and -n.

-h: Displays a help message. Implemented as a function and checked using an if statement.
-v: Inverts the match (prints non-matching lines). Sets invert=1 when selected.
-n: Prints line numbers with matching lines. Sets line_number=1 when selected.
The script uses getopts to handle the -v and -n options. If the user provides any option other than -h, -v, or -n, an "invalid option" error is displayed.

After processing options with getopts, the script shifts the arguments to store the pattern and filename in $1 and $2, respectively. It then validates both arguments using if statements:

Checks if the file exists.
Checks if the pattern is provided.

The pattern search is performed using awk, with variables passed from the Bash script:
awk -v invert="$invert" -v line_number="$line_number" -v pattern="$pattern" '
BEGIN { IGNORECASE = 1 }
{
    if ((invert && $0 !~ pattern) || (!invert && $0 ~ pattern)) {
        if (line_number) {
            print NR ":" $0
        } else {
            print $0
        }
    }
}' "$filename"
The BEGIN { IGNORECASE = 1 } block makes the search case-insensitive.
The awk logic:
If -v is used (invert=1), it prints lines where $0 !~ pattern (non-matching lines).
If -v is not used (invert=0), it prints lines where $0 ~ pattern (matching lines).
If -n is used (line_number=1), it prepends the line number (NR) followed by a colon to each output line.
Otherwise, it prints only the matching (or non-matching) line.

