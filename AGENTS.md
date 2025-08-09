# AGENTS.md

## Build, Lint, and Test
- **Lint (format check):** `stylua --check .`
- **Auto-format:** `stylua .`
- **No standard test runner** is set up; this is a Neovim config. Add tests as needed.
- **No build step** required.

## Code Style Guidelines
- **Formatting:**
  - 2 spaces indentation, 160 column width, Unix line endings
  - Prefer single quotes for strings
  - No parentheses for function calls unless required
- **Imports:** Use `require 'module'` for Lua modules
- **Types:** Lua is dynamic; use clear names and comments for complex logic
- **Naming:** Use `snake_case` for variables/functions, `CamelCase` for modules if desired
- **Error handling:** Use `pcall` for protected calls (e.g., loading plugins)
- **Modularity:** Place config in `lua/` subfolders, split into multiple files
- **Do not commit** `lazy-lock.json` unless you want to pin plugin versions
- **Comment** non-obvious logic and follow Neovim Lua best practices (`:help lua-guide`)

_No Cursor or Copilot rules found. Update this file if you add them._
