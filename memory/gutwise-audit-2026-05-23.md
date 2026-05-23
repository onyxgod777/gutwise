# GutWise Security Audit — 2026-05-23 03:00 ET

**Target:** https://gutwise.thealpha-secret.xyz (GitHub Pages)

## Results

### ✅ PASS: File Permissions
- All HTML files set to **600** (owner read/write only)
- 37 files checked (index.html, privacy.html, tos.html, svg-showcase.html, videos.html, 32 blog articles)

### ✅ PASS: HTTPS
- Serving via HTTPS on GitHub Pages
- Valid TLS termination, 200 OK responses
- Server header: `GitHub.com` (no version info leaked)

### ✅ PASS: No Exposed Credentials
- Grepped all `.html` files for API keys, tokens, passwords, secrets
- No Stripe, PayPal, AWS, Firebase, GitHub tokens found
- No `sk-`, `pk-`, `ghp_`, `gho_`, `eyJ` patterns matched

### ✅ PASS: No Server Info Leakage
- No `X-Powered-By` or version disclosures

### ⚠️ WARN: Missing Security Headers (GitHub Pages Limitation)
| Header | Status |
|---|---|
| Content-Security-Policy | ❌ Missing |
| Strict-Transport-Security | ❌ Missing |
| X-Frame-Options | ❌ Missing |
| X-Content-Type-Options | ❌ Missing |
| Permissions-Policy | ❌ Missing |
| Referrer-Policy | ❌ Missing |
| Access-Control-Allow-Origin | ⚠️ `*` (wide open) |

**Risk Assessment:** LOW — These are standard GitHub Pages limitations; the site is fully static with no server-side processing, forms, auth, or user-submitted content. CORS `*` is also standard for static GitHub Pages. No actionable findings.

### 🧪 Spot Check — Blog Article Headers
- `/blog/gut-brain-axis-second-brain-mood-sleep.html` — Same header profile, 200 OK

## Summary
**No critical issues found.** Security posture is acceptable for a static GitHub Pages site. No credentials leaked, permissions locked down, HTTPS enforced. Missing security headers are a GitHub Pages platform limitation, not actionable without a CDN/proxy like Cloudflare.
