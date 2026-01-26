# MCP Server Configurations

**Example MCP (Model Context Protocol) server configurations**

This directory contains example MCP server configurations from everything-claude-code, showing how to integrate external services and tools with Claude Code.

---

## What is MCP?

**Model Context Protocol (MCP)** is a standard for connecting Claude to external data sources and tools.

**MCP Servers** provide:
- Access to external APIs (GitHub, Supabase, etc.)
- Integration with development tools
- Database connectivity
- Cloud service integration
- Custom data sources

**How It Works:**
```
Claude Code → MCP Server → External Service (GitHub API, Database, etc.)
```

---

## Available Configurations

### Databricks-Specific (databricks-mcp.json)

For internal Databricks FE work, see [databricks-mcp.json](databricks-mcp.json):
- **context7** - Live documentation lookup
- **chrome-devtools** - Web automation/testing
- **glean** - Internal knowledge search
- **slack** - Slack messaging
- **google** - Google Workspace

These are also pre-configured in the template's `.mcp.json` file. Enable via `enabledMcpjsonServers` in settings.

### Generic Development (mcp-servers.json)

The [mcp-servers.json](mcp-servers.json) file contains pre-configured MCP servers from everything-claude-code:

### Development Tools
- **sequential-thinking** - Enhanced reasoning capabilities
- **github** - GitHub API integration
- **git** - Git repository operations

### Cloud Services
- **cloudflare** - Cloudflare API integration
- **vercel** - Vercel deployment platform
- **railway** - Railway hosting platform

### Databases
- **supabase** - Supabase database and auth
- **mongodb-atlas** - MongoDB Atlas cloud database
- **postgres** - PostgreSQL database access

### Data & Analytics
- **clickhouse** - ClickHouse analytics database
- **google-sheets** - Google Sheets integration

### Communication
- **slack** - Slack messaging integration

### Infrastructure
- **docker** - Docker container management
- **kubernetes** - Kubernetes cluster management

### Utilities
- **filesystem** - Local filesystem access

---

## Configuration File Structure

The [mcp-servers.json](mcp-servers.json) follows this format:

```json
{
  "mcpServers": {
    "server-name": {
      "command": "command-to-run",
      "args": ["--flag", "value"],
      "env": {
        "API_KEY": "from-environment"
      }
    }
  }
}
```

