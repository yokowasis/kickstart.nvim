@echo off
title LSP Installer — Neovim (Global)

rustup component add rust-analyzer
uv tool install basedpyright
uv tool install ruff
uv tool install clang-format
uv tool install git+https://github.com/johnnymorganz/stylua
