---
name: vue-patterns
description: Vue 3 Composition API patterns including components, composables, state management, and TypeScript integration.
---

# Vue 3 Patterns

Patterns for Vue 3 with Composition API and TypeScript.

## Component Patterns

### Props with TypeScript

```vue
<script setup lang="ts">
interface Book {
  title: string
  author: string
  year: number
}

const props = defineProps<{
  book: Book
  isActive?: boolean  // optional prop
}>()
</script>
```

### Props with Defaults

```vue
<script setup lang="ts">
interface Props {
  msg?: string
  count?: number
}

const props = withDefaults(defineProps<Props>(), {
  msg: 'hello',
  count: 0
})
</script>
```

### Emits with TypeScript

```vue
<script setup lang="ts">
// Vue 3.3+ named tuple syntax (recommended)
const emit = defineEmits<{
  change: [id: number]
  update: [value: string]
}>()

// Usage
emit('change', 123)
emit('update', 'new value')
</script>
```

### Two-Way Binding with defineModel

```vue
<!-- Child component -->
<script setup lang="ts">
// Basic v-model
const model = defineModel<string>()

// Named v-model with options
const count = defineModel<number>('count', { default: 0 })
</script>

<template>
  <input v-model="model" />
  <button @click="count++">Count: {{ count }}</button>
</template>
```

```vue
<!-- Parent component -->
<template>
  <MyInput v-model="text" v-model:count="counter" />
</template>
```

### Slots with TypeScript

```vue
<script setup lang="ts">
defineSlots<{
  default: (props: { item: string }) => any
  header?: () => any
}>()
</script>

<template>
  <header>
    <slot name="header" />
  </header>
  <main>
    <slot :item="currentItem" />
  </main>
</template>
```

## Composables

### Basic Composable Pattern

```typescript
// composables/useMouse.ts
import { ref, onMounted, onUnmounted } from 'vue'

export function useMouse() {
  const x = ref(0)
  const y = ref(0)

  function update(event: MouseEvent) {
    x.value = event.pageX
    y.value = event.pageY
  }

  onMounted(() => window.addEventListener('mousemove', update))
  onUnmounted(() => window.removeEventListener('mousemove', update))

  return { x, y }
}

// Usage in component
const { x, y } = useMouse()
```

### Async Composable with Reactive Input

```typescript
// composables/useFetch.ts
import { ref, watchEffect, toValue, type MaybeRefOrGetter } from 'vue'

export function useFetch<T>(url: MaybeRefOrGetter<string>) {
  const data = ref<T | null>(null)
  const error = ref<Error | null>(null)
  const isLoading = ref(false)

  watchEffect(async () => {
    data.value = null
    error.value = null
    isLoading.value = true

    try {
      const res = await fetch(toValue(url))
      data.value = await res.json()
    } catch (err) {
      error.value = err as Error
    } finally {
      isLoading.value = false
    }
  })

  return { data, error, isLoading }
}

// Usage - reactive URL
const url = computed(() => `/api/users/${userId.value}`)
const { data, error, isLoading } = useFetch<User>(url)
```

### useToggle

```typescript
import { ref } from 'vue'

export function useToggle(initialValue = false) {
  const value = ref(initialValue)
  const toggle = () => { value.value = !value.value }
  return { value, toggle }
}

// Usage
const { value: isOpen, toggle: toggleOpen } = useToggle()
```

### useDebounce

```typescript
import { ref, watch, type Ref } from 'vue'

export function useDebounce<T>(source: Ref<T>, delay = 300) {
  const debounced = ref(source.value) as Ref<T>

  let timeout: ReturnType<typeof setTimeout>

  watch(source, (newValue) => {
    clearTimeout(timeout)
    timeout = setTimeout(() => {
      debounced.value = newValue
    }, delay)
  })

  return debounced
}

// Usage
const searchQuery = ref('')
const debouncedQuery = useDebounce(searchQuery, 500)
```

## State Management

### ref vs reactive

```typescript
import { ref, reactive } from 'vue'

// ref: for primitives and single values
const count = ref(0)
count.value++  // need .value

// reactive: for objects (no .value needed)
const state = reactive({
  count: 0,
  items: []
})
state.count++  // no .value needed

// PREFER ref for consistency and clarity
// - Always know when you're dealing with reactive state (.value)
// - Easier to destructure and pass around
```

### Provide / Inject (Dependency Injection)

```typescript
// types/injection-keys.ts
import type { InjectionKey, Ref } from 'vue'

export interface UserContext {
  user: Ref<User | null>
  login: (credentials: Credentials) => Promise<void>
  logout: () => void
}

export const UserKey: InjectionKey<UserContext> = Symbol('user')
```

```vue
<!-- Provider component -->
<script setup lang="ts">
import { provide, ref } from 'vue'
import { UserKey, type UserContext } from '@/types/injection-keys'

const user = ref<User | null>(null)

const context: UserContext = {
  user,
  login: async (credentials) => { /* ... */ },
  logout: () => { user.value = null }
}

provide(UserKey, context)
</script>
```

```vue
<!-- Consumer component -->
<script setup lang="ts">
import { inject } from 'vue'
import { UserKey } from '@/types/injection-keys'

const userContext = inject(UserKey)
if (!userContext) {
  throw new Error('UserContext not provided')
}

const { user, logout } = userContext
</script>
```

