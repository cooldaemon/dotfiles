---
name: react-patterns
description: React and Next.js development patterns including components, hooks, state management, and performance optimization.
---

# React/Next.js Patterns

Patterns for React and Next.js frontend development.

## Component Patterns

### Composition with children

```typescript
function Card({ children }: { children: React.ReactNode }) {
  return <div className="card">{children}</div>
}

function CardHeader({ children }: { children: React.ReactNode }) {
  return <div className="card-header">{children}</div>
}

function CardBody({ children }: { children: React.ReactNode }) {
  return <div className="card-body">{children}</div>
}

// Usage
<Card>
  <CardHeader>Title</CardHeader>
  <CardBody>Content</CardBody>
</Card>
```

### Compound Components with Context

```typescript
const TabsContext = createContext<{
  activeTab: string
  setActiveTab: (tab: string) => void
} | undefined>(undefined)

function Tabs({ children, defaultTab }: {
  children: React.ReactNode
  defaultTab: string
}) {
  const [activeTab, setActiveTab] = useState(defaultTab)
  return (
    <TabsContext.Provider value={{ activeTab, setActiveTab }}>
      {children}
    </TabsContext.Provider>
  )
}

function Tab({ id, children }: { id: string; children: React.ReactNode }) {
  const context = useContext(TabsContext)
  if (!context) throw new Error('Tab must be used within Tabs')
  return (
    <button
      className={context.activeTab === id ? 'active' : ''}
      onClick={() => context.setActiveTab(id)}
    >
      {children}
    </button>
  )
}
```

## Custom Hooks

### useDebounce

```typescript
function useDebounce<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState<T>(value)

  useEffect(() => {
    const handler = setTimeout(() => setDebouncedValue(value), delay)
    return () => clearTimeout(handler)
  }, [value, delay])

  return debouncedValue
}

// Usage
const debouncedQuery = useDebounce(searchQuery, 500)
```

### useToggle

```typescript
function useToggle(initialValue = false): [boolean, () => void] {
  const [value, setValue] = useState(initialValue)
  const toggle = useCallback(() => setValue(v => !v), [])
  return [value, toggle]
}

// Usage
const [isOpen, toggleOpen] = useToggle()
```

## State Management

### Functional Updates

```typescript
const [count, setCount] = useState(0)

// GOOD: Functional update for state based on previous
setCount(prev => prev + 1)

// BAD: Direct reference (can be stale in async)
setCount(count + 1)
```

### Context + Reducer Pattern

```typescript
type Action =
  | { type: 'SET_DATA'; payload: Data[] }
  | { type: 'SET_LOADING'; payload: boolean }

function reducer(state: State, action: Action): State {
  switch (action.type) {
    case 'SET_DATA':
      return { ...state, data: action.payload }
    case 'SET_LOADING':
      return { ...state, loading: action.payload }
    default:
      return state
  }
}

const DataContext = createContext<{
  state: State
  dispatch: Dispatch<Action>
} | undefined>(undefined)

function DataProvider({ children }: { children: React.ReactNode }) {
  const [state, dispatch] = useReducer(reducer, initialState)
  return (
    <DataContext.Provider value={{ state, dispatch }}>
      {children}
    </DataContext.Provider>
  )
}
```

## Conditional Rendering

```typescript
// GOOD: Clear conditional rendering
{isLoading && <Spinner />}
{error && <ErrorMessage error={error} />}
{data && <DataDisplay data={data} />}

// BAD: Ternary hell
{isLoading ? <Spinner /> : error ? <ErrorMessage /> : data ? <DataDisplay /> : null}
```

## Performance Optimization

### Memoization

```typescript
// useMemo for expensive computations
const sortedItems = useMemo(() => {
  return items.sort((a, b) => b.value - a.value)
}, [items])

// useCallback for functions passed to children
const handleClick = useCallback((id: string) => {
  setSelectedId(id)
}, [])

// React.memo for pure components
const ItemCard = React.memo<ItemCardProps>(({ item }) => {
  return <div className="card">{item.name}</div>
})
```