**Example - GitHub MCP Server:**

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }
}
```

---

## Quick Start

### View Available Configurations

```bash
cat optional-components/mcp-configs/mcp-servers.json
```

This shows all 15 pre-configured MCP servers.

### Choose Servers for Your Project

Browse the configurations and identify which services you need:

**For Full-Stack Web App:**
- sequential-thinking (enhanced reasoning)
- github (source control)
- supabase (database + auth)
- vercel (deployment)

**For API Development:**
- sequential-thinking
- github
- postgres or mongodb-atlas (database)
- docker (containerization)

**For Data/Analytics:**
- clickhouse (analytics)
- google-sheets (reporting)
- postgres (data warehouse)

### Add to Your settings.json

Copy the configurations you need to [.claude/settings.json](../../.claude/settings.json):

```json
{
  "enableAllProjectMcpServers": true,
  "enabledMcpjsonServers": [
    "sequential-thinking",
    "github",
    "supabase"
  ]
}
```

---

## Server-by-Server Guide

### sequential-thinking

**Purpose:** Enhanced reasoning capabilities for complex problems

**What It Does:**
- Provides structured thinking tools
- Helps break down complex problems
- Improves planning and analysis

**Configuration:**
```json
{
  "sequential-thinking": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
  }
}
```

**Setup:**
No API keys needed - works out of the box.

**Use When:**
- Complex feature planning
- Architectural decisions
- Problem-solving
- Multi-step reasoning

---

### github

**Purpose:** GitHub API integration for repository operations

**What It Does:**
- Create/manage issues and PRs
- Read repository contents
- Manage GitHub Actions
- Access GitHub data

**Configuration:**
```json
{
  "github": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-github"],
    "env": {
      "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
    }
  }
}
```

**Setup:**
1. Create GitHub personal access token:
   - Go to GitHub Settings → Developer settings → Personal access tokens
   - Generate new token with repo, workflow, and read:org scopes
2. Add to environment:
   ```bash
   export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_your_token_here
   ```

**Use When:**
- Creating issues/PRs from Claude
- Analyzing repository structure
- Managing GitHub workflows
- Automating GitHub operations

---

### supabase

**Purpose:** Supabase database and authentication integration

**What It Does:**
- Query Supabase database
- Manage authentication
- Access storage buckets
- Use Supabase functions

**Configuration:**
```json
{
  "supabase": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-supabase"],
    "env": {
      "SUPABASE_URL": "${SUPABASE_URL}",
      "SUPABASE_ANON_KEY": "${SUPABASE_ANON_KEY}"
    }
  }
}
```

**Setup:**
1. Get credentials from Supabase project:
   - Project Settings → API
   - Copy URL and anon key
2. Add to environment:
   ```bash
   export SUPABASE_URL=https://your-project.supabase.co
   export SUPABASE_ANON_KEY=your-anon-key
   ```

**Use When:**
- Database queries and migrations
- Authentication setup
- Storage operations
- Supabase function development

---

### postgres

**Purpose:** Direct PostgreSQL database access

**What It Does:**
- Execute SQL queries
- Manage database schema
- Analyze query performance
- Database migrations

**Configuration:**
```json
{
  "postgres": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-postgres"],
    "env": {
      "DATABASE_URL": "${DATABASE_URL}"
    }
  }
}
```

**Setup:**
```bash
export DATABASE_URL=postgresql://user:password@localhost:5432/dbname
```

**Use When:**
- Writing SQL queries
- Database schema design
- Performance optimization
- Data analysis

---

### clickhouse

**Purpose:** ClickHouse analytics database integration

**What It Does:**
- Analytics queries
- Time-series data analysis
- High-performance aggregations
- Data warehousing

**Configuration:**
```json
{
  "clickhouse": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-clickhouse"],
    "env": {
      "CLICKHOUSE_URL": "${CLICKHOUSE_URL}",
      "CLICKHOUSE_USER": "${CLICKHOUSE_USER}",
      "CLICKHOUSE_PASSWORD": "${CLICKHOUSE_PASSWORD}"
    }
  }
}
```

**Setup:**
```bash
export CLICKHOUSE_URL=http://localhost:8123
export CLICKHOUSE_USER=default
export CLICKHOUSE_PASSWORD=your-password
```

**Use When:**
- Analytics queries
- Large dataset analysis
- Real-time aggregations
- Data warehouse operations

**Pairs Well With:** clickhouse-io skill

---

### vercel

**Purpose:** Vercel deployment platform integration

**What It Does:**
- Deploy projects
- Manage deployments
- Configure environment variables
- Access deployment logs

**Configuration:**
```json
{
  "vercel": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-vercel"],
    "env": {
      "VERCEL_TOKEN": "${VERCEL_TOKEN}"
    }
  }
}
```

**Setup:**
1. Generate Vercel token:
   - Vercel Dashboard → Account Settings → Tokens
   - Create new token
2. Add to environment:
   ```bash
   export VERCEL_TOKEN=your-vercel-token
   ```

**Use When:**
- Deploying applications
- Managing deployments
- Configuring projects
- Troubleshooting deployments

---

### docker

**Purpose:** Docker container management

**What It Does:**
- Manage containers and images
- Inspect container logs
- Build images
- Docker Compose operations

**Configuration:**
```json
{
  "docker": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-docker"]
  }
}
```

**Setup:**
Requires Docker installed and running locally.

**Use When:**
- Container management
- Debugging container issues
- Building images
- Docker Compose workflows

---

### slack

**Purpose:** Slack messaging integration

**What It Does:**
- Send messages to channels
- Read messages
- Manage channels
- Post notifications

**Configuration:**
```json
{
  "slack": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-slack"],
    "env": {
      "SLACK_BOT_TOKEN": "${SLACK_BOT_TOKEN}",
      "SLACK_TEAM_ID": "${SLACK_TEAM_ID}"
    }
  }
}
```

**Setup:**
1. Create Slack app and install to workspace
2. Copy bot token from OAuth & Permissions
3. Add to environment:
   ```bash
   export SLACK_BOT_TOKEN=xoxb-your-token
   export SLACK_TEAM_ID=T01234567
   ```

**Use When:**
- Sending deployment notifications
- Posting error alerts
- Team communication from Claude
- Automated status updates

---

## Integration Workflow

### 1. Identify Needed Servers

Review your project's integrations:
- Source control (GitHub)
- Database (Postgres, Supabase, MongoDB, ClickHouse)
- Deployment (Vercel, Railway, Cloudflare)
- Communication (Slack)
- Infrastructure (Docker, Kubernetes)

### 2. Set Up API Keys

For each server, obtain and configure API keys:

```bash
# Example: Setting up multiple services
export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_xxx
export SUPABASE_URL=https://xxx.supabase.co
export SUPABASE_ANON_KEY=eyJxxx
export VERCEL_TOKEN=xxx
```

**Security Note:** Never commit API keys to git. Use environment variables.

### 3. Copy Configurations

Extract relevant configurations from [mcp-servers.json](mcp-servers.json) to your [.claude/settings.json](../../.claude/settings.json):

```json
{
  "enableAllProjectMcpServers": true,
  "enabledMcpjsonServers": [
    "sequential-thinking",
    "github",
    "supabase",
    "vercel"
  ]
}
```

### 4. Test Integration

After configuration, test each MCP server:

```
Ask Claude:
"Use GitHub to list my repositories"
"Query the Supabase database for users table"
"Check Vercel deployment status"
```

---

## Security Best Practices

### API Key Management

**DO:**
- ✅ Use environment variables for API keys
- ✅ Add `.env` to `.gitignore`
- ✅ Use separate keys for development and production
- ✅ Rotate keys regularly
- ✅ Use minimal required permissions

**DON'T:**
- ❌ Hardcode API keys in config files
- ❌ Commit API keys to git
- ❌ Share API keys in documentation
- ❌ Use production keys for development
- ❌ Grant excessive permissions

### Environment Variable Pattern

```json
{
  "mcpServers": {
    "service-name": {
      "env": {
        "API_KEY": "${API_KEY}"
      }
    }
  }
}
```

This references `$API_KEY` from your shell environment.

---

## Troubleshooting

### MCP Server Not Available

**Problem:** Claude says MCP server is not available

**Solutions:**
1. **Check server is enabled** in settings.json:
   ```json
   "enabledMcpjsonServers": ["server-name"]
   ```

2. **Verify API keys** are set in environment:
   ```bash
   echo $GITHUB_PERSONAL_ACCESS_TOKEN
   ```

3. **Test MCP command manually**:
   ```bash
   npx -y @modelcontextprotocol/server-github
   ```

4. **Restart Claude Code** after configuration changes

### API Key Errors

**Problem:** Authentication failures or permission errors

**Solutions:**
1. **Verify key is correct** - regenerate if needed
2. **Check key permissions** - ensure sufficient scopes
3. **Confirm environment variable** is exported:
   ```bash
   env | grep API_KEY
   ```
4. **Check key hasn't expired**

### npx Command Fails

**Problem:** MCP server fails to start

**Solutions:**
1. **Verify npm/npx** is installed: `npx --version`
2. **Check internet connection** - npx downloads packages
3. **Clear npx cache**: `npx clear-npx-cache`
4. **Install package globally**:
   ```bash
   npm install -g @modelcontextprotocol/server-github
   ```

---

## Custom MCP Servers

### Creating Custom MCP Server

You can create custom MCP servers for your specific needs:

**Example - Custom API Integration:**

```json
{
  "mcpServers": {
    "my-api": {
      "command": "node",
      "args": ["/path/to/my-mcp-server.js"],
      "env": {
        "API_KEY": "${MY_API_KEY}",
        "API_URL": "https://api.example.com"
      }
    }
  }
}
```

**MCP Server Structure:**

```javascript
// my-mcp-server.js
// Implements MCP protocol
// Provides tools to Claude for API access

