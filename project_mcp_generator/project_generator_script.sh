#!/bin/bash

# Vite React Tailwind Project Generator
# Usage: ./create-project.sh [project-name]

set -e  # Exit on any error

PROJECT_NAME=${1:-"vite-react-tailwind"}
echo "🚀 Creating project: $PROJECT_NAME"

# Create project directory and navigate into it
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"
echo "📁 Working in directory: $(pwd)"

# Initialize package.json
echo "📦 Creating package.json..."
cat > package.json << 'EOF'
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "devDependencies": {
    "vite": "^5.4.0",
    "autoprefixer": "^10.4.19",
    "postcss": "^8.4.38",
    "tailwindcss": "^3.4.1"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "react-router-dom": "^6.26.1"
  }
}
EOF

# Create index.html
echo "🏠 Creating index.html..."
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
echo "📁 Creating src directory structure..."
mkdir -p src/components src/pages

# Create index.jsx (matching your original structure)
echo "⚛️ Creating React entry point..."
cat > src/index.jsx << 'EOF'
import React, { StrictMode } from 'react';  
import { createRoot } from 'react-dom/client';
import './index.css'
import App from './components/App';     

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <App />
  </StrictMode>,
);
EOF

# Create App.jsx with Router setup
echo "🔗 Creating App component with routing..."
cat > src/components/App.jsx << 'EOF'
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Navigation from './Navigation';
import Home from '../pages/Home';
import About from '../pages/About';
import McpAgent from '../pages/McpAgent';
import Contact from '../pages/Contact';

const App = () => {
  return (
    <Router>
      <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
        <Navigation />
        <main className="container mx-auto px-4 py-8">
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/about" element={<About />} />
            <Route path="/mcp-agent" element={<McpAgent />} />
            <Route path="/contact" element={<Contact />} />
          </Routes>
        </main>
      </div>
    </Router>
  );
};

export default App;
EOF

# Create Navigation component
echo "🧭 Creating Navigation component..."
cat > src/components/Navigation.jsx << 'EOF'
import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';

const Navigation = () => {
  const [isOpen, setIsOpen] = useState(false);
  const location = useLocation();

  const navItems = [
    { path: '/', name: 'Home', icon: '🏠' },
    { path: '/about', name: 'About', icon: '👋' },
    { path: '/mcp-agent', name: 'MCP Agent', icon: '🤖' },
    { path: '/contact', name: 'Contact', icon: '📧' },
  ];

  const isActive = (path) => location.pathname === path;

  return (
    <nav className="bg-white/10 backdrop-blur-lg border-b border-white/20">
      <div className="container mx-auto px-4">
        <div className="flex justify-between items-center py-4">
          <Link to="/" className="text-2xl font-bold text-white hover:text-purple-300 transition-colors">
            🚀 ViteApp
          </Link>

          {/* Desktop Navigation */}
          <div className="hidden md:flex space-x-8">
            {navItems.map((item) => (
              <Link
                key={item.path}
                to={item.path}
                className={`flex items-center space-x-2 px-3 py-2 rounded-lg transition-all duration-200 ${
                  isActive(item.path)
                    ? 'bg-white/20 text-white'
                    : 'text-white/80 hover:text-white hover:bg-white/10'
                }`}
              >
                <span>{item.icon}</span>
                <span>{item.name}</span>
              </Link>
            ))}
          </div>

          {/* Mobile menu button */}
          <button
            onClick={() => setIsOpen(!isOpen)}
            className="md:hidden text-white hover:text-purple-300 transition-colors"
          >
            <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              {isOpen ? (
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              ) : (
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
              )}
            </svg>
          </button>
        </div>

        {/* Mobile Navigation */}
        {isOpen && (
          <div className="md:hidden pb-4">
            <div className="flex flex-col space-y-2">
              {navItems.map((item) => (
                <Link
                  key={item.path}
                  to={item.path}
                  onClick={() => setIsOpen(false)}
                  className={`flex items-center space-x-2 px-3 py-2 rounded-lg transition-all duration-200 ${
                    isActive(item.path)
                      ? 'bg-white/20 text-white'
                      : 'text-white/80 hover:text-white hover:bg-white/10'
                  }`}
                >
                  <span>{item.icon}</span>
                  <span>{item.name}</span>
                </Link>
              ))}
            </div>
          </div>
        )}
      </div>
    </nav>
  );
};

