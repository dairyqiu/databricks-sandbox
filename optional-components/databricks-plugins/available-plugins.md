# Available Databricks Plugins Reference

Detailed descriptions of plugins available in the vibe-main marketplace.

## Core Plugins

### fe-databricks-tools
**Purpose:** Core Databricks workflow automation

**Features:**
- Databricks authentication and workspace setup
- SQL query execution and results handling
- Deployment automation (Apps, Jobs, Workflows)
- Workspace configuration management

**Enable when:** Always for Databricks FE projects

### fe-google-tools
**Purpose:** Google Workspace integration

**Features:**
- Create and edit Google Docs
- Create and populate Google Sheets
- Create Google Slides presentations
- Google Drive file management
- Google Calendar operations

**Enable when:** Creating docs, sheets, or slides

### fe-internal-tools
**Purpose:** Internal Databricks tools access

**Features:**
- GTM (Go-To-Market) data access
- Global Genie search
- Glean knowledge search
- AWS authentication helpers

**Enable when:** Research, internal data access

### fe-jira-tools
**Purpose:** JIRA integration

**Features:**
- Create and update JIRA tickets
- ES ticket management
- Sprint and backlog operations
- Issue linking and tracking

**Enable when:** Working with JIRA/ES tickets

### fe-workflows
**Purpose:** Common FE workflow automation

**Features:**
- Sizing and estimation tools
- Documentation generation
- Security questionnaire helpers
- Support escalation workflows

**Enable when:** Standard FE processes

## Optional Plugins

### fe-salesforce-tools
**Purpose:** Salesforce CRM integration

**Features:**
- Account and opportunity lookup
- Activity logging
- Contact management

**Enable when:** Projects with Salesforce integration

### fe-file-expenses
**Purpose:** Emburse expense automation

**Features:**
- Expense report creation
- Receipt processing
- Approval workflows

**Enable when:** Filing expenses

### fe-specialized-agents
**Purpose:** Advanced agent capabilities

**Features:**
- CLI execution agents
- Diagram generation
- Testing automation

**Enable when:** Advanced workflows requiring specialized agents

### fe-vibe-setup
**Purpose:** Environment validation

**Features:**
- Validate vibe environment setup
- Check MCP server connectivity
- Verify authentication state

**Enable when:** Troubleshooting environment issues

### fe-mcp-servers
**Purpose:** Custom MCP server management

**Features:**
- Placeholder for custom MCP configurations
- Server lifecycle management

**Enable when:** Custom MCP server needs

## Plugin Configuration

All plugins follow the pattern: `plugin-name@marketplace-name`

For vibe plugins: `fe-plugin-name@fe-vibe`
For official plugins: `plugin-name@claude-plugins-official`

Example configuration:
```json
{
  "enabledPlugins": {
    "fe-databricks-tools@fe-vibe": true,
    "github@claude-plugins-official": true
  }
}
```
