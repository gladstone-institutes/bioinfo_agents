# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Development and improvement of bioinformatics sub-agents for coordinated multi-agent workflows with Claude Code. This repository contains agent definitions that can be deployed to `.claude/agents/` in bioinformatics projects to enable specialized, coordinated development workflows.

## Agent Architecture

The system uses 5 specialized agents located in `agents/`:

- **COMMS** (`agents/COMMS.md`): Communication coordinator that decides which sub-agents to invoke and manages information flow between agents
- **ARCHITECT** (`agents/ARCHITECT.md`): System design agent for creating reproducible bioinformatics architectures and defining module interfaces
- **ALGORITHM** (`agents/ALGORITHM.md`): Implementation agent for computational solutions and algorithm optimization
- **VALIDATION** (`agents/VALIDATION.md`): Test design agent that creates comprehensive test stubs but never implements test logic
- **DATA** (`agents/DATA.md`): Data management agent for handling biological data formats, I/O operations, and storage strategies

## Critical Workflow Rules

### Agent Coordination
1. Use COMMS agent to coordinate information flow between other agents
2. Each agent has specific YAML frontmatter defining name, description, and tools
3. Agents must be used PROACTIVELY when their domain expertise is needed

### Test Implementation Policy
**NEVER implement test logic. ALWAYS create stubs using this exact template:**

```python
def test_name():
    """
    Test: [What to test]
    Context: [Why it matters]
    
    TODO (HUMAN IMPLEMENTATION REQUIRED):
    1. [Action steps]
    
    Resources: [What's needed]
    """
    raise NotImplementedError("Human implementation required")
```

### Information Transfer Format
Use this format when passing information between agents:

```markdown
From: [AGENT]
To: [RECIPIENT] 
Deliverable: [What]
Action: [Next step]
```

## Development Workflow

1. **Human** defines biological problem
2. **ARCHITECT** designs system architecture and interfaces
3. **ALGORITHM** implements computational logic
4. **VALIDATION** creates test stubs (never implements)
5. **DATA** handles I/O and data management
6. **Human** implements all test logic from stubs

## Agent Usage Guidelines

### When to Use Each Agent
- **COMMS**: Starting projects, coordinating between agents, managing workflow
- **ARCHITECT**: System design, module interfaces, reproducibility planning
- **ALGORITHM**: Core computational implementation, performance optimization
- **VALIDATION**: Test strategy design, validation framework creation
- **DATA**: File I/O, data parsing, storage strategies, pipeline integration

### Quality Gates
- **Design**: Architecture documented, interfaces defined
- **Implementation**: Code complete, test stubs created  
- **Testing**: Human-implemented tests pass validation

## Agent Development

### Improving Agents
When modifying agents in `agents/`:
- Maintain YAML frontmatter structure (name, description, tools)
- Keep agent roles focused and non-overlapping
- Preserve the human-in-the-loop testing philosophy
- Test agent improvements in real bioinformatics projects

### Testing Agent Changes
- Deploy modified agents to `.claude/agents/` in a test project
- Verify agent coordination through COMMS agent
- Ensure test stub generation remains consistent
- Document any breaking changes to agent interfaces

## Deployment
To use these agents in bioinformatics projects:
1. Copy the `agents/` folder to `.claude/agents/` in your target project
2. Modify agent configurations for domain-specific needs
3. Update the target project's CLAUDE.md to reflect customizations