export default Navigation;
EOF

# Create Home page
echo "🏠 Creating Home page..."
cat > src/pages/Home.jsx << 'EOF'
import React, { useState } from 'react';

const Home = () => {
  const [count, setCount] = useState(0);

  return (
    <div className="max-w-6xl mx-auto">
      <div className="text-center mb-16">
        <h1 className="text-6xl font-bold text-white mb-8 drop-shadow-lg">
          🚀 Welcome to ViteApp
        </h1>
        <p className="text-xl text-white/90 mb-12 max-w-3xl mx-auto">
          A modern React application with Vite, Tailwind CSS, and React Router. 
          Fast development, beautiful UI, and seamless navigation.
        </p>
      </div>

      <div className="bg-white/10 backdrop-blur-lg rounded-2xl p-8 mb-12 border border-white/20 max-w-md mx-auto">
        <h2 className="text-2xl font-semibold text-white mb-6 text-center">Interactive Counter</h2>
        <div className="flex items-center justify-center gap-4">
          <button
            onClick={() => setCount(count - 1)}
            className="px-6 py-3 bg-red-500 hover:bg-red-600 text-white font-semibold rounded-lg transition-colors duration-200 shadow-lg hover:shadow-xl"
          >
            -
          </button>
          
          <span className="text-4xl font-bold text-white bg-white/20 px-8 py-4 rounded-lg min-w-[120px] text-center">
            {count}
          </span>
          
          <button
            onClick={() => setCount(count + 1)}
            className="px-6 py-3 bg-green-500 hover:bg-green-600 text-white font-semibold rounded-lg transition-colors duration-200 shadow-lg hover:shadow-xl"
          >
            +
          </button>
        </div>
      </div>

      <div className="grid md:grid-cols-3 gap-8 mb-12">
        <div className="bg-white/10 backdrop-blur-lg rounded-xl p-6 border border-white/20 hover:bg-white/20 transition-all duration-300">
          <div className="text-4xl mb-4">⚡</div>
          <h3 className="text-xl font-semibold text-white mb-3">Lightning Fast</h3>
          <p className="text-white/80">Powered by Vite for instant server start and lightning-fast HMR.</p>
        </div>
        
        <div className="bg-white/10 backdrop-blur-lg rounded-xl p-6 border border-white/20 hover:bg-white/20 transition-all duration-300">
          <div className="text-4xl mb-4">⚛️</div>
          <h3 className="text-xl font-semibold text-white mb-3">React 18</h3>
          <p className="text-white/80">Built with the latest React features and concurrent rendering.</p>
        </div>
        
        <div className="bg-white/10 backdrop-blur-lg rounded-xl p-6 border border-white/20 hover:bg-white/20 transition-all duration-300">
          <div className="text-4xl mb-4">🎨</div>
          <h3 className="text-xl font-semibold text-white mb-3">Tailwind CSS</h3>
          <p className="text-white/80">Utility-first CSS framework for rapid UI development.</p>
        </div>
      </div>
    </div>
  );
};

export default Home;
EOF

# Create About page
echo "👋 Creating About page..."
cat > src/pages/About.jsx << 'EOF'
import React from 'react';

