#!/usr/bin/env python3
# /// script
# requires-python = ">=3.10"
# dependencies = ["rich", "click"]
# ///

import click
from rich.console import Console
from rich.logging import RichHandler
from pathlib import Path
import logging

logger = logging.getLogger(__name__)

DOTFILES_DIR = Path(__file__).parent
HOMEDIR = Path.home()
XDG_CONFIG_HOME = HOMEDIR / '.config'

def makelink(anchor: Path, target: Path):
    replaced_existing = False
    if anchor.exists():
        if anchor.is_symlink():
            replaced_existing = True
            anchor.unlink()
        else:
            raise FileExistsError(f'cannot make link {anchor} <- {target}; {anchor} is already a file/folder')

    logger.info(f'linking {anchor} <- {target}' + ' (replaced existing symlink)' if replaced_existing else '')
    anchor.symlink_to(target)

class Collector:
    def __init__(self):
        self.installers = {}

    def installer(self, name):
        def deco(fn):
            self.installers[name] = fn
            return fn

        return deco

dotfiles = Collector()

@dotfiles.installer('zsh')
def install_zsh():
    makelink(HOMEDIR / '.zshrc', DOTFILES_DIR / 'zsh' / 'rc.zsh')
    makelink(HOMEDIR / '.zsh', DOTFILES_DIR / 'zsh' / 'zsh')

@dotfiles.installer('nvim')
def install_nvim():
    nvim_cfg_dir = XDG_CONFIG_HOME / 'nvim'
    nvim_cfg_dir.mkdir(exist_ok=True)
    makelink(nvim_cfg_dir / 'init.lua', DOTFILES_DIR / 'nvim' / 'init.lua')

@dotfiles.installer('tmux')
def install_tmux():
    makelink(HOMEDIR / '.tmux.conf', DOTFILES_DIR / 'tmux' / 'tmux.conf')

@click.command()
def cli():
    console = Console()
    for name, installer in dotfiles.installers.items():
        console.print(f'[blue]running installer [underline]{name}')
        try:
            installer()
        except Exception as e:
            console.print(f'[red]installer [underline]{name}[/underline] failed:')
            console.print_exception()

if __name__ == '__main__':
    logging.basicConfig(level=logging.DEBUG, handlers=[RichHandler()], format='%(message)s', datefmt='[%X]')
    cli()
