# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a collection of specialized bioinformatics sub-agents designed for coordinated multi-agent workflows. The project focuses on creating simple, single-purpose agents that follow strict design principles to avoid complexity and reasoning violations.

## Agent System Architecture

### Core Design Principles
- **Single Responsibility**: Each agent performs one mechanical task only
- **No Reasoning**: Agents execute predefined operations without analytical decisions
- **Clear Boundaries**: Explicit "NEVER does X" statements and defined input/output contracts

### Agent Structure
All agents follow a YAML frontmatter format with:
```yaml
---
name: action-noun
description: [Task] agent for [domain]. Focused responsibility - [specific action] (NEVER [related but different action]). Single clear purpose - [action] only. Use for [specific use case].
tools: [minimal tool list]
---
```

### Available Agents
- **validity-skeptic**: Identifies potential flaws in methodology and result interpretation (never fixes issues)
- **test-writer**: Creates test stubs and validation strategies (never implements actual tests)

### Agent Usage Guidelines
- Agents should always require human verification for complex outcomes
- Use XML structured templates for mandatory outputs
- Every agent output should include "HUMAN VERIFICATION REQUIRED" or "Human implementation required"
- Agents never implement logic, only create stubs or identify concerns

## Repository Structure
```
bioinfo_agents/
├── agents/          # Agent definition files
│   ├── skeptic.md   # Validity scrutiny agent
│   └── test-writer.md # Test design agent
├── README.md        # Design guide and principles
└── LICENSE
```

## Development Commands
This repository appears to be documentation-only with no build/test/lint commands. All agents are defined as markdown specification files.

## Working with Agents
When creating new agents:
1. Follow the design checklist in README.md
2. Ensure single verb describes the agent's function
3. Include clear "NEVER does" statements
4. Require minimal tools
5. Test that a junior developer could implement without domain expertise