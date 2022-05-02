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
    -e INDEX  Run specific entry
    -c        Continue on entry failures
    -l        Print input file paths
    -m        Print manifest file path
    -q        Quiet
    -n        Dry run
    -d        Debug output

Entry properties:
    cmd             Bash shell commands to execute
    required_files  Files that are required to run entry
    files           Files that are checked for changes
    success         Don't abort on entry faliure
    ignore          Skip entry

Exit codes:
    1         Error or failure
    2         Input files has changes
    8         This message

```
<!--END[]-->

## Example

Make a Nix lock file when `yarn.lock` changes to avoid IFD's and keep lock-files
in sync.

```sh
cat > .aifd.yaml <<'EOF'
- cmd: |
    yarn2nix --lockfile="$files" > yarn.nix
  files: yarn.lock
EOF
aifd
```
