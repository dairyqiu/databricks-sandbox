---
name: coding-standards
description: Universal coding standards, best practices, and patterns for TypeScript, JavaScript, React, and Node.js development.
---

# Coding Standards & Best Practices

Universal coding standards applicable across all projects.

## Code Quality Principles

### 1. Readability First
- Code is read more than written
- Clear variable and function names
- Self-documenting code preferred over comments
- Consistent formatting

### 2. KISS (Keep It Simple, Stupid)
- Simplest solution that works
- Avoid over-engineering
- No premature optimization
- Easy to understand > clever code

### 3. DRY (Don't Repeat Yourself)
- Extract common logic into functions
- Create reusable components
- Share utilities across modules
- Avoid copy-paste programming

### 4. YAGNI (You Aren't Gonna Need It)
- Don't build features before they're needed
- Avoid speculative generality
- Add complexity only when required
- Start simple, refactor when needed

## TypeScript/JavaScript Standards

### Variable Naming

```typescript
// ✅ GOOD: Descriptive names
const marketSearchQuery = 'election'
const isUserAuthenticated = true
const totalRevenue = 1000

// ❌ BAD: Unclear names
const q = 'election'
const flag = true
const x = 1000
```

### Function Naming

```typescript
// ✅ GOOD: Verb-noun pattern
async function fetchMarketData(marketId: string) { }
function calculateSimilarity(a: number[], b: number[]) { }
function isValidEmail(email: string): boolean { }

// ❌ BAD: Unclear or noun-only
async function market(id: string) { }
function similarity(a, b) { }
function email(e) { }
```

### Immutability Pattern (CRITICAL)

```typescript
// ✅ ALWAYS use spread operator
const updatedUser = {
  ...user,
  name: 'New Name'
}

const updatedArray = [...items, newItem]

// ❌ NEVER mutate directly
user.name = 'New Name'  // BAD
items.push(newItem)     // BAD
```

### Error Handling

```typescript
// ✅ GOOD: Comprehensive error handling
async function fetchData(url: string) {
  try {
    const response = await fetch(url)

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`)
    }

    return await response.json()
  } catch (error) {
    console.error('Fetch failed:', error)
    throw new Error('Failed to fetch data')
  }
}

// ❌ BAD: No error handling
async function fetchData(url) {
  const response = await fetch(url)
  return response.json()
}
```

### Async/Await Best Practices

```typescript
// ✅ GOOD: Parallel execution when possible
const [users, markets, stats] = await Promise.all([
  fetchUsers(),
  fetchMarkets(),
  fetchStats()
])

// ❌ BAD: Sequential when unnecessary
const users = await fetchUsers()
const markets = await fetchMarkets()
const stats = await fetchStats()
```

### Type Safety

```typescript
// ✅ GOOD: Proper types
interface Market {
  id: string
  name: string
  status: 'active' | 'resolved' | 'closed'
  created_at: Date
}

function getMarket(id: string): Promise<Market> {
  // Implementation
}

// ❌ BAD: Using 'any'
function getMarket(id: any): Promise<any> {
  // Implementation
}
```

## Debouncing Pattern

### Purpose
Limit expensive operations (API calls, searches) by waiting for user to stop typing.

```typescript
// ✅ GOOD: Generic debounce function
function debounce<T extends (...args: any[]) => any>(
  func: T,
  delay: number
): (...args: Parameters<T>) => void {
  let timeoutId: NodeJS.Timeout

  return (...args: Parameters<T>) => {
    clearTimeout(timeoutId)
    timeoutId = setTimeout(() => func(...args), delay)
  }
}

// Usage
const debouncedSearch = debounce((query: string) => {
  performSearch(query)
}, 500)

// Call it multiple times, only last call after 500ms executes
debouncedSearch('a')
debouncedSearch('ab')
debouncedSearch('abc')  // Only this will execute after 500ms
```

### Conditional Logic

```typescript
// ✅ GOOD: Clear conditional logic
if (isLoading) {
  return showLoadingState()
}
if (error) {
  return showErrorState(error)
}
return showDataState(data)

// ❌ BAD: Nested ternaries
return isLoading ? showLoading() : error ? showError(error) : data ? showData(data) : null
```

## API Response Patterns

### Consistent Response Structure

```typescript
// ✅ GOOD: Standardized API response format
interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: string
  meta?: {
    total: number
    page: number
    limit: number
  }
}

// Success response
const successResponse: ApiResponse<User[]> = {
  success: true,
  data: users,
  meta: { total: 100, page: 1, limit: 10 }
}

// Error response
const errorResponse: ApiResponse<never> = {
  success: false,
  error: 'Invalid request'
}
```

### Input Validation Pattern

```typescript
// ✅ GOOD: Validate inputs with clear error messages
function validateUserInput(data: unknown): User {
  if (!data || typeof data !== 'object') {
    throw new Error('Invalid input: expected object')
  }

  const { name, email } = data as Record<string, unknown>

  if (typeof name !== 'string' || name.length === 0) {
    throw new Error('Invalid name: must be non-empty string')
  }

  if (typeof email !== 'string' || !email.includes('@')) {
    throw new Error('Invalid email: must be valid email address')
  }

  return { name, email } as User
}
```

## File Organization

### File Size and Cohesion

**Many small files > Few large files**

```
✅ GOOD: Focused files
src/
├── utils/
│   ├── formatDate.ts      # 50 lines
│   ├── validateEmail.ts   # 30 lines
│   └── debounce.ts        # 40 lines
├── types/
│   ├── user.ts            # 20 lines
│   └── api.ts             # 30 lines

