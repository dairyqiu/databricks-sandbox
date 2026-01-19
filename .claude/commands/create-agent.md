---
description: Interactive wizard to create a new Claude Code agent with proper structure and configuration
argument-hint: [agent-name]
---

# Create Agent Wizard

Create a new agent named `$ARGUMENTS` using an interactive process.

## Your Task

Guide the user through creating a new specialized agent by gathering requirements and then scaffolding the agent file.

## Step 1: Gather Information

If `$ARGUMENTS` is empty, ask for the agent name first.

Then ask the user the following questions using the AskUserQuestion tool:

**Question 1 - Agent Purpose:**
Ask: "What is the primary purpose of this agent? (e.g., 'Review database migrations for safety issues', 'Generate API documentation from code')"

**Question 2 - Tools Needed:**
- `Read, Grep, Glob` - Read-only exploration (research, analysis)
- `Read, Write, Edit, Grep, Glob` - Can modify files (implementation)
- `Read, Write, Edit, Bash, Grep, Glob` - Full access including shell commands
- `All tools` - Complete access to all available tools

**Question 3 - Model Preference:**
- `sonnet` - Best for most coding tasks (recommended)
- `haiku` - Faster/cheaper for simpler tasks
- `opus` - Deepest reasoning for complex decisions

**Question 4 - Invocation Pattern:**
- `proactive` - Claude should invoke automatically when relevant (code-reviewer, security-reviewer)
- `on-demand` - Only when explicitly requested by user
- `chained` - Typically used as part of a multi-agent workflow

**Question 5 - Key Behaviors:**
Ask: "List 3-5 key things this agent should do (comma-separated)"

## Step 2: Create the Agent File

Create `.claude/agents/{agent-name}.md` with this template:

```markdown
---
name: {agent-name}
description: {user's purpose description}. Use {proactive/on-demand} when {trigger context}.
tools: {selected tools}
model: {selected model}
---

You are a specialized {agent-name} agent focused on {primary purpose}.

## Your Role

{Expand on the user's purpose - 2-3 sentences}

## Key Responsibilities

{Convert user's key behaviors into bullet points}
- Responsibility 1
- Responsibility 2
- Responsibility 3

## Process

### 1. Analysis Phase
- Understand the context and requirements
- Identify relevant files and components
- Review existing patterns

### 2. Execution Phase
- {Task-specific steps}
- {More steps based on agent purpose}

### 3. Output Phase
- Provide clear, actionable results
- Summarize findings or changes
- Suggest next steps if applicable

## Output Format

{Customize based on agent type}

For analysis agents:
```markdown
## {Agent Name} Report

### Summary
[Brief overview]

### Findings
- [Finding 1]
- [Finding 2]

### Recommendations
- [Recommendation 1]
- [Recommendation 2]
```

For implementation agents:
```markdown
## Changes Made

### Files Modified
- `path/to/file.ts` - Description of change

### Testing
- How to verify the changes

### Next Steps
- Any follow-up actions needed
```

## Best Practices

1. Be thorough but focused on your specialty
2. Follow existing project patterns
3. Provide actionable outputs
4. Flag issues with severity levels when applicable
5. Suggest related agents if additional review is needed

## When to Invoke

{Based on invocation pattern selected}

**Proactive triggers:**
- {List scenarios when this agent should auto-invoke}

**Do NOT invoke when:**
- {List scenarios to skip}
```

## Step 3: Update Rules (if proactive)

If the user selected "proactive" invocation, remind them to update `.claude/rules/agents.md` to add the new agent to the proactive invocation table.

## Step 4: Provide Next Steps

After creating the file, tell the user:

1. **Customize the agent** - Fill in specific process steps, output formats, and best practices
2. **Test the agent** - Use the Task tool to invoke it manually and verify behavior
3. **Add to rules** - If proactive, add to the agents.md rules file
4. **Document triggers** - Be explicit about when Claude should invoke this agent

## Agent Design Principles

- **Single responsibility** - Each agent should do one thing well
- **Clear outputs** - Define exact format for results
- **Appropriate tools** - Only request tools actually needed
- **Model matching** - Use haiku for simple tasks, opus for complex reasoning
- **Composability** - Design to work in agent chains when applicable
- **Verification step** - Always include a verification phase (from Anthropic best practices)

## Related Resources

The **agent-developer** skill provides comprehensive guidance:
- `.claude/skills/agent-developer/SKILL.md` - Main guide
- `.claude/skills/agent-developer/AGENT_PATTERNS.md` - Copy-paste templates
- `.claude/skills/agent-developer/MODEL_SELECTION.md` - When to use Haiku/Sonnet/Opus
- `.claude/skills/agent-developer/MULTI_AGENT.md` - Multi-agent workflow patterns

## Existing Agents for Reference

Review these agents in `.claude/agents/` for patterns:
- `planner.md` - Planning specialist (read-only, opus model)
- `code-reviewer.md` - Code review (read-only, sonnet model)
- `security-reviewer.md` - Security analysis (full access, opus model)
- `build-error-resolver.md` - Build fixes (full access, sonnet model)