const server = {
  name: 'my-api',
  version: '1.0.0',
  tools: [
    {
      name: 'query_api',
      description: 'Query the custom API',
      inputSchema: { /* ... */ }
    }
  ]
}

// Implementation...
```

See [MCP documentation](https://modelcontextprotocol.io) for details.

---

## Common Use Cases

### Full-Stack Development

**Recommended MCP Servers:**
```json
{
  "enabledMcpjsonServers": [
    "sequential-thinking",
    "github",
    "supabase",
    "vercel",
    "slack"
  ]
}
```

**Capabilities:**
- Enhanced planning (sequential-thinking)
- Source control (github)
- Database + auth (supabase)
- Deployment (vercel)
- Team notifications (slack)

---

### Data Engineering

**Recommended MCP Servers:**
```json
{
  "enabledMcpjsonServers": [
    "sequential-thinking",
    "github",
    "postgres",
    "clickhouse",
    "google-sheets"
  ]
}
```

**Capabilities:**
- Complex query planning (sequential-thinking)
- Data warehouse (clickhouse)
- OLTP database (postgres)
- Reporting (google-sheets)
- Version control (github)

---

### DevOps/Infrastructure

**Recommended MCP Servers:**
```json
{
  "enabledMcpjsonServers": [
    "sequential-thinking",
    "github",
    "docker",
    "kubernetes",
    "cloudflare",
    "slack"
  ]
}
```

**Capabilities:**
- Infrastructure planning (sequential-thinking)
- Container management (docker)
- Orchestration (kubernetes)
- CDN/DNS (cloudflare)
- Alerting (slack)

---

## Performance Considerations

### MCP Server Overhead

Each active MCP server:
- Adds startup time to Claude Code
- Consumes system resources
- May add latency to requests

**Best Practices:**
- Only enable servers you actively use
- Disable unused servers
- Test performance impact

### Optimization Tips

1. **Start minimal** - Enable only essential servers
2. **Add incrementally** - Test performance after each addition
3. **Monitor resource usage** - Check memory/CPU impact
4. **Use local caching** - If MCP server supports it

---

## Integration with Other Components

### MCP + Skills

Skills can reference MCP capabilities:

**Example:**
- **clickhouse-io skill** provides ClickHouse query patterns
- **clickhouse MCP server** executes the queries

Skills provide knowledge, MCP provides execution.

### MCP + Agents

Agents can use MCP servers as tools:

**Example:**
- **planner agent** uses sequential-thinking for enhanced reasoning
- **doc-updater agent** uses github to access repository docs

### MCP + Commands

Commands can leverage MCP integrations:

**Example:**
- `/plan` command uses sequential-thinking MCP
- `/deploy` command (custom) uses vercel MCP

---

## Learn More

- **MCP Documentation:** [https://modelcontextprotocol.io](https://modelcontextprotocol.io)
- **Setup guide:** [../../TEMPLATE_SETUP_GUIDE.md](../../TEMPLATE_SETUP_GUIDE.md)
- **Settings configuration:** [../../.claude/settings.json](../../.claude/settings.json)
- **Main guide:** [../../README.md](../../README.md)

---

## Available MCP Servers Reference

Quick reference of all 15 servers in [mcp-servers.json](mcp-servers.json):

| Server | Purpose | Required Env Vars |
|--------|---------|-------------------|
| sequential-thinking | Enhanced reasoning | None |
| github | GitHub API | GITHUB_PERSONAL_ACCESS_TOKEN |
| git | Git operations | None |
| supabase | Supabase database | SUPABASE_URL, SUPABASE_ANON_KEY |
| postgres | PostgreSQL | DATABASE_URL |
| mongodb-atlas | MongoDB Cloud | MONGODB_URI |
| clickhouse | Analytics database | CLICKHOUSE_URL, CLICKHOUSE_USER, CLICKHOUSE_PASSWORD |
| vercel | Vercel platform | VERCEL_TOKEN |
| railway | Railway hosting | RAILWAY_TOKEN |
| cloudflare | Cloudflare API | CLOUDFLARE_API_TOKEN |
| docker | Docker management | None (requires Docker running) |
| kubernetes | K8s management | KUBECONFIG |
| slack | Slack messaging | SLACK_BOT_TOKEN, SLACK_TEAM_ID |
| google-sheets | Google Sheets | GOOGLE_SHEETS_CREDENTIALS |
| filesystem | Local filesystem | None |

---

**Ready to integrate?** Copy relevant configurations from [mcp-servers.json](mcp-servers.json) to your [.claude/settings.json](../../.claude/settings.json) and set up your API keys!
