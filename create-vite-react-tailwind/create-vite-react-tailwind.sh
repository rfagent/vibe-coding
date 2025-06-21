# Create src directory and files
echo "📁 Creating src directory structure..."
mkdir -p src/components src/pages

# Create index.jsx (matching your original structure)
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
          {/* Logo */}
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
cat > src/pages/Home.jsx << 'EOF'
import React, { useState } from 'react';

const Home = () => {
  const [count, setCount] = useState(0);

  return (
    <div className="max-w-6xl mx-auto">
      {/* Hero Section */}
      <div className="text-center mb-16">
        <h1 className="text-6xl font-bold text-white mb-8 drop-shadow-lg">
          🚀 Welcome to ViteApp
        </h1>
        <p className="text-xl text-white/90 mb-12 max-w-3xl mx-auto">
          A modern React application with Vite, Tailwind CSS, and React Router. 
          Fast development, beautiful UI, and seamless navigation.
        </p>
      </div>

      {/* Interactive Counter Card */}
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

      {/* Feature Grid */}
      <div className="grid md:grid-cols-3 gap-8 mb-12">
        <div className="bg-white/10 backdrop-blur-lg rounded-xl p-6 border border-white/20 hover:bg-white/20 transition-all duration-300">
          <div className="text-4xl mb-4">⚡</div>
          <h3 className="text-xl font-semibold text-white mb-3">Lightning Fast</h3>
          <p className="text-white/80">Powered by Vite for instant server start and lightning-fast HMR during development.</p>
        </div>
        
        <div className="bg-white/10 backdrop-blur-lg rounded-xl p-6 border border-white/20 hover:bg-white/20 transition-all duration-300">
          <div className="text-4xl mb-4">⚛️</div>
          <h3 className="text-xl font-semibold text-white mb-3">React 18</h3>
          <p className="text-white/80">Built with the latest React features including concurrent rendering and automatic batching.</p>
        </div>
        
        <div className="bg-white/10 backdrop-blur-lg rounded-xl p-6 border border-white/20 hover:bg-white/20 transition-all duration-300">
          <div className="text-4xl mb-4">🎨</div>
          <h3 className="text-xl font-semibold text-white mb-3">Tailwind CSS</h3>
          <p className="text-white/80">Utility-first CSS framework for rapid UI development with beautiful, responsive designs.</p>
        </div>
      </div>

      {/* Quick Links */}
      <div className="text-center">
        <h2 className="text-3xl font-bold text-white mb-8">Explore the App</h2>
        <div className="flex flex-wrap justify-center gap-4">
          <a href="/about" className="bg-blue-500 hover:bg-blue-600 text-white px-6 py-3 rounded-lg transition-colors duration-200 font-semibold">
            Learn About Us
          </a>
          <a href="/mcp-agent" className="bg-purple-500 hover:bg-purple-600 text-white px-6 py-3 rounded-lg transition-colors duration-200 font-semibold">
            Try MCP Agent
          </a>
          <a href="/contact" className="bg-green-500 hover:bg-green-600 text-white px-6 py-3 rounded-lg transition-colors duration-200 font-semibold">
            Get in Touch
          </a>
        </div>
      </div>
    </div>
  );
};

export default Home;
EOF

# Create About page
cat > src/pages/About.jsx << 'EOF'
import React from 'react';

