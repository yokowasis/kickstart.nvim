# CodeCompanion Usage Guide

## Activation Commands

### Basic Commands
- **`:CodeCompanion`** - Inline assistant (prompts for input if no args provided)
- **`:CodeCompanionChat`** - Opens a chat buffer  
- **`:CodeCompanionActions`** - Opens the action palette
- **`:CodeCompanionCmd`** - Generate command-line commands

### Usage Examples
- `:CodeCompanion` - Opens input prompt for inline assistance
- `:CodeCompanion explain this code` - Direct inline prompt
- `:CodeCompanion <anthropic> refactor this function` - Use specific adapter
- `:CodeCompanionChat` - Start new chat
- `:CodeCompanionChat Toggle` - Toggle chat visibility
- `:CodeCompanionActions` - Open action palette

## Default Keymaps

### Chat Buffer Keymaps

#### Options & Help
- `?` - Show options

#### Completion & Sending
- `<C-_>` (Insert mode) - Completion menu
- `<CR>` or `<C-s>` (Normal mode) - Send message
- `<C-s>` (Insert mode) - Send message

#### Chat Management
- `<C-c>` - Close chat
- `q` - Stop request
- `gx` - Clear chat
- `}` - Next chat
- `{` - Previous chat

#### Code Handling
- `gc` - Insert codeblock
- `gy` - Yank code (fastest way to copy code to clipboard)
- `gf` - Fold code
- `gr` - Regenerate last response

#### Context & Navigation
- `gp` - Pin context
- `gw` - Watch buffer
- `]]` - Next header
- `[[` - Previous header
- `gR` - Open file under cursor in new tab

#### Adapter & Settings
- `ga` - Change adapter (switch between AI models)
- `gs` - Toggle system prompt
- `gta` - Toggle automatic tool mode
- `gd` - View debug info
- `gS` - Show Copilot usage statistics

### Inline Assistant Keymaps
- `ga` (Normal mode) - Accept change
- `gr` (Normal mode) - Reject change

## Variables & Context

### Variables (Add context to chat)
Use **variables** with `#` prefix in chat buffers:

- `#{buffer}` - Share current buffer with LLM 
- `#{buffer watch}` - Watch current buffer for changes
- `#{buffer pin}` - Pin current buffer to chat
- `#{lsp}` - Share LSP information and code for current buffer
- `#{viewport}` - Share visible code in your Neovim viewport

### Slash Commands (Insert content into chat)
Use **slash commands** with `/` prefix in chat buffers:

- `/buffer` - Insert/select from open buffers
- `/file` - Insert a specific file (opens file picker)
- `/quickfix` - Insert quickfix list entries
- `/symbols` - Insert code symbols from selected file
- `/workspace` - Load workspace file
- `/terminal` - Insert terminal output
- `/help` - Insert help documentation
- `/image` - Insert images
- `/fetch` - Insert URL contents
- `/now` - Insert current date/time

### Usage Examples
In a chat buffer, type:
- `#{buffer}` - Adds current buffer as context
- `/file` - Opens picker to select and insert file content
- `#{lsp}` - Adds LSP diagnostics and symbol info
- `/buffer` - Opens picker to select from open buffers

For inline commands:
- `:CodeCompanion #{buffer} explain this code`
- `:CodeCompanion #{viewport} refactor this`

**Note**: Variables (`#{}`) add context for the LLM to reference, while slash commands (`/`) insert actual content into the chat.

## Tools (Agents)

### Available Tools
CodeCompanion provides several built-in tools that act as agents:

#### File Operations
- **`read_file`** - Read files in working directory
- **`create_file`** - Create new files
- **`insert_edit_into_file`** - Edit existing files
- **`file_search`** - Search files by glob pattern
- **`get_changed_files`** - Get git diffs of current changes

#### Code Analysis
- **`grep_search`** - Search text in directory (requires ripgrep)
- **`list_code_usages`** - Find code symbol context
- **`next_edit_suggestion`** - Suggest next edit position

#### System Operations
- **`cmd_runner`** - Run shell commands
- **`fetch_webpage`** - Fetch web content
- **`search_web`** - Search the web using Tavily

