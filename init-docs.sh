#!/bin/bash

# CodePilot for OpenCode v2.0
# Complete automated development system with 4-tier configuration

set -e

echo "🚀 Initializing CodePilot for OpenCode v2.0"
echo ""
echo "========================================="
echo "  Complete Automated Development System"
echo "  38 Features | 4 Tiers | MCP-Enabled"
echo "========================================="
echo ""

# Create directory structure
echo "📁 Creating directory structure..."
mkdir -p docs/{prompts,templates,subagents,core,artifacts,knowledge-base,guides}
mkdir -p docs/artifacts/{phase1-requirements,phase2-planning,phase3-implementation,phase4-verification,phase5-master,handoffs,.recovery,cross-cutting}
mkdir -p docs/artifacts/phase2-planning/tasks
mkdir -p docs/knowledge-base/{patterns,lessons,metrics,decisions}
mkdir -p docs/templates/{phase1,phase2,phase3,phase4,phase5,cross-cutting}
echo "✅ Directory structure created"
echo ""

# Detect MCP tools
echo "🔍 Detecting MCP tools..."
mcp_tools_available=()

# Check for Context7
if command -v context7 &> /dev/null || [ -f "$(which context7 2>/dev/null)" ]; then
    echo "  ✅ Context7 detected"
    mcp_tools_available+=("context7")
else
    echo "  ⚠️  Context7 not found"
fi

# web_search is OpenCode built-in
echo "  ✅ web_search available (OpenCode built-in)"
mcp_tools_available+=("web_search")

echo ""

# Tier selection
echo "📊 Select your feature tier:"
echo ""
echo "  [1] MINIMAL   - 12.5K tokens - Baseline (learning, prototypes)"
echo "      • 31 features"
echo "      • No git, no MCP, no checkpoints"
echo ""
echo "  [2] CORE+     - 15.0K tokens - Professional (RECOMMENDED) ⭐"
echo "      • 49 features (+58%)"
echo "      • Locked specs, skill assessment, git (manual), MCP (manual)"
echo "      • Individual task files, checkpoints, quality gates"
echo "      • Best ROI - Start here!"
echo ""
echo "  [3] ADVANCED+ - 17.5K tokens - Enterprise"
echo "      • 57 features (+84%)"
echo "      • Everything in Core+ PLUS:"
echo "      • Git automation, MCP automation, knowledge base"
echo "      • Performance benchmarks, security scans, metrics"
echo ""
echo "  [4] FULL      - 20.0K tokens - Portfolio Management"
echo "      • 61 features (+97%)"
echo "      • Everything in Advanced+ PLUS:"
echo "      • Portfolio view, resource allocation, data interpreter"
echo ""
read -p "Choice [1-4, default=2]: " tier_choice
tier_choice=${tier_choice:-2}

# Map choice to tier name
case $tier_choice in
  1) tier_name="minimal" ;;
  2) tier_name="core" ;;
  3) tier_name="advanced" ;;
  4) tier_name="full" ;;
  *) echo "Invalid choice, defaulting to Core+"; tier_name="core" ;;
esac

echo ""
echo "Selected: ${tier_name} tier"
echo ""

# Git integration (if Core+ or higher)
git_enabled="false"
git_mode="manual"

if [ "$tier_choice" -ge 2 ]; then
    echo "⚙️  Git Integration:"
    echo "  [Y] Yes - Manual mode (you run commands) [Core+]"
    if [ "$tier_choice" -ge 3 ]; then
        echo "  [A] Yes - Automatic mode (agent commits) [Advanced+]"
    fi
    echo "  [N] No - Disable git integration"
    echo ""
    read -p "Choice [Y/A/N, default=Y]: " git_choice
    git_choice=${git_choice:-Y}
    
    case $git_choice in
      [Yy]*)
        git_enabled="true"
        git_mode="manual"
        echo "  ✅ Git integration: Manual mode"
        ;;
      [Aa]*)
        if [ "$tier_choice" -ge 3 ]; then
            git_enabled="true"
            git_mode="automatic"
            echo "  ✅ Git integration: Automatic mode"
        else
            echo "  ⚠️  Automatic mode requires Advanced+ tier, using Manual"
            git_enabled="true"
            git_mode="manual"
        fi
        ;;
      [Nn]*)
        git_enabled="false"
        echo "  ⚠️  Git integration: Disabled"
        ;;
    esac
    echo ""
