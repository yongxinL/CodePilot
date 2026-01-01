#!/bin/bash

# CodePilot-OpenCode Complete v1.0
# Ready-to-use automated development system for OpenCode

set -e

echo "🚀 Initializing CodePilot-OpenCode..."
echo ""

# Create directory structure
mkdir -p docs/{prompts,templates,subagents,core,artifacts,knowledge-base}
mkdir -p docs/artifacts/{phase1-requirements,phase2-planning,phase3-implementation,phase4-verification,phase5-master,handoffs}
mkdir -p docs/knowledge-base/{patterns,lessons,metrics}
mkdir -p docs/templates

echo "✅ Directory structure created"
echo ""

# Create .gitignore
cat > .gitignore << 'EOF'
# Artifacts (optional - remove if you want to track)
# docs/artifacts/

# Environment files
.env
.env.local

# OS files
.DS_Store
Thumbs.db

# Editor files
.vscode/
.idea/
*.swp
*.swo
*~

# Logs
*.log
EOF

echo "✅ Created .gitignore"
echo ""

echo "✨ CodePilot-OpenCode initialization complete!"
echo ""
echo "📋 Next Steps:"
echo "1. Authenticate: opencode auth login"
echo "2. Start building: opencode --agent requirements"
echo "3. Read README.md for complete documentation"
echo ""
echo "🎯 Quick Start:"
echo '   opencode --agent requirements "Build a [your project idea]"'
echo ""
echo "🚀 Ready to build!"