## Reactivity

### computed

```typescript
import { ref, computed } from 'vue'

const firstName = ref('John')
const lastName = ref('Doe')

// Read-only computed
const fullName = computed(() => `${firstName.value} ${lastName.value}`)

// Writable computed
const fullNameWritable = computed({
  get: () => `${firstName.value} ${lastName.value}`,
  set: (value: string) => {
    const [first, last] = value.split(' ')
    firstName.value = first
    lastName.value = last ?? ''
  }
})
```

### watch vs watchEffect

```typescript
import { ref, watch, watchEffect } from 'vue'

const count = ref(0)
const name = ref('Vue')

// watch: explicit sources, access old value
watch(count, (newValue, oldValue) => {
  console.log(`count changed from ${oldValue} to ${newValue}`)
})

// watch: multiple sources
watch([count, name], ([newCount, newName], [oldCount, oldName]) => {
  console.log('count or name changed')
})

// watchEffect: auto-tracks dependencies, runs immediately
watchEffect(() => {
  console.log(`count is ${count.value}`)  // auto-tracked
})
```

### Shallow Reactivity for Performance

```typescript
import { shallowRef, triggerRef } from 'vue'

// Large objects: use shallowRef to avoid deep reactivity
const largeList = shallowRef<Item[]>([])

// Manually trigger update after mutation
largeList.value.push(newItem)
triggerRef(largeList)

// Or replace entirely (preferred)
largeList.value = [...largeList.value, newItem]
```

## Template Patterns

### Conditional Rendering

```vue
<template>
  <!-- GOOD: Clear conditions -->
  <LoadingSpinner v-if="isLoading" />
  <ErrorMessage v-else-if="error" :error="error" />
  <DataDisplay v-else :data="data" />

  <!-- v-show: for frequent toggles (keeps element in DOM) -->
  <Panel v-show="isPanelVisible" />
</template>
```

### List Rendering

```vue
<template>
  <!-- Always use :key with unique identifier -->
  <ul>
    <li v-for="item in items" :key="item.id">
      {{ item.name }}
    </li>
  </ul>

  <!-- Avoid v-if with v-for - use computed instead -->
  <ul>
    <li v-for="item in activeItems" :key="item.id">
      {{ item.name }}
    </li>
  </ul>
</template>

<script setup lang="ts">
const activeItems = computed(() =>
  items.value.filter(item => item.isActive)
)
</script>
```

### Template Refs

```vue
<script setup lang="ts">
import { ref, onMounted } from 'vue'

const inputRef = ref<HTMLInputElement | null>(null)

onMounted(() => {
  inputRef.value?.focus()
})
</script>

<template>
  <input ref="inputRef" />
</template>
```

### Component Refs

```vue
<script setup lang="ts">
import { ref } from 'vue'
import MyComponent from './MyComponent.vue'

const componentRef = ref<InstanceType<typeof MyComponent> | null>(null)

function callChildMethod() {
  componentRef.value?.exposedMethod()
}
</script>

<template>
  <MyComponent ref="componentRef" />
</template>
```

```vue
<!-- MyComponent.vue - expose methods to parent -->
<script setup lang="ts">
function exposedMethod() {
  // ...
}

defineExpose({ exposedMethod })
</script>
```

## Performance

### Lazy Loading Components

```typescript
import { defineAsyncComponent } from 'vue'

const HeavyChart = defineAsyncComponent(() =>
  import('./HeavyChart.vue')
)

// With loading and error states
const AsyncComponent = defineAsyncComponent({
  loader: () => import('./HeavyComponent.vue'),
  loadingComponent: LoadingSpinner,
  errorComponent: ErrorDisplay,
  delay: 200,
  timeout: 3000
})
```

### v-memo for Expensive Lists

```vue
<template>
  <!-- Only re-render when item.id or selected changes -->
  <div v-for="item in list" :key="item.id" v-memo="[item.id, selected === item.id]">
    <p>ID: {{ item.id }} - selected: {{ selected === item.id }}</p>
  </div>
</template>
```

### v-once for Static Content

```vue
<template>
  <!-- Rendered once, never updated -->
  <footer v-once>
    <p>Copyright 2024 My Company</p>
  </footer>
</template>
```

## Accessibility

### Focus Management

```vue
<script setup lang="ts">
import { ref, watch, nextTick } from 'vue'

const isModalOpen = ref(false)
const modalRef = ref<HTMLDivElement | null>(null)
const previousFocus = ref<HTMLElement | null>(null)

watch(isModalOpen, async (open) => {
  if (open) {
    previousFocus.value = document.activeElement as HTMLElement
    await nextTick()
    modalRef.value?.focus()
  } else {
    previousFocus.value?.focus()
  }
})
</script>

<template>
  <div
    v-if="isModalOpen"
    ref="modalRef"
    role="dialog"
    aria-modal="true"
    tabindex="-1"
    @keydown.escape="isModalOpen = false"
  >
    <!-- modal content -->
  </div>
</template>
```

### Accessible Form Fields

```vue
<script setup lang="ts">
import { useId } from 'vue'

const inputId = useId()
const hintId = useId()
</script>

<template>
  <div>
    <label :for="inputId">Email</label>
    <input
      :id="inputId"
      type="email"
      :aria-describedby="hintId"
    />
    <p :id="hintId">We'll never share your email</p>
  </div>
</template>
```