const About = () => {
  const teamMembers = [
    { name: "Alex Chen", role: "Frontend Developer", avatar: "👨‍💻", bio: "React and TypeScript enthusiast" },
    { name: "Sarah Johnson", role: "UI/UX Designer", avatar: "👩‍🎨", bio: "Creating beautiful user experiences" },
    { name: "Mike Rodriguez", role: "Full Stack Developer", avatar: "👨‍🔧", bio: "Building scalable applications" }
  ];

  return (
    <div className="max-w-6xl mx-auto">
      <div className="text-center mb-16">
        <h1 className="text-5xl font-bold text-white mb-6">About Us</h1>
        <p className="text-xl text-white/90 max-w-3xl mx-auto">
          We're passionate about building modern web applications with cutting-edge technologies.
        </p>
      </div>

      <div className="bg-white/10 backdrop-blur-lg rounded-2xl p-8 mb-12 border border-white/20">
        <h2 className="text-3xl font-bold text-white mb-6 text-center">Our Mission</h2>
        <p className="text-lg text-white/90 text-center max-w-4xl mx-auto leading-relaxed">
          To create exceptional digital experiences that combine beautiful design, 
          robust functionality, and cutting-edge technology.
        </p>
      </div>

      <div className="mb-12">
        <h2 className="text-3xl font-bold text-white mb-8 text-center">Meet Our Team</h2>
        <div className="grid md:grid-cols-3 gap-8">
          {teamMembers.map((member, index) => (
            <div key={index} className="bg-white/10 backdrop-blur-lg rounded-xl p-6 border border-white/20 text-center hover:bg-white/20 transition-all duration-300">
              <div className="text-6xl mb-4">{member.avatar}</div>
              <h3 className="text-xl font-semibold text-white mb-2">{member.name}</h3>
              <p className="text-purple-300 font-medium mb-3">{member.role}</p>
              <p className="text-white/80 text-sm">{member.bio}</p>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default About;
EOF

# Create MCP Agent page
echo "🤖 Creating MCP Agent page..."
cat > src/pages/McpAgent.jsx << 'EOF'
import React, { useState } from 'react';

const McpAgent = () => {
  const [query, setQuery] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [response, setResponse] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!query.trim()) return;

    setIsLoading(true);
    
    // Simulate API call
    setTimeout(() => {
      setResponse(`MCP Agent Response: I understand you're asking about "${query}". This is a demo response showing how the MCP Agent would process your request.`);
      setIsLoading(false);
    }, 2000);
  };

  const exampleQueries = [
    "What is MCP and how does it work?",
    "Show me available tools",
    "Help me understand the protocol",
    "Generate a code example"
  ];

  return (
    <div className="max-w-4xl mx-auto">
      <div className="text-center mb-12">
        <h1 className="text-5xl font-bold text-white mb-6">🤖 MCP Agent</h1>
        <p className="text-xl text-white/90 max-w-3xl mx-auto">
          Interact with the Model Context Protocol (MCP) Agent. Ask questions and explore capabilities.
        </p>
      </div>

      <div className="bg-white/10 backdrop-blur-lg rounded-2xl border border-white/20 overflow-hidden">
        <div className="bg-white/10 px-6 py-4 border-b border-white/20">
          <div className="flex items-center space-x-3">
            <div className="w-3 h-3 bg-green-400 rounded-full animate-pulse"></div>
            <span className="text-white font-medium">MCP Agent - Online</span>
          </div>
        </div>

        <div className="p-6">
          {!response && (
            <div className="mb-6">
              <h3 className="text-white font-medium mb-3">Try these examples:</h3>
              <div className="grid gap-2">
                {exampleQueries.map((example, index) => (
                  <button
                    key={index}
                    onClick={() => setQuery(example)}
                    className="text-left bg-white/5 hover:bg-white/10 rounded-lg p-3 text-white/80 hover:text-white transition-all duration-200"
                  >
                    {example}
                  </button>
                ))}
              </div>
            </div>
          )}

          {response && (
            <div className="mb-6 bg-white/5 rounded-lg p-4">
              <div className="flex items-start space-x-3">
                <div className="text-2xl">🤖</div>
                <p className="text-white/90">{response}</p>
              </div>
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-4">
            <textarea
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder="Ask the MCP Agent anything..."
              className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-purple-500"
              rows="3"
              disabled={isLoading}
            />
            
            <button
              type="submit"
              disabled={!query.trim() || isLoading}
              className="bg-purple-500 hover:bg-purple-600 disabled:bg-purple-500/50 text-white px-6 py-2 rounded-lg transition-colors duration-200 font-medium disabled:cursor-not-allowed"
            >
              {isLoading ? 'Processing...' : 'Send Query'}
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default McpAgent;
EOF

# Create Contact page
echo "📧 Creating Contact page..."
cat > src/pages/Contact.jsx << 'EOF'
import React, { useState } from 'react';

const Contact = () => {
  const [formData, setFormData] = useState({
    name: '', email: '', subject: '', message: ''
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitted, setSubmitted] = useState(false);

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsSubmitting(true);
    
    setTimeout(() => {
      setIsSubmitting(false);
      setSubmitted(true);
      setFormData({ name: '', email: '', subject: '', message: '' });
      setTimeout(() => setSubmitted(false), 5000);
    }, 2000);
  };

  return (
    <div className="max-w-4xl mx-auto">
      <div className="text-center mb-16">
        <h1 className="text-5xl font-bold text-white mb-6">Get in Touch</h1>
        <p className="text-xl text-white/90 max-w-3xl mx-auto">
          Have questions? We'd love to hear from you. Send us a message!
        </p>
      </div>

      <div className="bg-white/10 backdrop-blur-lg rounded-2xl p-8 border border-white/20">
        <h2 className="text-2xl font-bold text-white mb-6">Send us a Message</h2>
        
        {submitted && (
          <div className="bg-green-500/20 border border-green-500/30 rounded-lg p-4 mb-6">
            <p className="text-green-300 font-medium">✅ Message sent successfully!</p>
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-6">
          <div className="grid md:grid-cols-2 gap-4">
            <div>
              <label className="block text-white/80 text-sm font-medium mb-2">Name *</label>
              <input
                type="text" name="name" value={formData.name} onChange={handleChange} required
                className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-purple-500"
                placeholder="Your name"
              />
            </div>
            <div>
              <label className="block text-white/80 text-sm font-medium mb-2">Email *</label>
              <input
                type="email" name="email" value={formData.email} onChange={handleChange} required
                className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-purple-500"
                placeholder="your@email.com"
              />
            </div>
          </div>

          <div>
            <label className="block text-white/80 text-sm font-medium mb-2">Subject *</label>
            <input
              type="text" name="subject" value={formData.subject} onChange={handleChange} required
              className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-purple-500"
              placeholder="What's this about?"
            />
          </div>

          <div>
            <label className="block text-white/80 text-sm font-medium mb-2">Message *</label>
            <textarea
              name="message" value={formData.message} onChange={handleChange} required rows="6"
              className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-purple-500 resize-none"
              placeholder="Tell us more..."
            />
          </div>

          <button
            type="submit" disabled={isSubmitting}
            className="w-full bg-purple-500 hover:bg-purple-600 disabled:bg-purple-500/50 text-white py-3 px-6 rounded-lg transition-colors duration-200 font-medium disabled:cursor-not-allowed"
          >
            {isSubmitting ? 'Sending...' : 'Send Message'}
          </button>
        </form>
      </div>
    </div>
  );
};

export default Contact;
EOF

# Create Tailwind CSS file
echo "🎨 Creating Tailwind CSS..."
cat > src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer components {
  .btn {
    @apply px-4 py-2 rounded-lg font-semibold transition-colors duration-200;
  }
  
  .btn-primary {
    @apply bg-blue-500 hover:bg-blue-600 text-white;
  }
}
EOF

# Create Tailwind config
echo "⚙️ Creating Tailwind configuration..."
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

# Create PostCSS config
echo "🔧 Creating PostCSS configuration..."
cat > postcss.config.js << 'EOF'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

# Create .gitignore
echo "📝 Creating .gitignore..."
cat > .gitignore << 'EOF'
node_modules
dist
*.local
.env
.DS_Store
EOF

# Install dependencies
echo "📥 Installing dependencies..."
if npm install; then
    echo ""
    echo "✅ Project '$PROJECT_NAME' created successfully!"
    echo ""
    echo "🚀 Next steps:"
    echo "   cd $PROJECT_NAME"
    echo "   npm run dev"
    echo ""
    echo "🎯 Your app includes:"
    echo "   - React 18 with Vite"
    echo "   - Tailwind CSS"
    echo "   - React Router"
    echo "   - 4 pages: Home, About, MCP Agent, Contact"
    echo "   - Responsive navigation"
    echo "   - Beautiful glassmorphism design"
else
    echo ""
    echo "❌ npm install failed. Please run 'npm install' manually in the $PROJECT_NAME directory"
fi