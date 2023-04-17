#!/usr/bin/env python3

import click
from pathlib import Path

DOTFILES_DIR = Path(__file__).parent
HOMEDIR = Path.home()

def makelink(anchor: Path, target: Path):
	if anchor.exists():
		if anchor.is_symlink():
			anchor.unlink()
		else:
			raise FileExistsError(f'cannot make link {anchor} <- {path}; {anchor} is already a file/folder')

	anchor.symlink_to(target)

def install_zsh():
	makelink(HOMEDIR / '.zshrc', DOTFILES_DIR / 'zsh' / 'rc.zsh')
	makelink(HOMEDIR / '.zsh', DOTFILES_DIR / 'zsh' / 'zsh')

@click.command()
def cli():
	install_zsh()

if __name__ == '__main__':
	cli()