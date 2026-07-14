# After Effects MCP Server Setup Guide

## Quick Start Steps

### 1. Install the After Effects Plugin

Right-click `install-ae-plugin.bat` (in the root directory) and select "Run as administrator", OR enable Developer Mode in Windows Settings and run normally.

**Manual Installation (if needed):**

```bash
# Create CEP extensions directory if it doesn't exist
mkdir -p "C:\Users\James Pollack\AppData\Roaming\Adobe\CEP\extensions"

# Create symbolic link (requires Admin or Developer Mode)
mklink /D "C:\Users\James Pollack\AppData\Roaming\Adobe\CEP\extensions\com.mikechambers.ae" "C:\Users\James Pollack\Desktop\imgntn_repos\MCP_SERVERS\adb-mcp\cep\com.mikechambers.ae"
```

**Note:** This only needs to be done ONCE.

### 2. Start the Proxy Server

Double-click `start-proxy.bat` (in the root directory) and keep this window open while using After Effects with Claude.

You should see: `adb-mcp Command proxy server running on ws://localhost:3001`

**Manual Start:**
```bash
cd adb-proxy-socket
node proxy.js
```

### 3. Launch After Effects

1. Open After Effects
2. Go to: **Window > Extensions > After Effects MCP Agent**
3. Click **Connect** in the plugin panel

### 4. Restart Claude Desktop

Close and reopen Claude Desktop. The After Effects MCP server is already configured in your `claude_desktop_config.json`.

### 5. Use in Claude

1. In Claude Desktop, click the "+" button in the chat input
2. Click "Add from Adobe After Effects"
3. Select **config://get_instructions**
4. Start working with After Effects!

---

## Claude Desktop Configuration

The After Effects MCP server has been added to your Claude Desktop config at:
`C:\Users\James Pollack\AppData\Roaming\Claude\claude_desktop_config.json`

```json
{
  "mcpServers": {
    "ae-mcp": {
      "command": "C:\\Users\\James Pollack\\.local\\bin\\uv.EXE",
      "args": [
        "run",
        "--with", "fonttools",
        "--with", "mcp",
        "--with", "mcp[cli]",
        "--with", "pillow",
        "--with", "python-socketio",
        "--with", "requests",
        "--with", "websocket-client",
        "mcp",
        "run",
        "C:\\Users\\James Pollack\\Desktop\\imgntn_repos\\MCP_SERVERS\\adb-mcp\\mcp\\ae-mcp.py"
      ]
    }
  }
}
```

---

## Troubleshooting

### Plugin not appearing in After Effects

- Make sure you ran `install-ae-plugin.bat` as Administrator
- Check that the symbolic link exists at:
  `C:\Users\James Pollack\AppData\Roaming\Adobe\CEP\extensions\com.mikechambers.ae`
- Restart After Effects

### Plugin won't connect

- Make sure the proxy server is running (`start-proxy.bat`)
- Check the proxy console for errors
- Verify it shows: `adb-mcp Command proxy server running on ws://localhost:3001`

### Claude Desktop not showing After Effects

- Restart Claude Desktop
- Check the config file exists:
  `C:\Users\James Pollack\AppData\Roaming\Claude\claude_desktop_config.json`
- Look for the "ae-mcp" entry in mcpServers

### MCP won't run in Claude

If you get an error when running Claude that the MCP is not working, you may need to edit your Claude config file and put an absolute path for the UV command. The configuration above already uses the absolute path: `C:\\Users\\James Pollack\\.local\\bin\\uv.EXE`

---

## Daily Workflow

Each time you want to use After Effects with Claude:

1. Run `start-proxy.bat` (keep it running)
2. Launch After Effects
3. **Window > Extensions > After Effects MCP Agent** > Click **Connect**
4. Use Claude Desktop normally

---

## Available Features

The After Effects MCP provides:

- **Execute arbitrary ExtendScript code** - Full programmatic control
- **Full access to After Effects API** - Everything ExtendScript can do
- Create compositions, layers, and effects
- Animate properties and keyframes
- Work with footage and rendering
- Manipulate text, shapes, and 3D layers
- And much more via ExtendScript!

### Example Prompts

```
Create a new composition that is 1920x1080 at 30fps
```

```
Add a text layer that says "Hello World" and animate it to fade in
```

```
Create a new solid layer with a red background
```

```
What compositions are currently in the project?
```

For a full list of available functions, ask Claude:
```
What After Effects functions are available?
```

---

## Technical Details

### Architecture

**Claude Desktop** ↔ **MCP Server (ae-mcp.py)** ↔ **Proxy Server (Node.js)** ↔ **After Effects CEP Plugin** ↔ **After Effects**

The proxy server is required because the CEP plugin API doesn't allow plugins to act as servers and listen for connections directly.

### Key Files

- **ae-mcp.py** - MCP server that provides the interface to Claude
- **../adb-proxy-socket/proxy.js** - Node.js proxy server (WebSocket bridge)
- **../cep/com.mikechambers.ae/** - After Effects CEP plugin
- **core.py** - Shared core functionality
- **socket_client.py** - Socket.IO client for communicating with proxy

### Dependencies

The MCP server requires:
- Python 3.x
- fonttools
- python-socketio
- mcp (with CLI support)
- requests
- websocket-client
- pillow

These are automatically installed when using the `uvx` command in the Claude Desktop config.

---

## Additional MCP Servers

This repository includes MCP servers for other Adobe applications:

- **ps-mcp.py** - Photoshop (most feature-rich)
- **pr-mcp.py** - Premiere Pro
- **id-mcp.py** - InDesign
- **ai-mcp.py** - Illustrator

Each requires similar setup with their respective CEP/UXP plugins and proxy server.

---

## Resources

- [Main Project Repository](https://github.com/mikechambers/adb-mcp)
- [Video Examples](https://www.youtube.com/playlist?list=PLrZcuHfRluqt5JQiKzMWefUb0Xumb7MkI)
- [Discord Community](https://discord.gg/fgxw9t37D7)
- [Issues & Feature Requests](https://github.com/mikechambers/adb-mcp/issues)

---

## License

Project released under a [MIT License](../LICENSE.md).