fi

# MCP configuration
mcp_enabled="false"
mcp_auto="false"
mcp_preferred="web_search"

if [ "$tier_choice" -ge 2 ] && [ ${#mcp_tools_available[@]} -gt 0 ]; then
    echo "🔌 MCP Version Checking:"
    echo "  Detected: ${mcp_tools_available[*]}"
    echo ""
    echo "  [Y] Yes - Manual checks (you request) [Core+]"
    if [ "$tier_choice" -ge 3 ]; then
        echo "  [A] Yes - Automatic checks (agent triggers) [Advanced+]"
    fi
    echo "  [N] No - Use knowledge cutoff only"
    echo ""
    read -p "Choice [Y/A/N, default=Y]: " mcp_choice
    mcp_choice=${mcp_choice:-Y}
    
    case $mcp_choice in
      [Yy]*)
        mcp_enabled="true"
        mcp_auto="false"
        if [[ " ${mcp_tools_available[*]} " =~ " context7 " ]]; then
            mcp_preferred="context7"
        fi
        echo "  ✅ MCP: Manual mode (preferred: $mcp_preferred)"
        ;;
      [Aa]*)
        if [ "$tier_choice" -ge 3 ]; then
            mcp_enabled="true"
            mcp_auto="true"
            if [[ " ${mcp_tools_available[*]} " =~ " context7 " ]]; then
                mcp_preferred="context7"
            fi
            echo "  ✅ MCP: Automatic mode (preferred: $mcp_preferred)"
        else
            echo "  ⚠️  Automatic mode requires Advanced+ tier, using Manual"
            mcp_enabled="true"
            mcp_auto="false"
        fi
        ;;
      [Nn]*)
        mcp_enabled="false"
        echo "  ⚠️  MCP: Disabled"
        ;;
    esac
    echo ""
fi

# Generate configuration
echo "📝 Generating configuration..."

cat > .codepilot.config.json << EOF
{
  "version": "2.0.0",
  "last_updated": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "feature_tier": "$tier_name",
  "git_integration": {
    "enabled": $git_enabled,
    "mode": "$git_mode",
    "commit_on_phase_complete": true,
    "commit_per_task": $([ "$git_mode" = "automatic" ] && echo "true" || echo "false")
  },
  "mcp_tools": {
    "available": ["${mcp_tools_available[0]}", "${mcp_tools_available[1]}"],
    "version_checking": {
      "enabled": $mcp_enabled,
      "auto_check": $mcp_auto,
      "preferred_mcp": "$mcp_preferred",
      "check_security_advisories": $([ "$tier_choice" -ge 3 ] && echo "true" || echo "false")
    }
  },
  "individual_task_files": $([ "$tier_choice" -ge 2 ] && echo "true" || echo "false"),
  "checkpoints": { "enabled": $([ "$tier_choice" -ge 2 ] && echo "true" || echo "false") },
  "knowledge_base": { "enabled": $([ "$tier_choice" -ge 3 ] && echo "true" || echo "false") },
  "portfolio": { "enabled": $([ "$tier_choice" -ge 4 ] && echo "true" || echo "false") },
  "optional_agents": {
    "version_checker": $([ "$tier_choice" -ge 3 ] && echo "true" || echo "false"),
    "data_interpreter": $([ "$tier_choice" -ge 4 ] && echo "true" || echo "false")
  }
}
EOF

echo "✅ Configuration created"
echo ""

# Create .gitignore
cat > .gitignore << 'GITIGNORE'
docs/artifacts/.recovery/
.env
.env.local
.DS_Store
*.log
GITIGNORE

echo "✅ Created .gitignore"
echo ""
echo "✨ Initialization complete!"
echo ""
echo "Tier: ${tier_name}"
echo "Git: $([ "$git_enabled" = "true" ] && echo "✅ $git_mode" || echo "❌ disabled")"
echo "MCP: $([ "$mcp_enabled" = "true" ] && echo "✅ $mcp_preferred" || echo "❌ disabled")"
echo ""
echo "🎯 Quick Start: opencode --agent requirements"
