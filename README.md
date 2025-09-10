# Bioinformatics Agents for Claude Code

A collection of specialized bioinformatics sub-agents designed for coordinated multi-agent workflows with Claude Code.

# Subagent Design Guide

## Core Principles

### 1. Single Responsibility
- One mechanical task only
- Never combine multiple capabilities
- Clear verb-based naming: "File Watcher", "Code Generator", "Schema Enforcer"

### 2. No Reasoning
- Execute predefined operations only
- Never make analytical decisions
- Never interpret context or meaning
- Avoid "evaluation", "analysis", "research"

### 3. Clear Boundaries
- Explicit "NEVER does X" statements
- Defined input/output contracts
- No decision-making authority
- Always require human verification for complex outcomes

## Design Template

```yaml
---
name: action-noun
description: [Task] agent for [domain]. Focused responsibility - [specific action] (NEVER [related but different action]). Single clear purpose - [action] only. Use for [specific use case].
tools: [minimal tool list]
---
```

## Good Examples

**URL Extractor Agent**
- Does: Extracts URLs from text or documents
- Never: Validates URLs or analyzes link quality
- Single purpose: URL pattern matching

**Environment Reader Agent**
- Does: Detects system environment details (language versions, tool paths, OS info)
- Never: Recommends upgrades or interprets compatibility issues
- Single purpose: System environment detection

## Bad Examples

**Algorithm Expert Agent** (violates multiple principles)
- Problem: Research + planning + implementation + testing
- Fix: Split into "Code Generator" (implementation only)

**Data Analyzer Agent** (requires reasoning)
- Problem: "Analyzes data and provides insights"
- Fix: "Log Parser" (extracts structured info only)

## Red Flags

### Scope Creep Indicators
- Multiple verbs in description
- "And" in responsibility statements
- Planning or strategy components
- Research requirements

### Reasoning Violations
- Decision trees
- Comparative evaluation
- Context interpretation
- Methodology selection

### Boundary Violations
- Unclear handoff points
- No "NEVER does" statements
- Multiple tool categories
- Complex output formats

## Design Checklist

- [ ] Single verb describes the agent's function
- [ ] "NEVER does" statement is clear and specific
- [ ] No reasoning or decision-making required
- [ ] Clear input/output specification
- [ ] Minimal tool requirements
- [ ] Obvious when to use this agent
- [ ] Cannot be confused with human responsibilities

## Quick Test

**Ask yourself:**
1. Could a junior developer implement this without domain expertise?
2. Is the output predictable given the same input?
3. Does it require zero analytical judgment?
4. Would you be comfortable with this running automatically?

If any answer is "no", the agent needs simplification.

## Creating Subagents

### File Structure

Subagents are defined as Markdown files in the `.claude/agents/` directory, either in your project directory or your user home directory:
```
.claude/agents/
├── agent-name.md        
```

1. Project directory (.claude/agents/) - **Highest priority**
2. User directory (~/.claude/agents/) - Lower priority

If you want to project specific behaviors then copy your subagents into the project directory and then customize.

### Easy Subagent Creation

Use the claude code `/agents` to create and manage agents. You can have claude create a subagent from a prompt and then customize it to your needs.


### YAML Frontmatter Format

Every agent file starts with YAML frontmatter:

```yaml
---
name: agent-name                 # Required: kebab-case identifier
description: [Task] agent for [domain]. Focused responsibility - [specific action] (NEVER [related but different action]). Single clear purpose - [action] only. Use for [specific use case].  # Required: follows template
tools: Read, Write, Edit, Bash   # Required: minimal tool list
color: cyan                      # Optional: display color
model: inherit                   # Optional: model configuration
---
```

### Content Structure

After the frontmatter, structure your agent with:

1. **Role Definition**: Clear statement of what the agent does
2. **Critical Rule**: The core constraint (usually "NEVER does X")
3. **Primary Tasks**: Specific operations the agent performs
4. **Templates**: XML-structured mandatory outputs
5. **Examples**: Concrete usage demonstrations
6. **Key Principles**: Reinforcement of boundaries

### Step-by-Step Creation Process

1. **Choose a Single Action**: Pick one mechanical task (e.g., "parse", "extract", "generate")

2. **Create the File**: Create `agents/your-agent.md`

3. **Write Frontmatter**: Use the template above, following existing patterns

4. **Define Boundaries**: Include clear "NEVER does" statements

5. **Create Templates**: Provide XML-structured output formats

6. **Add Examples**: Show concrete usage scenarios

7. **Test Integration**: Verify the agent works with Claude Code's Task tool

### Integration with Claude Code

Agents integrate through the Task tool's `subagent_type` parameter:

### Examples in This Repository

- **test-writer**: Creates test stubs (never implements actual tests)
- **log-parser**: Extracts structured data (never analyzes trends)
- **todo-scanner**: Finds TODO comments (comprehensive pattern matching)

Each agent demonstrates different aspects of the design principles while maintaining strict single-purpose focus.