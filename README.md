# Ayush's blog

Plain HTML, no build step, no framework, no dependencies. Hosted free on GitHub Pages.

---

## One-time setup (about 10 minutes)

### 1. Fill in your details

```bash
bash setup.sh
```

It asks for your name, GitHub username, email and tagline, and replaces the
placeholders across every file.

### 2. Create a GitHub account

If you don't have one: <https://github.com/signup>. Free. Your username becomes part
of your blog's URL, so pick one you'll be happy with on a CV.

### 3. Create the repository — the name matters

Go to <https://github.com/new> and name the repo **exactly**:

```
YOUR_USERNAME.github.io
```

Lowercase, matching your username exactly. For example, if your username is `ayushsri`,
the repo must be `ayushsri.github.io`. This exact name is what makes GitHub serve it at
the root domain instead of a subpath.

- Visibility: **Public** (private repos need a paid plan for Pages)
- Do **not** tick "Add a README" — this folder already has one

### 4. Push this folder

```bash
cd path/to/this/folder
git init
git add -A
git commit -m "first post"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_USERNAME.github.io.git
git push -u origin main
```

If git asks for a password, it wants a **personal access token**, not your account
password. Create one at <https://github.com/settings/tokens> → "Generate new token
(classic)" → tick `repo` → copy it and paste it as the password. (Or install the
GitHub CLI and run `gh auth login`, which handles this for you.)

### 5. Turn Pages on

In your repo: **Settings → Pages**
- Source: **Deploy from a branch**
- Branch: **main**, folder: **/ (root)**
- Save

### 6. Wait, then visit

First deploy takes 1–3 minutes. Your blog is live at:

```
https://YOUR_USERNAME.github.io/
```

Watch progress under the repo's **Actions** tab. A green tick means it shipped.

---

## Publishing a new post

```bash
bash new-post.sh "Why Postgres indexes are weird"
```

That creates `posts/why-postgres-indexes-are-weird.html` from the template with
today's date, and prints a snippet to paste into `index.html` so the post appears
on the homepage.

Then:

```bash
git add -A
git commit -m "new post: postgres indexes"
git push
```

Live in under a minute. That's the whole workflow.

---

## Preview locally before pushing

```bash
python3 -m http.server 8000
```

Open <http://localhost:8000>. Press Ctrl+C to stop.

Use this rather than opening the file directly — absolute paths like `/about.html`
only resolve correctly over HTTP.

---

## Custom domain (optional, ~$12/year)

A domain is the only part that costs money, and it's optional.

1. Buy one from Cloudflare Registrar, Namecheap or Porkbun (`yourname.dev` is a good pick).
2. At your registrar, add these DNS records:

   | Type  | Name  | Value |
   |-------|-------|-------|
   | A     | `@`   | `185.199.108.153` |
   | A     | `@`   | `185.199.109.153` |
   | A     | `@`   | `185.199.110.153` |
   | A     | `@`   | `185.199.111.153` |
   | CNAME | `www` | `YOUR_USERNAME.github.io` |

3. In the repo: **Settings → Pages → Custom domain**, enter your domain, Save.
4. Wait for the DNS check to pass, then tick **Enforce HTTPS**.

GitHub provisions the TLS certificate automatically. DNS can take anywhere from a few
minutes to a few hours to propagate.

---

## Files

| Path | What it is |
|------|-----------|
| `index.html` | Homepage and post list. Add new posts here. |
| `about.html` | About page. |
| `posts/` | One HTML file per post. |
| `posts/_template.html` | Starting point for new posts. |
| `assets/style.css` | Shared styling. Edit the `:root` colours to re-skin the whole site. |
| `.nojekyll` | Stops GitHub running Jekyll. Needed so files starting with `_` are served. |
| `robots.txt` / `sitemap.xml` | Search-engine basics. Add each new post to the sitemap. |
| `setup.sh` | One-time placeholder fill. |
| `new-post.sh` | Scaffolds a new post. |

---

## Gotchas

- **404 after pushing?** Check the repo name is exactly `username.github.io`, and that
  Pages is set to branch `main` / root.
- **CSS not loading?** Posts use `../assets/style.css`; pages at the root use
  `assets/style.css`. Keep the relative depth right.
- **Changes not showing?** Hard-refresh (Ctrl/Cmd+Shift+R). GitHub's CDN caches aggressively.
- **Don't delete `.nojekyll`** — without it, Jekyll ignores `_template.html` and anything
  else starting with an underscore.
