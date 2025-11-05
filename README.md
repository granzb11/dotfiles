# dotfiles
Collection of dotfiles for macOS


## .zshrc sync

This repository includes two small helper scripts to back up and restore your `~/.zshrc`:

- `scripts/sync_zshrc.sh` — copies your `~/.zshrc` into this repo at `zsh/.zshrc`, commits the change with a timestamped message, and can optionally push the commit to the remote (`--push`).
- `scripts/restore_zshrc.sh` — restores `zsh/.zshrc` from the repo to `~/.zshrc`, backing up any existing file to `~/.zshrc.YYYYMMDDTHHMMSSZ.bak`.

Usage examples:

1. Create a new backup (commit only):

	```bash
	./scripts/sync_zshrc.sh
	```

2. Backup and push to remote:

	```bash
	./scripts/sync_zshrc.sh --push
	```

3. Restore the saved `.zshrc` into your home directory:

	```bash
	./scripts/restore_zshrc.sh
	```

Notes:

- The scripts assume this repository root contains a `zsh/` directory (the sync script will create it if needed).
- The sync script stages and commits only `zsh/.zshrc`. It will report "No changes to commit." if your `~/.zshrc` is identical to the committed copy.
- Make the scripts executable if needed: `chmod +x scripts/*.sh`.