❌ BAD: Large files
src/
├── utils.ts               # 800 lines (mixed concerns)
└── types.ts               # 500 lines (all types)
```

**Guidelines:**
- Typical file: 200-400 lines
- Maximum: 800 lines
- High cohesion: related code together
- Low coupling: minimal dependencies

### File Naming Conventions

```
UserService.ts             # PascalCase for classes
formatDate.ts              # camelCase for utilities
user.types.ts              # camelCase with .types suffix
constants.ts               # camelCase for constants
```

## Comments & Documentation

### When to Comment

```typescript
// ✅ GOOD: Explain WHY, not WHAT
// Use exponential backoff to avoid overwhelming the API during outages
const delay = Math.min(1000 * Math.pow(2, retryCount), 30000)

// Deliberately using mutation here for performance with large arrays
items.push(newItem)

// ❌ BAD: Stating the obvious
// Increment counter by 1
count++

// Set name to user's name
name = user.name
```

### JSDoc for Public APIs

```typescript
/**
 * Searches markets using semantic similarity.
 *
 * @param query - Natural language search query
 * @param limit - Maximum number of results (default: 10)
 * @returns Array of markets sorted by similarity score
 * @throws {Error} If OpenAI API fails or Redis unavailable
 *
 * @example
 * ```typescript
 * const results = await searchMarkets('election', 5)
 * console.log(results[0].name) // "Trump vs Biden"
 * ```
 */
export async function searchMarkets(
  query: string,
  limit: number = 10
): Promise<Market[]> {
  // Implementation
}
```

## Performance Best Practices

### Avoid Premature Optimization

```typescript
// ✅ GOOD: Clear, readable code first
function findUser(users: User[], id: string): User | undefined {
  return users.find(user => user.id === id)
}

// ❌ BAD: Premature optimization (unless profiled bottleneck)
const userMap = new Map(users.map(u => [u.id, u]))
return userMap.get(id)
```

### Cache Expensive Operations

```typescript
// ✅ GOOD: Cache results of expensive computations
class DataProcessor {
  private cache = new Map<string, Result>()

  process(input: string): Result {
    if (this.cache.has(input)) {
      return this.cache.get(input)!
    }

    const result = this.expensiveComputation(input)
    this.cache.set(input, result)
    return result
  }

  private expensiveComputation(input: string): Result {
    // Heavy computation here
  }
}
```

### Efficient Data Access

```typescript
// ✅ GOOD: Select only needed data
const users = await db.query(
  'SELECT id, name, email FROM users WHERE status = $1 LIMIT 10',
  ['active']
)

// ❌ BAD: Select everything then filter
const allUsers = await db.query('SELECT * FROM users')
const activeUsers = allUsers.filter(u => u.status === 'active').slice(0, 10)
```

## Testing Standards

### Test Structure (AAA Pattern)

```typescript
test('calculates similarity correctly', () => {
  // Arrange
  const vector1 = [1, 0, 0]
  const vector2 = [0, 1, 0]

  // Act
  const similarity = calculateCosineSimilarity(vector1, vector2)

  // Assert
  expect(similarity).toBe(0)
})
```

### Test Naming

```typescript
// ✅ GOOD: Descriptive test names
test('returns empty array when no markets match query', () => { })
test('throws error when OpenAI API key is missing', () => { })
test('falls back to substring search when Redis unavailable', () => { })

// ❌ BAD: Vague test names
test('works', () => { })
test('test search', () => { })
```

## Code Smell Detection

Watch for these anti-patterns:

### 1. Long Functions
```typescript
// ❌ BAD: Function > 50 lines
function processMarketData() {
  // 100 lines of code
}

// ✅ GOOD: Split into smaller functions
function processMarketData() {
  const validated = validateData()
  const transformed = transformData(validated)
  return saveData(transformed)
}
```

### 2. Deep Nesting
```typescript
// ❌ BAD: 5+ levels of nesting
if (user) {
  if (user.isAdmin) {
    if (market) {
      if (market.isActive) {
        if (hasPermission) {
          // Do something
        }
      }
    }
  }
}

// ✅ GOOD: Early returns
if (!user) return
if (!user.isAdmin) return
if (!market) return
if (!market.isActive) return
if (!hasPermission) return

// Do something
```

### 3. Magic Numbers
```typescript
// ❌ BAD: Unexplained numbers
if (retryCount > 3) { }
setTimeout(callback, 500)

// ✅ GOOD: Named constants
const MAX_RETRIES = 3
const DEBOUNCE_DELAY_MS = 500

if (retryCount > MAX_RETRIES) { }
setTimeout(callback, DEBOUNCE_DELAY_MS)
```

**Remember**: Code quality is not negotiable. Clear, maintainable code enables rapid development and confident refactoring.
