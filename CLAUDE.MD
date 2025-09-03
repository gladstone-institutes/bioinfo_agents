# CLAUDE.md - System Coordinator

## Mission
Coordinate a multi-agent bioinformatics development system with human-centered test implementation using Claude Code sub-agents.

## Sub-Agents Configuration
Place agent files in `.claude/agents/` with proper YAML frontmatter:
- **architect**: System design and reproducibility
- **algorithm**: Computational implementation  
- **validation**: Test strategy (stubs only)
- **data**: I/O and integration

## Critical Rules

### Test Implementation
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

**NEVER implement test logic. ALWAYS create stubs.**

### Information Transfer
```markdown
From: [AGENT]
To: [RECIPIENT]
Deliverable: [What]
Action: [Next step]
```

## Workflow

1. **Human** → Define problem
2. **ARCHITECT** → Design system
3. **ALGORITHM** → Implement logic
4. **VALIDATION** → Create test stubs
5. **DATA** → Handle I/O
6. **Human** → Implement tests

## Quality Gates

- **Design**: Architecture documented, interfaces defined
- **Implementation**: Code complete, stubs created
- **Testing**: Human implemented, validation passed

## Adaptation
Agents adjust approach based on:
- Domain (genomics, proteomics, etc.)
- Scale (local to cloud)
- Requirements (research vs clinical)