**Note:** React Compiler will automatically handle memoization in the future. Use manual memoization when precise control is needed.

### Code Splitting & Lazy Loading

```typescript
import { lazy, Suspense } from 'react'

const HeavyChart = lazy(() => import('./HeavyChart'))

function Dashboard() {
  return (
    <Suspense fallback={<Spinner />}>
      <HeavyChart data={data} />
    </Suspense>
  )
}
```

### Virtualization for Long Lists

Use `@tanstack/react-virtual` for lists with 100+ items:

```typescript
import { useVirtualizer } from '@tanstack/react-virtual'

function VirtualList({ items }: { items: Item[] }) {
  const parentRef = useRef<HTMLDivElement>(null)

  const virtualizer = useVirtualizer({
    count: items.length,
    getScrollElement: () => parentRef.current,
    estimateSize: () => 50,
    overscan: 5
  })

  return (
    <div ref={parentRef} style={{ height: '400px', overflow: 'auto' }}>
      <div style={{ height: `${virtualizer.getTotalSize()}px`, position: 'relative' }}>
        {virtualizer.getVirtualItems().map(virtualRow => (
          <div
            key={virtualRow.index}
            style={{
              position: 'absolute',
              top: 0,
              transform: `translateY(${virtualRow.start}px)`,
              height: `${virtualRow.size}px`
            }}
          >
            <ItemRow item={items[virtualRow.index]} />
          </div>
        ))}
      </div>
    </div>
  )
}
```

## Error Boundary

```typescript
class ErrorBoundary extends React.Component<
  { children: React.ReactNode; fallback: React.ReactNode },
  { hasError: boolean }
> {
  state = { hasError: false }

  static getDerivedStateFromError() {
    return { hasError: true }
  }

  componentDidCatch(error: Error, info: React.ErrorInfo) {
    console.error('Error caught:', error, info.componentStack)
  }

  render() {
    if (this.state.hasError) {
      return this.props.fallback
    }
    return this.props.children
  }
}

// Usage with Suspense
<ErrorBoundary fallback={<ErrorMessage />}>
  <Suspense fallback={<Loading />}>
    <AsyncComponent />
  </Suspense>
</ErrorBoundary>
```

## Accessibility

### useId for Accessible Forms

```typescript
import { useId } from 'react'

function PasswordField() {
  const hintId = useId()
  return (
    <>
      <label>
        Password:
        <input type="password" aria-describedby={hintId} />
      </label>
      <p id={hintId}>At least 8 characters required</p>
    </>
  )
}
```

### Focus Management

```typescript
function Modal({ isOpen, onClose, children }: ModalProps) {
  const modalRef = useRef<HTMLDivElement>(null)
  const previousFocusRef = useRef<HTMLElement | null>(null)

  useEffect(() => {
    if (isOpen) {
      previousFocusRef.current = document.activeElement as HTMLElement
      modalRef.current?.focus()
    } else {
      previousFocusRef.current?.focus()
    }
  }, [isOpen])

  if (!isOpen) return null

  return (
    <div
      ref={modalRef}
      role="dialog"
      aria-modal="true"
      tabIndex={-1}
      onKeyDown={e => e.key === 'Escape' && onClose()}
    >
      {children}
    </div>
  )
}
```

### Keyboard Navigation

```typescript
function Dropdown({ options, onSelect }: DropdownProps) {
  const [activeIndex, setActiveIndex] = useState(0)

  const handleKeyDown = (e: React.KeyboardEvent) => {
    switch (e.key) {
      case 'ArrowDown':
        e.preventDefault()
        setActiveIndex(i => Math.min(i + 1, options.length - 1))
        break
      case 'ArrowUp':
        e.preventDefault()
        setActiveIndex(i => Math.max(i - 1, 0))
        break
      case 'Enter':
        e.preventDefault()
        onSelect(options[activeIndex])
        break
    }
  }

  return (
    <div role="listbox" onKeyDown={handleKeyDown}>
      {/* options */}
    </div>
  )
}
```
