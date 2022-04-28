# aifd - anti import from derivation

Only run command when specific files have changed and share state in repo.

    "It's like make but dumb"

      -icetan

## Usage

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
