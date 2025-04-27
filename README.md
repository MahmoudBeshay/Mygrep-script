# Mygrep Script — Reflective Q&A

---

## Q1: How does your script handle arguments and options?

- The script uses `getopts` to handle the `-v` (invert match) and `-n` (line number) options.
- It checks separately for the `-h` option using an `if` statement to display help when needed.
- After parsing options, it uses `shift` so that:
  - `$1` becomes the search **pattern**.
  - `$2` becomes the **filename**.
- It validates input:
  - Checks if the pattern and filename are provided.
  - Displays an error if either is missing.
  - Shows an "invalid option" error if an unsupported flag is passed.
- It uses `awk`, passing Bash variables into the `awk` block to control matching based on selected options.

---

## Q2: If you were to support regex, or add `-i`, `-c`, or `-l` options, how would your structure change?

- I would expand the `getopts` parsing to handle new flags like `-i`, `-c`, and `-l`.
- For `-i`, I would set or unset the `IGNORECASE` setting in `awk` based on whether case-insensitive matching is requested.
- For `-c`, I would modify the `awk` logic to count matching lines and print the total count at the end.
- For `-l`, I would adjust the `awk` script to print the filename and exit after the first match is found.
- I would reorganize the script to separate the construction of the `awk` command based on active options for easier maintenance and scalability.

---

## Q3: What part of the script was hardest to implement and why?

- The hardest part was correctly setting up the variables and logic inside the `awk` block.
- Ensuring that the `-v` (invert match) and `-n` (line numbers) options could work both independently and together required careful conditional handling.
- Small mistakes in logical conditions could cause incorrect output, so precise flow control was crucial.

---
