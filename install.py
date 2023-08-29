#!/usr/bin/env python3

import click
import requests
from pathlib import Path
import logging

logger = logging.getLogger(__name__)

DOTFILES_DIR = Path(__file__).parent
HOMEDIR = Path.home()

def makelink(anchor: Path, target: Path):
    if anchor.exists():
        if anchor.is_symlink():
            logger.info(f'removing and updating existing symlink at {anchor}')
            anchor.unlink()
        else:
            raise FileExistsError(f'cannot make link {anchor} <- {path}; {anchor} is already a file/folder')

    anchor.symlink_to(target)

def install_zsh():
    makelink(HOMEDIR / '.zshrc', DOTFILES_DIR / 'zsh' / 'rc.zsh')
    makelink(HOMEDIR / '.zsh', DOTFILES_DIR / 'zsh' / 'zsh')

def install_nvim():
    nvim_cfg_dir = HOMEDIR / '.config' / 'nvim'
    nvim_cfg_dir.mkdir(exist_ok=True)
    makelink(nvim_cfg_dir / 'init.vim', DOTFILES_DIR / 'nvim' / 'init.vim')

    # install vim-plug
    VIMPLUG_UPSTREAM = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autoload_dir = HOMEDIR / '.local' / 'share' / 'nvim' / 'site' / 'autoload'
    autoload_dir.mkdir(parents=True, exist_ok=True)
    vimplug = autoload_dir / 'plug.vim'

    logger.info(f'downloading vim-plug from {VIMPLUG_UPSTREAM}')
    with open(vimplug, 'wb') as f:
        r = requests.get(VIMPLUG_UPSTREAM)
        f.write(r.content)

@click.command()
def cli():
    install_zsh()
    install_nvim()

if __name__ == '__main__':
    logging.basicConfig(level=logging.DEBUG)
    cli()
