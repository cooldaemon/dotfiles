---
name: ruby-patterns
description: Ruby development patterns including package manager detection (Bundler), project structure, and idiomatic Ruby practices.
---

# Ruby Development Patterns

## Package Manager Detection (CRITICAL)

**Before running ANY Ruby commands, detect the package manager:**

| File | Package Manager | Install | Run |
|------|-----------------|---------|-----|
| `Gemfile.lock` | Bundler | `bundle install` | `bundle exec` |
| `Gemfile` (no lock) | Bundler | `bundle install` | `bundle exec` |
| None | gem/ruby | `gem install` | `ruby` |

**NEVER use `gem install` directly when Gemfile exists.**

### New Project Setup

When scaffolding a new Ruby project, always initialize with Bundler:

```bash
bundle init          # Creates Gemfile
# Edit Gemfile to add dependencies
bundle install       # Creates Gemfile.lock
```

For gem libraries, use `bundle gem mylib` to scaffold the full structure.

**Follow the existing project's Gemfile. Always use `bundle exec` to run commands.**

## Project Structure

```
myproject/
├── lib/                # Source code
│   ├── myproject.rb    # Main entry point
│   └── myproject/      # Namespace directory
│       ├── cli.rb
│       └── core.rb
├── spec/               # RSpec tests (preferred)
│   ├── spec_helper.rb
│   └── myproject/
│       └── core_spec.rb
├── bin/                # Executables
├── Gemfile
├── Gemfile.lock
├── Rakefile
└── Makefile
```

## CLI Structure

**Three-layer separation (same principle as Python):**

```ruby
# bin/myproject - Minimal bootstrap
#!/usr/bin/env ruby
require_relative "../lib/myproject/cli"
MyProject::CLI.run(ARGV)

# lib/myproject/cli.rb - CLI argument parsing only
require_relative "core"

module MyProject
  class CLI
    def self.run(args)
      result = Core.process(args.first)
      puts result
    end
  end
end

# lib/myproject/core.rb - Business logic (testable without CLI)
module MyProject
  class Core
    def self.process(input)
      # ...
    end
  end
end
```