const About = () => {
  const teamMembers = [
    {
      name: "Alex Chen",
      role: "Frontend Developer",
      avatar: "👨‍💻",
      bio: "Passionate about creating beautiful, performant web applications with modern technologies."
    },
    {
      name: "Sarah Johnson",
      role: "UI/UX Designer",
      avatar: "👩‍🎨",
      bio: "Focused on crafting intuitive user experiences and pixel-perfect interfaces."
    },
    {
      name: "Mike Rodriguez",
      role: "Full Stack Developer",
      avatar: "👨‍🔧",
      bio: "Expert in building scalable applications from database to deployment."
    }
  ];

  return (
    <div className="max-w-6xl mx-auto">
      {/* Header */}
      <div className="text-center mb-16">
        <h1 className="text-5xl font-bold text-white mb-6">About Us</h1>
        <p className="text-xl text-white/90 max-w-3xl mx-auto">
          We're a passionate team building modern web applications with cutting-edge technologies.
        </p>
      </div>

      {/* Mission Section */}
      <div className="bg-white/10 backdrop-blur-lg rounded-2xl p-8 mb-12 border border-white/20">
        <h2 className="text-3xl font-bold text-white mb-6 text-center">Our Mission</h2>
        <p className="text-lg text-white/90 text-center max-w-4xl mx-auto leading-relaxed">
          To create exceptional digital experiences that combine beautiful design, 
          robust functionality, and cutting-edge technology. We believe in building 
          applications that are not only powerful but also delightful to use.
        </p>
      </div>

      {/* Values Grid */}
      <div className="grid md:grid-cols-3 gap-8 mb-16">
        <div className="text-center">
          <div className="text-4xl mb-4">🎯</div>
          <h3 className="text-xl font-semibold text-white mb-3">Focus</h3>
          <p className="text-white/80">We concentrate on what matters most - delivering value to our users through thoughtful design and development.</p>
        </div>
        
        <div className="text-center">
          <div className="text-4xl mb-4">🚀</div>
          <h3 className="text-xl font-semibold text-white mb-3">Innovation</h3>
          <p className="text-white/80">Always exploring new technologies and methodologies to stay at the forefront of web development.</p>
        </div>
        
        <div className="text-center">
          <div className="text-4xl mb-4">🤝</div>
          <h3 className="text-xl font-semibold text-white mb-3">Collaboration</h3>
          <p className="text-white/80">Working together with our clients and community to build something greater than the sum of its parts.</p>
        </div>
      </div>

      {/* Team Section */}
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

      {/* Technology Stack */}
      <div className="bg-white/10 backdrop-blur-lg rounded-2xl p-8 border border-white/20">
        <h2 className="text-3xl font-bold text-white mb-6 text-center">Our Technology Stack</h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
          <div className="bg-white/10 rounded-lg p-4">
            <div className="text-2xl mb-2">⚛️</div>
            <p className="text-white font-medium">React</p>
          </div>
          <div className="bg-white/10 rounded-lg p-4">
            <div className="text-2xl mb-2">⚡</div>
            <p className="text-white font-medium">Vite</p>
          </div>
          <div className="bg-white/10 rounded-lg p-4">
            <div className="text-2xl mb-2">🎨</div>
            <p className="text-white font-medium">Tailwind</p>
          </div>
          <div className="bg-white/10 rounded-lg p-4">
            <div className="text-2xl mb-2">🗂️</div>
            <p className="text-white font-medium">Router</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default About;
EOF

# Create MCP Agent page
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
      setResponse(`MCP Agent Response: I understand you're asking about "${query}". This is a demo response showing how the MCP Agent would process your request. In a real implementation, this would connect to actual MCP services and provide intelligent responses based on your query.`);
      setIsLoading(false);
    }, 2000);
  };

  const clearChat = () => {
    setQuery('');
    setResponse('');
  };

  const exampleQueries = [
    "What is MCP and how does it work?",
    "Show me available tools and capabilities",
    "Help me understand the protocol",
    "Generate a code example"
  ];

  return (
    <div className="max-w-4xl mx-auto">
      {/* Header */}
      <div className="text-center mb-12">
        <h1 className="text-5xl font-bold text-white mb-6">🤖 MCP Agent</h1>
        <p className="text-xl text-white/90 max-w-3xl mx-auto">
          Interact with the Model Context Protocol (MCP) Agent. Ask questions, get insights, 
          and explore capabilities through an intelligent interface.
        </p>
      </div>

      {/* Chat Interface */}
      <div className="bg-white/10 backdrop-blur-lg rounded-2xl border border-white/20 overflow-hidden">
        {/* Chat Header */}
        <div className="bg-white/10 px-6 py-4 border-b border-white/20">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-3">
              <div className="w-3 h-3 bg-green-400 rounded-full animate-pulse"></div>
              <span className="text-white font-medium">MCP Agent - Online</span>
            </div>
            <button
              onClick={clearChat}
              className="text-white/60 hover:text-white transition-colors text-sm"
            >
              Clear Chat
            </button>
          </div>
        </div>

        {/* Chat Content */}
        <div className="p-6">
          {/* Example queries */}
          {!response && (
            <div className="mb-6">
              <h3 className="text-white font-medium mb-3">Try these example queries:</h3>
              <div className="grid gap-2">
                {exampleQueries.map((example, index) => (
                  <button
                    key={index}
                    onClick={() => setQuery(example)}
                    className="text-left bg-white/5 hover:bg-white/10 rounded-lg p-3 text-white/80 hover:text-white transition-all duration-200 border border-white/10 hover:border-white/20"
                  >
                    {example}
                  </button>
                ))}
              </div>
            </div>
          )}

          {/* Response Area */}
          {response && (
            <div className="mb-6">
              <div className="bg-white/5 rounded-lg p-4 border border-white/10">
                <div className="flex items-start space-x-3">
                  <div className="text-2xl">🤖</div>
                  <div className="flex-1">
                    <p className="text-white/90 leading-relaxed">{response}</p>
                  </div>
                </div>
              </div>
            </div>
          )}

          {/* Input Form */}
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="relative">
              <textarea
                value={query}
                onChange={(e) => setQuery(e.target.value)}
                placeholder="Ask the MCP Agent anything..."
                className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent resize-none"
                rows="4"
                disabled={isLoading}
              />
            </div>
            
            <div className="flex items-center justify-between">
              <div className="text-white/60 text-sm">
                {query.length}/1000 characters
              </div>
              <button
                type="submit"
                disabled={!query.trim() || isLoading}
                className="bg-purple-500 hover:bg-purple-600 disabled:bg-purple-500/50 text-white px-6 py-2 rounded-lg transition-colors duration-200 font-medium disabled:cursor-not-allowed flex items-center space-x-2"
              >
                {isLoading ? (
                  <>
                    <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin"></div>
                    <span>Processing...</span>
                  </>
                ) : (
                  <>
                    <span>Send Query</span>
                    <span>→</span>
                  </>
                )}
              </button>
            </div>
          </form>
        </div>
      </div>

      {/* Features */}
      <div className="grid md:grid-cols-2 gap-8 mt-12">
        <div className="bg-white/10 backdrop-blur-lg rounded-xl p-6 border border-white/20">
          <h3 className="text-xl font-semibold text-white mb-4 flex items-center">
            <span className="mr-3">🔧</span>
            Capabilities
          </h3>
          <ul className="space-y-2 text-white/80">
            <li>• Natural language processing</li>
            <li>• Context-aware responses</li>
            <li>• Tool integration</li>
            <li>• Real-time interaction</li>
          </ul>
        </div>

        <div className="bg-white/10 backdrop-blur-lg rounded-xl p-6 border border-white/20">
          <h3 className="text-xl font-semibold text-white mb-4 flex items-center">
            <span className="mr-3">⚡</span>
            Features
          </h3>
          <ul className="space-y-2 text-white/80">
            <li>• Fast response times</li>
            <li>• Secure communication</li>
            <li>• Extensible architecture</li>
            <li>• Developer-friendly API</li>
          </ul>
        </div>
      </div>
    </div>
  );
};

