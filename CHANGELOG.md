# Changelog

All notable changes to the Claude Code Multi-Project Starter Template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed
- Removed duplicate root-level SKILL.md file (was exact duplicate of tdd-workflow/SKILL.md)
- Refactored coding-standards skill to follow 500-line rule (520 → 469 lines)
- Removed framework-specific examples from universal coding-standards skill
  - Removed React component patterns (Button, hooks, useState, useEffect)
  - Removed Next.js API route examples (NextResponse, App Router)
  - Removed Supabase query examples
  - Replaced with framework-agnostic TypeScript/JavaScript patterns

### Added
- CLAUDE.md for quick reference documentation
- CHANGELOG.md for tracking template evolution
- Universal debouncing pattern (replaces React useDebounce)
- Generic input validation pattern (replaces Zod/framework-specific)
- Framework-agnostic performance patterns (caching, query optimization)

### Changed
- coding-standards skill now contains only universal standards (no React/Next.js)
- Framework-specific patterns remain in optional-components/ for user opt-in
- File organization section now framework-agnostic (no Next.js structure)

## [1.0.0] - 2025-01-18

### Added
- **12 universal agents** for specialized task handling
  - planner, architect, plan-reviewer
  - code-reviewer, code-architecture-reviewer
  - refactor-planner, code-refactor-master
  - security-reviewer, tdd-guide
  - build-error-resolver, documentation-architect
  - web-research-specialist

- **3 universal skills** with auto-activation
  - skill-developer (meta-skill for skill system)
  - coding-standards (code quality and patterns)
  - tdd-workflow (test-driven development)

- **9 optional skills** in optional-components/
  - Backend: backend-dev-guidelines, backend-patterns, route-tester
  - Frontend: frontend-dev-guidelines, frontend-patterns
  - Security: security-review
  - Database: clickhouse-io, error-tracking
  - Example: project-guidelines-example

- **7 hard rules** (always active)
  - security.md, git-workflow.md, coding-style.md
  - testing.md, agents.md, performance.md, patterns.md

- **6 slash commands**
  - /dev-docs, /dev-docs-update, /plan
  - /code-review, /tdd, /build-fix

- **Hook system** with 3 hook types
  - UserPromptSubmit: skill-activation-prompt
  - PostToolUse: post-tool-use-tracker, error-handling-reminder
  - Progressive disclosure (500-line rule for skills)

### Changed
- Consolidated from diet103/claude-code-infrastructure-showcase
- Integrated patterns from affaan-m/everything-claude-code
- Organized into universal vs optional components structure

### Notes
- Base template includes only universal components (work for any project)
- Optional components must be copied to project .claude/ directory as needed
- Skill auto-activation via hook system
- Agent auto-invocation for code review and security
- Model selection: Haiku for lightweight tasks, Sonnet for main work, Opus for deep reasoning

## Legend
- **Added**: New features
- **Changed**: Changes to existing functionality
- **Deprecated**: Soon-to-be removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Vulnerability fixes
