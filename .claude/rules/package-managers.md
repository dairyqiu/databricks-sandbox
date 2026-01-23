# Package Manager Requirements

## Required Package Managers

- **Python**: Use `uv` (NOT pip, pip3, or poetry)
- **JavaScript/TypeScript**: Use `bun` (NOT npm, yarn, or pnpm)

## Commands Reference

| Task | Use | NOT |
|------|-----|-----|
| Install Python deps | `uv pip install` or `uv add` | `pip install` |
| Create Python venv | `uv venv` | `python -m venv` |
| Run Python scripts | `uv run python` | `python` directly |
| Sync dependencies | `uv sync` | `pip install -r` |
| Install JS deps | `bun install` | `npm install` |
| Run JS scripts | `bun run` | `npm run` |
| Add JS package | `bun add <pkg>` | `npm install <pkg>` |
| Add JS dev dep | `bun add -d <pkg>` | `npm install -D <pkg>` |
| Run tests | `bun test` | `npm test` |

## Why These Tools?

**uv** - Extremely fast Python package manager written in Rust
- 10-100x faster than pip
- Built-in virtual environment management
- Compatible with pip requirements.txt

**bun** - Fast all-in-one JavaScript runtime
- Faster package installation than npm/yarn/pnpm
- Built-in bundler, test runner, and package manager
- Drop-in replacement for npm commands

## Examples

```bash
# Python project setup
uv venv
uv pip install -r requirements.txt
uv run python main.py

# JavaScript project setup
bun install
bun run dev
bun add zod
```
