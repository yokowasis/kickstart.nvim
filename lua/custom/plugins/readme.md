# Neovim Setup and Notes

## TODO

The very first thing you should do is to run the command `:Tutor` in Neovim.

## Notes

### SNIPPET/LSP

- Trigger with `<c-x>`.
- For `TM_SELECTED_TEXT`, block the text and then `<tab>`.
- Move left and right with `<c-h>` and `<c-l>`.

### Copilot

- Trigger with `<c-j>`.

---

## Setup Instructions

### General

- Install required Python packages:
  ```bash
  pip install pynvim neovim
  ```

### Paste Image

- Install Pillow:
  ```bash
  pip install pillow
  ```

### Jupyter Setup

1. Set up a Conda environment.
2. Install the following packages:
   ```bash
   pip install ipykernel jupytext pynvim jupyter_client cairosvg plotly kaleido pyperclip nbformat
   ```

### Install All Dependencies

- Run the following command:
  ```bash
  pip install pynvim neovim pillow ipykernel jupytext pynvim jupyter_client cairosvg plotly kaleido pyperclip nbformat
  :UpdateRemotePlugins
  ```

### Windows Specific

- Copy the `rplugin.vim` file:
  ```bash
  cp ./rplugin.vim C:\Users\yokow\AppData\Local\nvim-data/rplugin.vim
  ```

### Initialization

1. Add environment to Molten (e.g., `labs`):
   ```bash
   python -m ipykernel install --user --name labs --display-name labs
   ```
2. Initialize Jupyter Labs:
   ```bash
   jupyter kernel --kernel=labs
   ```

---

## iTerm2 Setup

- Keybindings:
  - `#s` -> `<C-s>`
  - `!Up` -> `<M-I>`
  - `#Up` -> `<M-i>`
  - `!Down` -> `<M-K>`
  - `#Down` -> `<M-k>`
  - `#Left` -> `<M-j>`
  - `#Right` -> `<M-l>`

---

## Lemonade Setup

- Install Lemonade:
  ```bash
  go install github.com/lemonade-command/lemonade@latest
  ```
- Start the Lemonade server:
  ```bash
  ~/go/bin/lemonade server
  ```