### Tool Groups
Pre-configured tool groups:
- **`full_stack_dev`** - Complete development toolkit (all tools above)
- **`files`** - File management tools

### How to Use Tools

#### 1. Enable Auto Tool Mode
In chat buffer: `gta` (toggles automatic tool mode)

#### 2. Request Tool Usage in Chat
Simply ask the LLM to use tools:
- "Can you search for all TODO comments in my project?"
- "Create a new file called utils.lua"
- "Run the test suite"
- "Find all usages of the getUserData function"

#### 3. Example Usage
1. Open chat: `:CodeCompanionChat`
2. Enable auto tool mode: `gta`
3. Ask: "Search for all function definitions in my Python files"
4. The LLM will automatically use appropriate tools

**Note**: Our configuration has `requires_approval = false` for all tools, so they execute immediately without permission prompts.

## Code Optimization

### How to ask the AI to optimize current opened code

#### Method 1: Visual Selection + Inline
1. Select the code you want optimized (visual mode)
2. `:CodeCompanion optimize this code`

#### Method 2: Using Buffer Variable
1. `:CodeCompanionChat`
2. Type: `#{buffer} please optimize this code for performance and readability`

#### Method 3: Using Viewport Variable
1. `:CodeCompanionChat` 
2. Type: `#{viewport} optimize the code I'm currently viewing`

#### Method 4: Direct Inline Command
`:CodeCompanion #{buffer} optimize this code for better performance, readability, and best practices`

#### Specific Optimization Requests
- `#{buffer} refactor this code to be more efficient`
- `#{buffer} optimize this for memory usage`
- `#{buffer} improve error handling in this code`
- `#{buffer} make this code more readable and add comments`
- `#{buffer} apply modern best practices to this code`

## Accepting Code Changes

### Step-by-Step Process:

#### 1. Make an Inline Request
```bash
# Select code you want to change (visual mode)
:CodeCompanion refactor this function
# or
:CodeCompanion #{buffer} optimize this code
```

#### 2. AI Shows Proposed Changes
The AI will display:
- Original code (what you have)
- Proposed changes (what it suggests)
- Diff highlighting the differences

#### 3. Accept or Reject
- **`ga`** - Accept the changes (applies them to your buffer)
- **`gr`** - Reject the changes (keeps your original code)

### What Happens When You Press `ga`:
✅ Original code gets replaced  
✅ Changes are applied to your buffer  
✅ You can immediately see the results  
✅ You can undo with `u` if needed  

## Fast Copy Code from Chat to Buffer

### **`gy` - Yank Code** (Fastest Method)
- Position cursor on code block in chat
- Press `gy` - yanks the code to clipboard
- Go to your buffer and paste with `p`

### **Example Workflow:**
1. Ask AI: "write a function to sort an array"
2. AI responds with code block  
3. Position cursor on the code
4. Press `gy` (yank code)
5. Go to your file: `<C-w>w` or switch buffer
6. Paste: `p` or `"+p`

### **Alternative Methods:**
1. **Visual select + yank**: `V` to select code lines, then `y` to yank
2. **Use register**: The config uses `register = "+"` so code goes to system clipboard
3. **Direct paste**: After `gy`, the code is in your `+` register

## Custom Keymaps

### Added Custom Keymaps
- `<leader>ct` - `:CodeCompanionChat` (open chat)
- `<leader>cc` - `:CodeCompanion #{buffer}` (inline with buffer context in normal mode)
- `<leader>cc` - `:CodeCompanion` (inline with selection in visual mode)

## Configuration Notes

- **Adapter**: Using Copilot with gpt-4.1 model
- **Tool Approval**: Disabled for all tools (immediate execution)
- **Tool Output**: Folding disabled for visibility
- **Default Tools**: `full_stack_dev` group enabled by default
- **Register**: Uses `+` register for system clipboard integration

---

*This guide covers the essential usage patterns for CodeCompanion in your Neovim setup. All keymaps are defined in `lua/codecompanion/config.lua:317` and can be customized in your configuration.*
