# Bioinformatics Agents for Claude Code

A collection of specialized bioinformatics sub-agents designed for coordinated multi-agent workflows with Claude Code. These agents provide intelligent, domain-aware assistance for bioinformatics development projects.

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
- Avoid "evaluation", "analysis", "research", "planning"

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

**File Watcher Agent**
- Does: Detects file changes, triggers notifications
- Never: Processes file contents, makes decisions about changes
- Single purpose: File event detection

**Checksum Generator Agent**
- Does: Generates and compares checksums
- Never: Determines data quality or interprets results
- Single purpose: Checksum operations

**Test Writer Agent**
- Does: Creates test stubs and templates
- Never: Implements actual tests or logic
- Single purpose: Test stub generation

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