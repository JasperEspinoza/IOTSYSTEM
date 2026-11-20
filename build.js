const fs = require('fs');

const apiKey = process.env.FIREBASE_API_KEY;
const databaseURL = process.env.FIREBASE_DATABASE_URL || "https://classroom-monitoring-sys-3a0b0-default-rtdb.firebaseio.com";

if (apiKey) {
  const content = `// Injected during Vercel build from secure environment variables\nwindow.FIREBASE_LOCAL_CONFIG = {\n  apiKey: "${apiKey.trim()}",\n  databaseURL: "${databaseURL.trim()}"\n};\n`;
  fs.writeFileSync('config.local.js', content, 'utf8');
  console.log('✅ Successfully generated config.local.js for Vercel deployment.');
} else {
  console.log('ℹ️ No FIREBASE_API_KEY environment variable provided; client will fallback to Settings modal or localStorage.');
}
