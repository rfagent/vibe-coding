#!/bin/bash

# Complete Vite React Project Creator and Builder
# Usage: ./script.sh [project-name] [--build-only]

set -e  # Exit on any error

PROJECT_NAME=${1:-"my-vite-project"}
BUILD_ONLY=${2:-""}

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to create project from scratch
create_project() {
    print_status "Creating new Vite React project: $PROJECT_NAME"
    
    # Create project directory
    mkdir -p "$PROJECT_NAME"
    cd "$PROJECT_NAME"
    
    # Create package.json
    print_status "Creating package.json..."
    cat > package.json << 'EOF'
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "devDependencies": {
    "vite": "^5.4.0"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1"
  }
}
EOF

    # Create index.html
    print_status "Creating index.html..."
    cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vite ReactApp</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="src/index.jsx"></script>
  </body>
</html>
EOF

    # Create src directory and files
    print_status "Creating src directory structure..."
    mkdir -p src/components

    # Create index.jsx
    cat > src/index.jsx << 'EOF'
import React, { StrictMode } from 'react';  
import { createRoot } from 'react-dom/client';
import App from './components/App';     

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <App />
  </StrictMode>,
);
EOF

    # Create App.jsx
    cat > src/components/App.jsx << 'EOF'
import React, { useState } from 'react';

const App = () => {
  const [count, setCount] = useState(0);

  return (
    <div style={{ 
      minHeight: '100vh', 
      background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      fontFamily: 'Arial, sans-serif'
    }}>
      <div style={{ 
        textAlign: 'center', 
        color: 'white',
        background: 'rgba(255,255,255,0.1)',
        padding: '2rem',
        borderRadius: '1rem',
        backdropFilter: 'blur(10px)'
      }}>
        <h1 style={{ fontSize: '3rem', marginBottom: '1rem' }}>
          🚀 Vite + React
        </h1>
        <p style={{ fontSize: '1.2rem', marginBottom: '2rem', opacity: 0.9 }}>
          Fast development with hot module replacement
        </p>
        
        <div style={{ marginBottom: '2rem' }}>
          <button 
            onClick={() => setCount(count - 1)}
            style={{
              background: '#ef4444',
              color: 'white',
              border: 'none',
              padding: '0.75rem 1.5rem',
              margin: '0 0.5rem',
              borderRadius: '0.5rem',
              fontSize: '1.2rem',
              cursor: 'pointer'
            }}
          >
            -
          </button>
          
          <span style={{ 
            fontSize: '2rem', 
            fontWeight: 'bold',
            background: 'rgba(255,255,255,0.2)',
            padding: '0.5rem 1rem',
            borderRadius: '0.5rem',
            margin: '0 0.5rem'
          }}>
            {count}
          </span>
          
          <button 
            onClick={() => setCount(count + 1)}
            style={{
              background: '#22c55e',
              color: 'white',
              border: 'none',
              padding: '0.75rem 1.5rem',
              margin: '0 0.5rem',
              borderRadius: '0.5rem',
              fontSize: '1.2rem',
              cursor: 'pointer'
            }}
          >
            +
          </button>
        </div>
        
        <p style={{ fontSize: '0.9rem', opacity: 0.8 }}>
          Edit <code>src/components/App.jsx</code> and save to test HMR
        </p>
      </div>
    </div>
  );
};

export default App;
EOF

    print_success "Project structure created successfully!"
}

# Check if this is build-only mode or if project already exists
if [[ "$BUILD_ONLY" == "--build-only" ]] || [[ -f "package.json" ]]; then
    if [[ ! -f "package.json" ]]; then
        print_error "package.json not found. Please run this script from the project root directory or omit --build-only flag."
        exit 1
    fi
    print_status "Found existing project, proceeding with build..."
elif [[ ! -f "package.json" ]]; then
    # No package.json found and not in build-only mode, create new project
    create_project
fi

print_status "Starting auto build process for Vite React project..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    print_error "npm is not installed. Please install npm first."
    exit 1
fi

print_status "Node.js version: $(node --version)"
print_status "npm version: $(npm --version)"

# Install dependencies
print_status "Installing dependencies..."
if npm install; then
    print_success "Dependencies installed successfully"
else
    print_error "Failed to install dependencies"
    exit 1
fi

# Clean previous build (if exists)
if [ -d "dist" ]; then
    print_status "Cleaning previous build..."
    rm -rf dist
    print_success "Previous build cleaned"
fi

# Build the project
print_status "Building the project..."
if npm run build; then
    print_success "Project built successfully!"
    print_status "Build output is in the 'dist' directory"
else
    print_error "Build failed"
    exit 1
fi

# Optional: Preview the build
read -p "Do you want to preview the build? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Starting preview server..."
    print_status "Preview will be available at http://localhost:4173"
    print_warning "Press Ctrl+C to stop the preview server"
    npm run preview
fi

print_success "Build process completed successfully!"
print_status "You can deploy the contents of the 'dist' directory to your web server."