# Vite ReactApp 

-   project structure

```
/vite-app-js
├── index.html 
├── .gitignore 
├── package-lock.json 
├── package.json 
└── Readme.md
```

- Then run the vite CLI in your terminal:

```
npx vite 
```

###  B. Start Vite to render react

structure

```
/vite-react-js
├── src 
│  ├── components
│  │   └── App.jsx
│  ├── index.html 
│  └── index.jsx
├── .gitignore 
├── package.json 
└── Readme.md
```

prepare the initial file: `index.html`, `src/index.jsx`, `src/components/App.jsx`:

`index.html`
```html
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
```

-   `src/index.jsx`

```js
import React, { StrictMode } from 'react';  
import { createRoot } from 'react-dom/client';
import App from './components/App';     

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <App />
  </StrictMode>,
);
```

-   `src/components/App.jsx`

```js
import React from 'react';

const App = () => {
  return (
    <h1>Hello</h1>
  );
};

export default App;
```

- install react react-dom

```
npm i --save react react-dom  
```

- Add `"start"` scripts to the `package.json` file  

```
  "scripts": {
    "dev": "vite", 
    "build": "vite build", 
    "preview": "vite preview" 
  },
```

- run react

```sh
npm run dev
```

or

```sh
npx vite 
```