export default McpAgent;
EOF

# Create Contact page
cat > src/pages/Contact.jsx << 'EOF'
import React, { useState } from 'react';

const Contact = () => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    subject: '',
    message: ''
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitted, setSubmitted] = useState(false);

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsSubmitting(true);
    
    // Simulate form submission
    setTimeout(() => {
      setIsSubmitting(false);
      setSubmitted(true);
      setFormData({ name: '', email: '', subject: '', message: '' });
      
      // Reset success message after 5 seconds
      setTimeout(() => setSubmitted(false), 5000);
    }, 2000);
  };

  const contactInfo = [
    {
      icon: '📧',
      title: 'Email',
      details: 'hello@viteapp.com',
      description: 'Send us an email anytime'
    },
    {
      icon: '📱',
      title: 'Phone',
      details: '+1 (555) 123-4567',
      description: 'Mon-Fri from 8am to 6pm'
    },
    {
      icon: '📍',
      title: 'Office',
      details: '123 Tech Street, San Francisco, CA',
      description: 'Come visit our office'
    },
    {
      icon: '💬',
      title: 'Live Chat',
      details: 'Available 24/7',
      description: 'Get instant support'
    }
  ];

  return (
    <div className="max-w-6xl mx-auto">
      {/* Header */}
      <div className="text-center mb-16">
        <h1 className="text-5xl font-bold text-white mb-6">Get in Touch</h1>
        <p className="text-xl text-white/90 max-w-3xl mx-auto">
          Have questions or want to work together? We'd love to hear from you. 
          Send us a message and we'll respond as soon as possible.
        </p>
      </div>

      <div className="grid lg:grid-cols-2 gap-12">
        {/* Contact Form */}
        <div className="bg-white/10 backdrop-blur-lg rounded-2xl p-8 border border-white/20">
          <h2 className="text-2xl font-bold text-white mb-6">Send us a Message</h2>
          
          {submitted && (
            <div className="bg-green-500/20 border border-green-500/30 rounded-lg p-4 mb-6">
              <div className="flex items-center space-x-3">
                <span className="text-2xl">✅</span>
                <div>
                  <p className="text-green-300 font-medium">Message sent successfully!</p>
                  <p className="text-green-300/80 text-sm">We'll get back to you soon.</p>
                </div>
              </div>
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-6">
            <div className="grid md:grid-cols-2 gap-4">
              <div>
                <label className="block text-white/80 text-sm font-medium mb-2">
                  Name *
                </label>
                <input
                  type="text"
                  name="name"
                  value={formData.name}
                  onChange={handleChange}
                  required
                  className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                  placeholder="Your name"
                />
              </div>
              <div>
                <label className="block text-white/80 text-sm font-medium mb-2">
                  Email *
                </label>
                <input
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  required
                  className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                  placeholder="your@email.com"
                />
              </div>
            </div>

            <div>
              <label className="block text-white/80 text-sm font-medium mb-2">
                Subject *
              </label>
              <input
                type="text"
                name="subject"
                value={formData.subject}
                onChange={handleChange}
                required
                className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                placeholder="What's this about?"
              />
            </div>

            <div>
              <label className="block text-white/80 text-sm font-medium mb-2">
                Message *
              </label>
              <textarea
                name="message"
                value={formData.message}
                onChange={handleChange}
                required
                rows="6"
                className="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent resize-none"
                placeholder="Tell us more about your project or question..."
              />
            </div>

            <button
              type="submit"
              disabled={isSubmitting}
              className="w-full bg-purple-500 hover:bg-purple-600 disabled:bg-purple-500/50 text-white py-3 px-6 rounded-lg transition-colors duration-200 font-medium disabled:cursor-not-allowed flex items-center justify-center space-x-2"
            >
              {isSubmitting ? (
                <>
                  <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin"></div>
                  <span>Sending...</span>
                </>
              ) : (
                <>
                  <span>Send Message</span>
                  <span>📧</span>
                </>
              )}
            </button>
          </form>
        </div>

        {/* Contact Information */}
        <div className="space-y-8">
          <div className="bg-white/10 backdrop-blur-lg rounded-2xl p-8 border border-white/20">
            <h2 className="text-2xl font-bold text-white mb-6">Contact Information</h2>
            <div className="space-y-6">
              {contactInfo.map((info, index) => (
                <div key={index} className="flex items-start space-x-4">
                  <div className="text-3xl">{info.icon}</div>
                  <div>
                    <h3 className="text-white font-semibold">{info.title}</h3>
                    <p className="text-purple-300 font-medium">{info.details}</p>
                    <p className="text-white/70 text-sm">{info.description}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* FAQ Section */}
          <div className="bg-white/10 backdrop-blur-lg rounded-2xl p-8 border border-white/20">
            <h2 className="text-2xl font-bold text-white mb-6">Quick Questions</h2>
            <div className="space-y-4">
              <div>
                <h3 className="text-white font-medium mb-2">What's your response time?</h3>
                <p className="text-white/80 text-sm">We typically respond within 24 hours during business days.</p>
              </div>
              <div>
                <h3 className="text-white font-medium mb-2">Do you offer support?</h3>
                <p className="text-white/80 text-sm">Yes! We provide ongoing support for all our projects.</p>
              </div>
              <div>
                <h3 className="text-white font-medium mb-2">Can we schedule a call?</h3>
                <p className="text-white/80 text-sm">Absolutely! Mention it in your message and we'll set something up.</p>
              </div>
            </div>
          </div>

          {/* Social Links */}
          <div className="bg-white/10 backdrop-blur-lg rounded-2xl p-8 border border-white/20">
            <h2 className="text-2xl font-bold text-white mb-6">Follow Us</h2>
            <div className="flex space-x-4">
              <a href="#" className="bg-white/10 hover:bg-white/20 p-3 rounded-lg transition-colors duration-200">
                <span className="text-2xl">🐦</span>
              </a>
              <a href="#" className="bg-white/10 hover:bg-white/20 p-3 rounded-lg transition-colors duration-200">
                <span className="text-2xl">💼</span>
              </a>
              <a href="#" className="bg-white/10 hover:bg-white/20 p-3 rounded-lg transition-colors duration-200">
                <span className="text-2xl">📱</span>
              </a>
              <a href="#" className="bg-white/10 hover:bg-white/20 p-3 rounded-lg transition-colors duration-200">
                <span className="text-2xl">🎯</span>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Contact;
EOF#!/bin/bash

# Vite React Tailwind Project Generator
# Usage: ./create-project.sh [project-name]

set -e  # Exit on any error

PROJECT_NAME=${1:-"vite-react-tailwind"}
echo "🚀 Creating project: $PROJECT_NAME"

# Create project directory
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

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
mkdir -p src/components

# Create index.jsx (matching your original structure)
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

# Create App.jsx inside components folder with Tailwind example
cat > src/components/App.jsx << 'EOF'
import React, { useState } from 'react';

const App = () => {
  const [count, setCount] = useState(0)

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-500 via-purple-500 to-pink-500">
      <div className="container mx-auto px-4 py-16">
        <div className="max-w-4xl mx-auto text-center">
          {/* Header */}
          <h1 className="text-6xl font-bold text-white mb-8 drop-shadow-lg">
            🚀 Vite + React + Tailwind
          </h1>
          
          {/* Subtitle */}
          <p className="text-xl text-white/90 mb-12 max-w-2xl mx-auto">
            A modern development stack with lightning-fast HMR, component-based architecture, 
            and utility-first CSS framework.
          </p>

          {/* Interactive Counter Card */}
          <div className="bg-white/10 backdrop-blur-lg rounded-2xl p-8 mb-12 border border-white/20">
            <h2 className="text-2xl font-semibold text-white mb-6">Interactive Counter</h2>
            <div className="flex items-center justify-center gap-4">
              <button
                onClick={() => setCount(count - 1)}
                className="px-6 py-3 bg-red-500 hover:bg-red-600 text-white font-semibold rounded-lg transition-colors duration-200 shadow-lg hover:shadow-xl"
              >
                -
              </button>
              
              <span className="text-4xl font-bold text-white bg-white/20 px-8 py-4 rounded-lg min-w-[120px]">
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

          {/* Feature Grid */}
          <div className="grid md:grid-cols-3 gap-6">
            <div className="bg-white/10 backdrop-blur-lg rounded-xl p-6 border border-white/20">
              <div className="text-3xl mb-4">⚡</div>
              <h3 className="text-xl font-semibold text-white mb-2">Lightning Fast</h3>
              <p className="text-white/80">Instant server start with Vite's native ESM</p>
            </div>
            
            <div className="bg-white/10 backdrop-blur-lg rounded-xl p-6 border border-white/20">
              <div className="text-3xl mb-4">⚛️</div>
              <h3 className="text-xl font-semibold text-white mb-2">React 18</h3>
              <p className="text-white/80">Latest React features and concurrent rendering</p>
            </div>
            
            <div className="bg-white/10 backdrop-blur-lg rounded-xl p-6 border border-white/20">
              <div className="text-3xl mb-4">🎨</div>
              <h3 className="text-xl font-semibold text-white mb-2">Tailwind CSS</h3>
              <p className="text-white/80">Utility-first CSS for rapid UI development</p>
            </div>
          </div>

          {/* Footer */}
          <div className="mt-12 text-white/70">
            <p>Edit <code className="bg-white/20 px-2 py-1 rounded">src/components/App.jsx</code> and save to test HMR</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default App;
EOF

# Create Tailwind CSS file
cat > src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Custom styles */
@layer components {
  .btn {
    @apply px-4 py-2 rounded-lg font-semibold transition-colors duration-200;
  }
  
  .btn-primary {
    @apply bg-blue-500 hover:bg-blue-600 text-white;
  }
  
  .btn-secondary {
    @apply bg-gray-500 hover:bg-gray-600 text-white;
  }
}
EOF

# Create Tailwind config
echo "🎨 Creating Tailwind configuration..."
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      animation: {
        'fade-in': 'fadeIn 0.5s ease-in-out',
        'slide-up': 'slideUp 0.3s ease-out',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideUp: {
          '0%': { transform: 'translateY(10px)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' },
        },
      },
    },
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

# Create comprehensive README.md
echo "📚 Creating README.md..."
cat > README.md << 'EOF'
# Vite React Tailwind Template

A modern, fast, and feature-rich development template combining Vite, React, and Tailwind CSS.

## 🚀 Features

- ⚡ **Vite** - Lightning fast build tool with HMR
- ⚛️ **React 18** - Latest React with concurrent features
- 🎨 **Tailwind CSS** - Utility-first CSS framework
- 📱 **Responsive Design** - Mobile-first approach
- 🔧 **Modern Tooling** - ESM, PostCSS, Autoprefixer
- 🎯 **Developer Experience** - Fast refresh, TypeScript ready

## 📦 What's Included

```
├── src/
│   ├── components/          # React components
│   ├── App.jsx             # Main App component
│   ├── main.jsx            # Entry point
│   └── index.css           # Tailwind CSS imports
├── public/                 # Static assets
├── index.html              # HTML template
├── vite.config.js          # Vite configuration
├── tailwind.config.js      # Tailwind configuration
├── postcss.config.js       # PostCSS configuration
└── package.json            # Dependencies and scripts
```

## 🛠️ Getting Started

### Prerequisites

- Node.js (v16 or higher)
- npm or yarn

### Installation

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Start development server:**
   ```bash
   npm run dev
   ```

3. **Open your browser:**
   Navigate to `http://localhost:5173`

### Build for Production

```bash
npm run build
```

### Preview Production Build

```bash
npm run preview
```

## 📋 Available Scripts

| Script | Description |
|--------|-------------|
| `npm run dev` | Start development server |
| `npm run build` | Build for production |
| `npm run preview` | Preview production build |

## 🎨 Tailwind CSS

### Utility Classes

This template includes common Tailwind utility classes. Here are some examples:

```jsx
// Layout
<div className="flex items-center justify-center">
<div className="grid grid-cols-1 md:grid-cols-3 gap-4">

// Styling
<button className="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">
<h1 className="text-4xl font-bold text-gray-800">

// Responsive
<div className="w-full md:w-1/2 lg:w-1/3">
```

### Custom Components

The template includes custom component classes in `src/index.css`:

```css
@layer components {
  .btn {
    @apply px-4 py-2 rounded-lg font-semibold transition-colors duration-200;
  }
  
  .btn-primary {
    @apply bg-blue-500 hover:bg-blue-600 text-white;
  }
}
```

Usage:
```jsx
<button className="btn btn-primary">Click me</button>
```

## 🔧 Configuration

### Tailwind CSS

Edit `tailwind.config.js` to customize your design system:

```javascript
module.exports = {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        primary: '#your-color',
      },
    },
  },
  plugins: [],
}
```

### Vite

Edit `vite.config.js` for build customization:

```javascript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  // Add your custom config here
})
```

## 📱 Responsive Design

The template follows mobile-first responsive design:

```jsx
<div className="
  w-full          // Mobile: full width
  md:w-1/2        // Tablet: half width
  lg:w-1/3        // Desktop: one-third width
">
```

## 🎯 Best Practices

### Component Structure

```jsx
import React from 'react'

const MyComponent = ({ title, children }) => {
  return (
    <div className="bg-white p-6 rounded-lg shadow-md">
      <h2 className="text-xl font-semibold mb-4">{title}</h2>
      {children}
    </div>
  )
}

export default MyComponent
```

### State Management

```jsx
import React, { useState, useEffect } from 'react'

const Counter = () => {
  const [count, setCount] = useState(0)
  
  useEffect(() => {
    document.title = `Count: ${count}`
  }, [count])
  
  return (
    <div className="text-center">
      <p className="text-2xl mb-4">{count}</p>
      <button 
        onClick={() => setCount(count + 1)}
        className="btn btn-primary"
      >
        Increment
      </button>
    </div>
  )
}
```

## 🚀 Deployment

### Vercel
```bash
npm run build
# Deploy dist folder to Vercel
```

### Netlify
```bash
npm run build
# Deploy dist folder to Netlify
```

### GitHub Pages
```bash
npm run build
# Deploy dist folder to gh-pages branch
```

## 🔍 Troubleshooting

### Common Issues

**HMR not working:**
- Check if your component exports are correct
- Restart the dev server: `npm run dev`

**Tailwind classes not applying:**
- Check `tailwind.config.js` content paths
- Ensure `@tailwind` directives are in `src/index.css`
- Clear browser cache

**Build errors:**
- Check for unused imports
- Verify all dependencies are installed
- Run `npm run build` to see detailed errors

## 📚 Resources

- [Vite Documentation](https://vitejs.dev/)
- [React Documentation](https://react.dev/)
- [Tailwind CSS Documentation](https://tailwindcss.com/)
- [Vite React Plugin](https://github.com/vitejs/vite-plugin-react)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Happy coding! 🎉**
EOF

# Create .gitignore
echo "📝 Creating .gitignore..."
cat > .gitignore << 'EOF'
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

node_modules
dist
dist-ssr
*.local

# Editor directories and files
.vscode/*
!.vscode/extensions.json
.idea
.DS_Store
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local
EOF

# Install dependencies
echo "📥 Installing dependencies..."
npm install

echo "✅ Project '$PROJECT_NAME' created successfully!"
echo ""
echo "🚀 Next steps:"
echo "   cd $PROJECT_NAME"
echo "   npm run dev"
echo ""
echo "📖 Check README.md for detailed documentation"
echo "🎨 Start editing src/App.jsx to customize your app"