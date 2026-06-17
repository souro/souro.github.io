# Sourabrata Mukherjee — Personal Website Build Summary

This document is a complete handoff so a new chat can continue work on the
**personal website** *without repeating any context*. It is the website
counterpart to `CV_CHAT_SUMMARY.md` (which covers the Typst CV only — do not
duplicate that work here). Read this first, then make requested edits.

---

## 1. What this is

A modern, single-page **personal/research portfolio website** for
`souro.github.io` (GitHub Pages). It was a full redesign from an older
editorial/academic version into an advanced-UI/UX site, with content aligned to
the CV (`files/pdf/Resume_Sourabrata.pdf`).

- **Live site:** https://souro.github.io
- **Repo root:** `~/souro_msr_work/souro.github.io`
- **Stack:** vanilla HTML + CSS + JS (no framework, no build step)
- **Deploy:** commit to `master` and `git push origin master` (GitHub Pages
  serves the repo root; allow a minute for the CDN to rebuild)

---

## 2. Files (the only files that matter)

| File | Role |
|------|------|
| `index.html` | All markup / page content |
| `assets/css/main.css` | Full design system (light + dark) |
| `assets/js/main.js` | All interactions |
| `images/image.jpg` | Hero portrait |
| `images/` (favicons, manifest) | Icons — already present, don't touch |
| `files/pdf/Resume_Sourabrata.pdf` | CV linked from nav/hero/footer/CTA |

**The HTML class names are a contract with the CSS.** If you add a section,
reuse existing class names or add matching CSS. Key class families:
`.bg-fx`/`.orb3`, `.scroll-progress`, `.nav`(`.scrolled`)/`.nav-brand .mark`/
`.nav-links a.active`/`.nav-cta`/`.theme-toggle`/`.nav-burger`, `.mobile-menu`,
`.hero`/`.status-pill .dot-live`/`.grad`/`.hero-roles .chip`/`.hero-actions`/
`.btn`/`.btn-primary`/`.btn-ghost`/`.socials`/`.hero-photo-frame`/`.hero-badge`
(`.b-ico`), `.stats`/`.stat`/`.stat-num [data-count]`, `.about-grid`/
`.about-card`/`.fact`(`.f-ico`/`.f-text`), `.bento`/`.bento-card`/`.bento-ico`,
`.marquee`/`.marquee-track`/`.skill-pill`, `.news-list`, `.pub-list`/`.pub`/
`.pub-num`/`.pub-title`/`.pub-authors .me`/`.pub-venue`/`.pub-badge`
(`.award`/`.year`/`.soon`)/`.view-all`, `.timeline`/`.exp-row`/`.exp-role`/
`.exp-org`/`.exp-date`/`.exp-detail`, `.tile-list`(`.cols-2`)/`.tile`/
`.tile-ico`/`.tile-meta`/`.edu-card .edu-bullets`, `.cert-row`/`.cert`,
`.cta-band`/`.btn-white`/`.btn-outline`, `.footer`, `.to-top`(`.show`),
`.reveal`(`.in`, `[data-delay]`).

---

## 3. Design system (CSS)

- **Theme:** dual light/dark via `data-theme` on `<html>`. An inline script in
  `<head>` sets it early from `localStorage('theme')` or `prefers-color-scheme`
  to avoid flash. Toggle persists to `localStorage`.
- **Brand accent = the CV's teal** for visual continuity:
  `--accent: #0a7d70` (light) / `#2fd6c0` (dark). Secondary `--accent-2` coral,
  tertiary `--accent-3` indigo. All colors are CSS variables in
  `:root` / `[data-theme="dark"]`.
- **Fonts (Google):** Fraunces (serif display), Inter (sans body),
  JetBrains Mono (mono) — linked in `<head>`.
- **Ambient layer:** `.bg-fx` is a fixed gradient-mesh background with drifting
  blurred orbs. Respects `prefers-reduced-motion`.
- **Logo mark** (`.nav-brand .mark`): the word **"souro"** styled as a designed
  wordmark — italic Fraunces serif on the teal→indigo gradient pill, a coral
  accent `.dot`, and a light-sweep shine on hover (`::before`). (It used to be
  "SM"; do not revert.)

---

## 4. Interactions (JS)

