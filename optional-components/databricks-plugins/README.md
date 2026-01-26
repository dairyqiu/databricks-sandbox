# Databricks Plugins

Databricks-specific plugins and MCP servers for Claude Code. These are **not auto-enabled** to keep the template lightweight.

## Available Plugins

| Plugin | Purpose |
|--------|---------|
| `fe-databricks-tools` | Auth, queries, deployments, workspace setup |
| `fe-google-tools` | Docs, Sheets, Slides, Drive creation |
| `fe-internal-tools` | GTM, Global Genie, Glean, AWS auth |
| `fe-jira-tools` | JIRA ES ticket operations |
| `fe-workflows` | Sizing, docs, security, support workflows |

## Optional Plugins

| Plugin | Purpose | When to Enable |
|--------|---------|----------------|
| `fe-salesforce-tools` | Salesforce CRM operations | Projects with SF integration |
| `fe-file-expenses` | Emburse expense automation | When filing expenses |
| `fe-specialized-agents` | CLI execution, diagrams, testing | Advanced workflows |

## How to Enable

### Option 1: Per-Project (Recommended)

Add to your project's `.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "fe-databricks-tools@fe-vibe": true,
    "fe-google-tools@fe-vibe": true,
    "fe-internal-tools@fe-vibe": true,
    "fe-jira-tools@fe-vibe": true,
    "fe-workflows@fe-vibe": true
  }
}
```

Or copy from [settings-snippet.json](./settings-snippet.json).

### Option 2: Global Enable

Add to `~/.claude/settings.json` to enable for all projects.

## MCP Servers

The template includes pre-configured MCP servers in `.mcp.json`. To enable:

1. Add server names to `enabledMcpjsonServers` in `.claude/settings.json`:

```json
{
  "enabledMcpjsonServers": ["glean", "slack", "google"]
}
```

2. Restart Claude Code

### Available MCP Servers

| Server | Purpose | Use Case |
|--------|---------|----------|
| `context7` | Live documentation lookup | Any project - lookup library docs |
| `glean` | Internal Databricks knowledge search | Research, finding docs |
| `slack` | Slack messaging | Team communication |
| `google` | Google Workspace (docs, sheets, calendar) | Creating/editing docs |
| `chrome-devtools` | Web automation/testing | Web app development |

## Verification

After enabling, verify with:
- `/mcp` - Shows enabled MCP servers
- Check that plugins load on Claude startup

## Minimal vs Full Setup

**Minimal (default):** No MCP servers, no plugins auto-enabled
- Best for: Generic projects, quick tasks

**Full Databricks Setup:** All plugins + MCP servers enabled
- Best for: Databricks FE work, customer projects
