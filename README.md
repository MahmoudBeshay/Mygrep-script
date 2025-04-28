# Mygrep Script — Reflective Q&A

---

## Q1: How does your script handle arguments and options?

-Any options the user passes, such as `-v` (invert match) or `-n` (show line numbers), are processed by the script using `getopts`.

-It reads the options, then moves them out of the way, leaving the filename and the pattern to look for as the only arguments left.

-It verifies that the correct number of parameters (pattern and filename) are supplied.

-It displays an error message and ends if something is missing.

-Additionally, it verifies that the file is exist before attempting to search within it.

-The script executes `awk` to either print line numbers, invert the match, or search normally, depending on which options were selected.

---

## Q2: If you were to support regex, or add `-i`, `-c`, or `-l` options, how would your structure change?

- In the 'getopts section', I'd add cases for `i`, `c`, and `l`.
- Then, after parsing options, I would adjust the `awk` command depending on which flags were set.
    - Make case insenstive optinal only with `-i`
    - Make output count only number with `-c`
      ```
       awk -v pattern="$pattern" '$0 !~ pattern {count++} END {print count}' "$filename"
      ```
    -Make it output the filename only if it matches the pattern when `-l` used
     ```
      awk -v pattern="$pattern" '$0 !~ pattern {count++} END {print count}' "$filename"
     ```

    
---

## Q3: What part of the script was hardest to implement and why?

The hardest part of the script was the `AWK` section
set conditons depending on options the user used 
try not get conflict 
and the more option the difficult increses

---
