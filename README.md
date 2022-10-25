# aifd - anti import from derivation

Only run command when specific files have changed and share state in repo.

    "It's like make but dumb"

      -icetan

## Usage

<!--p[cat ./usage.txt | sed 's|\$(basename "\$0")|aifd|']-->
```
Usage: aifd [OPTIONS] [FILES]

Options:
    -h        Show this message
    -e INDEX  Run specific entry (can be repeated)
    -f        Fail fast, halt on entry failure
    -l        Print input file paths
    -m        Print manifest file path
    -u        Print only files from executed entries (use with -l and -m)
    -q        Quiet
    -n        Dry run
    -d        Debug output
    -s        Debug hashing of files

Entry properties:
    cmd             Bash shell commands to execute
    required_files  Files that are required to run entry
    files           Files that are checked for changes
    ignore          Skip entry

Exit codes:
    1         Error
    2         Entry failed
    3         Input file has changed (when -n)
    8         This message

```
<!--END[]-->

## Example

Make a Nix lock file when `yarn.lock` changes to avoid IFD's and keep lock-files
in sync.

```sh
cat > .aifd.yaml <<'EOF'
- cmd: |
    yarn2nix --lockfile=yarn.lock > yarn.nix
  required_files: yarn.lock
EOF
aifd
```
