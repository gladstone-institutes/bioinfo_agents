#!/bin/bash

# Safe Bioinformatics Agents Deployment Script
# Usage: ./bioinfo_agents_temp/deploy.sh (from project root)

set -e

echo "🧬 Deploying Bioinformatics Agents..."

# Safety checks
if [[ ! -d "agents" ]]; then
    echo "ERROR: agents/ directory not found. Run this from the cloned repo directory."
    exit 1
fi

TEMP_DIR=$(basename "$(pwd)")
if [[ ! "$TEMP_DIR" =~ bioinfo_agents ]]; then
    echo "WARNING: Expected to be in bioinfo_agents directory, found: $TEMP_DIR"
    read -p "Continue anyway? (y/N): " confirm
    [[ ! "$confirm" =~ ^[Yy]$ ]] && exit 1
fi

# Detect codebase type in parent directory (actual project)
cd ..
PROJECT_DIR=$(pwd)
echo "Deploying to project: $PROJECT_DIR"

code_files=$(find . -name "$TEMP_DIR" -prune -o \( -name "*.py" -o -name "*.R" -o -name "*.java" -o -name "*.js" -o -name "*.go" -o -name "*.rs" \) -print | wc -l)
if [[ $code_files -gt 50 ]]; then
    CODEBASE_TYPE="existing"
    echo "Detected: Existing codebase ($code_files files)"
else
    CODEBASE_TYPE="new"  
    echo "Detected: New project"
fi

# Create .claude/agents directory
mkdir -p .claude/agents
echo "Created .claude/agents directory"

# Copy agents from temp directory
cp "$TEMP_DIR/agents"/*.md .claude/agents/
echo "Copied agents to .claude/agents/"

# Create workspace structure
mkdir -p .agent_workspace/{coordination,architecture,implementation,data}
mkdir -p .agent_workspace/coordination/{agent_handoffs,status_reports}
mkdir -p .agent_workspace/implementation/{algorithms,modules}
mkdir -p .agent_workspace/data/{raw,processed,cache,metadata,parsers,integrations}
echo "Created .agent_workspace structure"

# Append to CLAUDE.md (or create if missing)
cat >> CLAUDE.md << 'EOF'

## Bioinformatics Agents System

This project uses 5 specialized bioinformatics agents for coordinated development workflows:

- **COMMS** (`.claude/agents/COMMS.md`): Communication coordinator for multi-agent workflows
- **ARCHITECT** (`.claude/agents/ARCHITECT.md`): System design and reproducible architecture  
- **ALGORITHM** (`.claude/agents/ALGORITHM.md`): Implementation with nf-core integration priority
- **VALIDATION** (`.claude/agents/VALIDATION.md`): Test design agent (creates stubs, never implements)
- **DATA** (`.claude/agents/DATA.md`): Data management and biological I/O operations

### Agent Coordination Workflow

1. **Human** defines biological problem
2. **COMMS** analyzes and coordinates agent sequence
3. **ARCHITECT** designs system architecture  
4. **ALGORITHM** searches nf-core then implements
5. **DATA** handles biological data formats and I/O
6. **VALIDATION** creates comprehensive test stubs
7. **Human** implements test logic from stubs

### Usage Examples

```bash
# Start new project coordination
claude --agent comms "Design RNA-seq differential expression pipeline"

# Architecture design
claude --agent architect "Create reproducible genomics workflow architecture"

# Algorithm implementation  
claude --agent algorithm "Implement variant calling with nf-core integration"

# Data handling
claude --agent data "Design FASTQ processing pipeline with validation"

# Test strategy
claude --agent validation "Create comprehensive test stubs for proteomics workflow"
```

### Agent Workspace

All agent outputs organized in `.agent_workspace/`:
- `coordination/`: Project plans, agent handoffs, status reports
- `architecture/`: System design, interface specs, resource plans
- `implementation/`: Algorithm code, modules, nf-core integrations
- `data/`: Raw/processed data, parsers, integrations, metadata

EOF

# Add codebase-specific adaptations
if [[ "$CODEBASE_TYPE" == "existing" ]]; then
    cat >> CLAUDE.md << 'EOF'

### Existing Codebase Integration Mode

Agents adapt for enhancing existing systems:

- **COMMS**: Analyzes current architecture before coordinating improvements
- **ARCHITECT**: Focuses on refactoring and incremental enhancements  
- **ALGORITHM**: Evaluates existing code for nf-core migration opportunities
- **DATA**: Enhances current data handling with compatibility priority
- **VALIDATION**: Retrofits testing to existing code with gradual coverage

**Integration Approach**: Incremental improvements, compatibility first, risk-assessed changes

EOF
else
    cat >> CLAUDE.md << 'EOF'

### New Project Development Mode  

Agents optimized for greenfield development:

- **COMMS**: Full orchestration from requirements to implementation
- **ARCHITECT**: Optimal system design with best practices from start
- **ALGORITHM**: nf-core first approach, modern implementation patterns
- **DATA**: Design optimal data architecture without legacy constraints  
- **VALIDATION**: Comprehensive test strategy from project inception

**Development Approach**: Best practices foundation, modern standards, future-proofing

EOF
fi

# Add testing philosophy and quality gates
cat >> CLAUDE.md << 'EOF'

### Critical Testing Philosophy

**VALIDATION agent creates stubs but NEVER implements tests:**

```python
def test_biological_accuracy():
    """
    Test: [Specific biological validation]
    Context: [Scientific importance]
    
    TODO (HUMAN IMPLEMENTATION REQUIRED):
    1. [Detailed implementation steps]
    
    Resources: [Required data/tools]
    Success: [Measurable criteria]
    """
    raise NotImplementedError("Human implementation required")
```

### Quality Gates

- **Design**: Architecture documented, interfaces defined
- **Implementation**: Code complete, nf-core integration verified
- **Testing**: Human-implemented tests pass biological validation

### Agent Communication

Agents use structured XML prompts with:
- Role-based expertise definitions
- Chain-of-thought reasoning ("Think step by step")
- Multishot examples for consistency
- Explicit output formats
- Context isolation via Task tool

EOF

echo "Updated CLAUDE.md with agent system documentation"

# Create safe cleanup script
cat > cleanup-bioinfo-agents.sh << EOF
#!/bin/bash
echo "🗑️  Cleaning up bioinformatics agents temp directory..."
if [[ -d "$TEMP_DIR" ]]; then
    rm -rf "$TEMP_DIR"
    echo "✅ Removed $TEMP_DIR"
    rm -f cleanup-bioinfo-agents.sh
    echo "✅ Cleanup complete!"
else
    echo "⚠️  Directory $TEMP_DIR not found (already removed?)"
fi
EOF

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📁 Agents deployed to: .claude/agents/"
echo "📁 Workspace created: .agent_workspace/"
echo "📄 Documentation added to: CLAUDE.md"
echo ""
echo "🗑️  To remove temp files, run: ./cleanup-bioinfo-agents.sh"
echo ""
echo "Next steps:"
echo "1. Start with: claude --agent comms \"[describe your biological project]\""
echo "2. Check .agent_workspace/ for organized outputs"
echo "3. Implement test stubs created by VALIDATION agent"