`assets/js/main.js` is one IIFE. It provides: theme toggle + persistence; nav
`.scrolled` state on scroll; scroll-progress bar width; mobile menu open/close
(burger + Esc + link click); `.to-top` show/scroll; a **skills marquee** built
in JS (the `skills` array is duplicated for a seamless loop — edit that array to
change pills); IntersectionObserver `.reveal`→`.in`; **stat counters**
animating `[data-count]` when in view; scrollspy that toggles `.active` on nav
links; smooth in-page anchor scrolling (offset for sticky nav); footer year.
All motion is disabled under `prefers-reduced-motion`.

---

## 5. Content facts (aligned to CV — do NOT fabricate)

- **Identity:** Sourabrata Mukherjee — Postdoctoral Researcher at **Microsoft
  Research** (working with **Sunayana Sitaram** and **Kalika Bali**, profiles
  linked). NLP–LLM researcher / applied AI, Bengaluru, India.
- **About** links collaborators/advisors: Charles University / Prof. Ondřej
  Dušek (PhD), MBZUAI / Prof. Monojit Choudhury, **UKP Lab (TU Darmstadt) /
  Prof. Iryna Gurevych**, Panlingua, IISc.
- **Stats strip:** 11+ peer-reviewed papers · 6+ years industry ML · 4 research
  labs · **2 Best Paper Awards**.
- **Research interests (bento, 6):** LLM Evaluation & LLM-as-Judge; Controllable
  Text Generation; Text Style Transfer; Multilingual & Cultural NLP; Reasoning;
  Agentic Development.
- **Publications (`.pub-list`, 11):** real titles/venues/authors carried over
  from the original site + newer CV papers. **Never invent author lists.** Badges:
  `.award` (Best Paper / Honorable Mention), `.year`, `.soon` (Under review).
  "View all" links to Google Scholar
  `https://scholar.google.com/citations?user=sYNjrdsAAAAJ`.
- **Experience timeline:** Microsoft Research (current) → MBZUAI → UFAL/Charles
  Univ (PhD) → Panlingua → UKP Lab → IISc → Tricon → Avaya → o9 → Amdocs.
- **Education tiles:** PhD (Charles Univ), M.Tech (NIT Durgapur, 9.06), B.Tech
  (WBUT, 8.79) with CV bullets.
- **Awards (`.tile-list.cols-2`):** Best Paper — BLP @ EMNLP 2023;
  CU Grant Agency Award (as PI); **Star Employee of the Year — Amdocs & Tricon**
  (NOT o9); National Winner — IBM Tech Competition. Certifications row via
  Coursera.
- **Socials:** Email, Google Scholar, GitHub (`souro`), LinkedIn (`in/souro`).
  **ORCID was intentionally removed** — do not add it back unless asked.

---

## 6. Local preview / verification

```bash
cd ~/souro_msr_work/souro.github.io
python3 -m http.server 8765       # then open http://localhost:8765/index.html
```

`file://` does not work in the integrated browser (untrusted-folder 403); always
serve over HTTP. Verify both themes and the mobile (<760px) nav/menu. After
editing, hard-refresh (Ctrl/Cmd+Shift+R) — GitHub Pages + browser caching can
make the live site look stale even though the push succeeded.

---

## 7. Edit playbook / lessons learned

- **Stale live site ≠ broken code.** If `git status` is clean and
  `HEAD == origin/master`, the change is deployed; the user is seeing a cache.
  Tell them to hard-refresh / wait for the Pages rebuild.
- Keep the **CV teal** as the brand accent; reuse CV content verbatim where
  possible; keep content factual.
- Hero **Download CV** button is deliberately understated (solid ink → teal on
  hover), not a bright gradient. Keep primary CTAs calm.
- Badge/pill icons (`.b-ico`, `.mark`) are small fixed boxes — size SVGs
  explicitly (e.g. `.b-ico svg { width:16px }`) and avoid `<small>` text that
  overflows below the box.
- Use `multi_replace_string_in_file` for batched edits; reload the served page
  and screenshot to validate visually.

---

## 8. Quick task index (where to edit)

| Want to change… | Edit |
|---|---|
| A headline number | `index.html` `.stats` `data-count` + label |
| Skills pills | `skills` array in `assets/js/main.js` |
| Add/remove a paper | `.pub-list` in `index.html` (set `.pub-num`, badge) |
| Colors / theme | CSS variables in `:root` / `[data-theme="dark"]` |
| Logo wordmark | `.nav-brand .mark` (HTML text + CSS) |
| Nav links / sections | `.nav-links`, `.mobile-menu`, matching `id`s |
