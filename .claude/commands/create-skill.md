---
description: Interactive wizard to create a new Claude Code skill with proper structure, triggers, and configuration
argument-hint: [skill-name]
---

# Create Skill Wizard

Create a new skill named `$ARGUMENTS` using an interactive process.

## Your Task

Guide the user through creating a new skill by gathering requirements and then scaffolding all necessary files.

## Step 1: Gather Information

If `$ARGUMENTS` is empty, ask for the skill name first.

Then ask the user the following questions using the AskUserQuestion tool (you can ask multiple in one call):

**Question 1 - Skill Type:**
- `domain` - Provides comprehensive guidance for specific areas (most common)
- `guardrail` - Enforces critical practices that prevent errors (blocking)
- `methodology` - Defines a workflow or process (like TDD)
- `quality` - Code quality and standards enforcement

**Question 2 - Enforcement Level:**
- `suggest` - Advisory, skill suggestion appears but doesn't block (recommended for most)
- `block` - Requires skill to be used before proceeding (critical guardrails only)
- `warn` - Shows warning but allows proceeding

**Question 3 - Priority:**
- `high` - Important, trigger for most matches
- `medium` - Moderate, trigger for clear matches
- `critical` - Highest, always trigger (guardrails only)

**Question 4 - Primary Trigger Keywords:**
Ask user: "What keywords should trigger this skill? (comma-separated, e.g., 'authentication, auth, login, JWT')"

**Question 5 - Brief Description:**
Ask user: "Briefly describe what this skill helps with (1-2 sentences)"

## Step 2: Create the Skill Files

After gathering all information, create the following:

### 2a. Create Skill Directory and SKILL.md

Create `.claude/skills/{skill-name}/SKILL.md` with this template:

```markdown
---
name: {skill-name}
description: {user's description}. Keywords: {keywords joined}. Use when working with {relevant context}.
---

# {Skill Name Title Case}

## Purpose

{Expand on the user's description}

## When to Use This Skill

Automatically activates when you mention:
{List the keywords as bullet points}

## Key Guidelines

{Add 3-5 placeholder guidelines - tell user to fill these in}

### 1. [Guideline Category]

- Point 1
- Point 2

### 2. [Another Category]

- Point 1
- Point 2

## Examples

{Add placeholder for examples}

## Related Files

- List relevant files in the project that this skill relates to

---

**Skill Status**: DRAFT - Fill in the guidelines above
**Line Count**: Keep under 500 lines (use reference files if needed)
```

### 2b. Update skill-rules.json

Read the current `.claude/skills/skill-rules.json` and add a new entry in the `skills` object:

```json
"{skill-name}": {
  "type": "{type}",
  "enforcement": "{enforcement}",
  "priority": "{priority}",
  "description": "{brief description}",
  "promptTriggers": {
    "keywords": [{keywords as array}],
    "intentPatterns": [
      "(how do|how does|explain).*?{main-keyword}",
      "(create|add|implement).*?{main-keyword}"
    ]
  }
}
```

## Step 3: Provide Next Steps

After creating the files, tell the user:

1. **Edit the SKILL.md** - Fill in the actual guidelines, examples, and related files
2. **Refine triggers** - Update keywords and intent patterns in skill-rules.json based on real usage
3. **Test activation** - Try prompts that should trigger the skill to verify it works
4. **Add reference files** - If content exceeds 500 lines, create reference files like `DETAILS.md`

## Important Notes

- The skill-developer skill has comprehensive documentation - reference it for advanced patterns
- Keep SKILL.md under 500 lines (Anthropic best practice)
- Use lowercase-hyphenated names (e.g., `error-handling`, `api-design`)
- Include all trigger keywords in the description field for better activation

## Related Resources

- Skill Developer Guide: `.claude/skills/skill-developer/SKILL.md`
- Trigger Types Reference: `.claude/skills/skill-developer/TRIGGER_TYPES.md`
- Patterns Library: `.claude/skills/skill-developer/PATTERNS_LIBRARY.md`
