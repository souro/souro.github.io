# Sourabrata Mukherjee — CV / Résumé Build Summary

This document is a complete handoff so a new chat can continue work on the CV
**without repeating any context**. Read this first, then make requested edits.

---

## 1. What this is

A **single-page Typst CV** that exactly replicates the design of a reference CV
(Zdeněk Kasner's Typst CV, file `cv (1).pdf`) but with Sourabrata Mukherjee's
content. It is targeted at applications for a **Senior Research & Development
Engineer / Applied AI** role.

- **Deliverable (source):** `souro.github.io/files/pdf/Resume_Sourabrata.typ`
- **Deliverable (output):** `souro.github.io/files/pdf/Resume_Sourabrata.pdf`
  (the website links to this path — do not move it)
- **Reference design:** `souro.github.io/files/pdf/cv (1).pdf` (input, do NOT delete)
- **Hard constraint:** must always stay **ONE PAGE**.

---

## 2. How to build / compile

Typst 0.13.1 lives at `~/.local/bin/typst`. The font path flag is **required**
(for both Fira Sans and FontAwesome icons).

```bash
export PATH="$HOME/.local/bin:$PATH"
cd ~/souro_msr_work/souro.github.io/files/pdf
typst compile --font-path fonts Resume_Sourabrata.typ Resume_Sourabrata.pdf
```

### Verify page count (must be 1)
```bash
pdfinfo Resume_Sourabrata.pdf | grep Pages
```

### Render to PNG for visual inspection
```bash
pdftoppm -png -r 150 Resume_Sourabrata.pdf /tmp/mine
# then view /tmp/mine-1.png ; if a /tmp/mine-2.png exists, it overflowed
```

### Python venv (for pdfplumber / PIL inspection)
```bash
source /home/souro/venv_souro/bin/activate
```

**Cleanup temp files when done:** `rm -f /tmp/mine-*.png /tmp/ov.png /tmp/*.png`
Never delete `cv (1).pdf`, `Profile.pdf`, or anything in `fonts/`.

---

## 3. Design / styling facts (sampled exactly from the reference)

### Fonts (must match reference exactly — NOT Lato)
- **Display** = `Fira Sans` (Light/Regular/Medium TTFs in `files/pdf/fonts/`)
- **Body** = `Noto Sans` (system font)
- Both have native OTF small caps, so Typst `smallcaps()` works directly.

### Colors
| Name      | RGB / Hex      | Use |
|-----------|----------------|-----|
| accent    | `#00665C` teal | headings, header band, icons, bullets |
| datecol   | `#979797`      | timeline dates, muted captions |
| subcol    | `#C8C8C8`      | header subtitle |
| ink       | `#2E2E2E`      | body text |
| pillbd    | `#B9BEBE`      | skill pill borders |
| divider   | `#C4C9C9`      | background vertical divider line |

### Font sizes (key ones)
- Name 27pt; main heading 12.5pt Fira teal smallcaps; sidebar heading 9.6pt;
  subtitle 10pt; job/edu title 8.6pt Noto SemiBold(600); org/loc 7.7pt smallcaps;
  desc 7.3pt; dates 7.2pt; pills 6.6pt.

### FontAwesome
- Package `@preview/fontawesome:0.5.0`; OTFs in `files/pdf/fonts/`.

### Typst gotchas
- `@` in text = label ref → escape as `\@` (e.g. `BLP \@ EMNLP`).
- Box needs `width: 100%` to fill a grid cell.
- Use native `smallcaps()` (the old synthetic `smcp()` helper was removed).

---

## 4. Current file structure (`Resume_Sourabrata.typ`)

- **Palette + fonts** defined at top.
- **Page:** A4, margins L/R = `mx` (1.15cm), top 1.0cm, **bottom 0.85cm**.
  Background vertical divider at `dx: 6.65cm`. Centered footer:
  `Sourabrata Mukherjee · CV · June, 2026`.
- **Helpers:** `section()`, `side-section()`, `pill()`, `langbar()`,
  `timeline()`, `publ()`.
- **Header band:** full-bleed teal, height **2.95cm**. Left half = name
  ("Sourabrata" weight 300 + "Mukherjee" weight 500, 27pt) stacked tightly with
  tagline; right half = 2-col contacts (padded right via `#pad(left: 14pt)`).
- **Body:** single `#grid(columns: (5.2cm, 1fr), column-gutter: 0.65cm, ...)`
  → left sidebar + right main column.

---

## 5. Current CONTENT (as it stands now)

### Header
- Name: **Sourabrata Mukherjee**
- Tagline: `NLP–LLM Researcher · Applied AI`
- Contacts: 📍 Bengaluru, India · in/souro · souro.github.io · Google Scholar ·
  soura1990@gmail.com · github souro

### Sidebar (left column, top → bottom)
1. **Photo** — circular, `pics/profile.jpg`.
2. **About me:**
   > NLP–LLMs researcher and engineer who turns research into working systems.
   > Postdoctoral Researcher at Microsoft Research; PhD from Charles University,
   > Prague; 6+ years building production ML, bridging research and engineering
   > under real-world constraints.
3. **Research Interests:** LLM Evaluation & LLM-as-Judge · Controllable Text
   Generation · Text Style Transfer · Multilingual & Cultural NLP · Reasoning ·
   Agentic Development
4. **Skills & Knowledge (pills):** Python, PyTorch, NLP, LLMs, Machine Learning,
   Multilingual NLP, Text Generation, Evaluation, Hugging Face,
   Distributed Training, RLHF / Alignment, Interpretability
5. **Languages (segmented bars 1–5):** Bengali 5, English 5, Hindi 4, Czech 1,
   German 1
6. **Awards:**
   - Best Paper Award — BLP @ EMNLP 2023
   - CU Grant Agency Award — as PI
   - Star Employee of the Year — Tricon & o9
   - National Winner — IBM Tech Competition
7. **Certification (bulleted):** Generative AI with LLMs · Deep Neural Networks
   & Tuning · Machine Learning & Statistics — with a "🎓 via Coursera" caption.

### Main column (right)

**Research & Software Development** (timeline, newest first):
| Dates | Title | Org | Location |
|-------|-------|-----|----------|
| since 07/2025 | Postdoctoral Researcher | Microsoft Research | Bengaluru, India |
| 07/2024–03/2025 | Visiting Research Scientist | MBZUAI | Abu Dhabi, UAE |
| 01/2022–06/2022 | Research Intern | Panlingua Language Processing | New Delhi, India |
| 10/2019–04/2025 | PhD Researcher | UFAL, Charles University | Prague, Czechia |
| 12/2018–05/2019 | Research Assistant | UKP Lab, TU Darmstadt | Darmstadt, Germany |
| 02/2018–08/2018 | Data Science Visiting Intern | Indian Institute of Science (IISc) | Bengaluru, India |
| 06/2017–09/2019 | Lead ML Technical Specialist | Tricon Infotech | Bengaluru, India |
| 04/2016–05/2017 | Senior Data Engineer | Avaya | Bengaluru, India |
| 05/2015–03/2016 | Senior Analytics Engineer | o9 Solutions | Bengaluru, India |
| 01/2014–04/2015 | Senior Software Engineer | Amdocs | Pune, India |

Job descriptions (one line each):
- Microsoft: "Multilingual NLP, LLM evaluation, and controllable generation for Language AI."
- MBZUAI: "Cultural and cross-lingual dimensions of large language models."
- Panlingua: "Low-resource machine translation for Indian languages."
- PhD: "Research on Text Style Transfer with neural language models."
- UKP: "Context detection for scientific data-to-text generation."
- IISc: "Time-series forecasting and predictive analytics."
- Tricon: "Product- and domain-specific recommendation engine at scale."
- Avaya: "Log-analysis pipeline with optimized storage and real-time monitoring."
- o9: "Scalable enterprise planning recommendation framework."
- Amdocs: "Recommendation engine and search for e-commerce platforms."

**Education** (with bullets):
- **PhD in Computational Linguistics** — Charles University, Prague (10/2019–04/2025)
  - Thesis: Text Style Transfer using Neural Models
  - Advisor: Ondřej Dušek
- **M.Tech CSE** — NIT Durgapur (2011–2013)
  - GPA: 9.06 / 10
  - Thesis: Real-world multi-objective optimization using evolutionary algorithms
  - Among the top-ranked students of the class
- **B.Tech CSE** — West Bengal University of Technology, Kolkata (2007–2011)
  - GPA: 8.79 / 10
  - Project: Random number generation using Monte Carlo methods
  - Graduated as college topper

**Selected Publications** (heading has a clickable "🎓 View all ↗" link to
Google Scholar; per-publication links were removed). Order:
1. Building Benchmarks from the Ground Up: Community-Centered Evaluation of LLMs in Healthcare Chatbot Settings — *CHI 26 · Honorable Mention*
2. Women, Infamous, and Exotic Beings: A Comparative Study of Honorific Usages in Wikipedia and LLMs for Bengali and Hindi — *EMNLP Main 25*
3. Actions Speak Louder than Words: On the Cross-Lingual Invariance of Agentic Tool Use — *COLM 26 (Communicated)*
4. The Geometry of LLM-as-Judge: Why Inter-LLM Consensus Is Not Human Alignment — *EMNLP 26 (Communicated)*
5. Are Large Language Models Actually Good at Text Style Transfer? — *INLG 25*
6. Evaluating Text Style Transfer Evaluation: Are There Any Reliable Metrics? — *NAACL – SRW 25*

Publication note styling: plain notes (like "Honorable Mention") render the same
as the venue; **"Communicated"** renders small, italic, gray, in parentheses
(not highlighted). Logic lives in the `publ()` helper.

Google Scholar URL used everywhere:
`https://scholar.google.com/citations?user=sYNjrdsAAAAJ`

---

## 6. Single-page fitting playbook

The sidebar (left column) is the usual source of overflow. When an edit pushes
it to 2 pages, tighten in roughly this order until `pdfinfo` shows `Pages: 1`:
1. Shorten the newly added text so each line fits (most effective).
2. Reduce `row-gutter` / `list spacing` in the affected block.
3. Reduce inter-section `#v(...)` spacing in the sidebar.
4. As a last resort, reduce page bottom margin (currently 0.85cm).

Always recompile and confirm `Pages: 1` after any content change.

---

## 7. Active constraints / preferences (do not violate)

- **One page**, always.
- Fonts stay **Fira Sans (display) + Noto Sans (body)**.
- Output stays at `files/pdf/Resume_Sourabrata.pdf` (website link).
- **No teaching / lecturing** content.
- PhD intentionally appears in BOTH "Research & Software Development"
  (as "PhD Researcher") and "Education" (as the degree) — this is wanted.
- Old LaTeX files (`Resume_Sourabrata.tex`, `sixtysecondscv.cls`) were deleted;
  the CV is Typst-only now.
- Repo memory note: `/memories/repo/cv_website_build.md` documents build setup.

---

## 8. Quick-start prompt for a new chat

> Continue working on my Typst CV at
> `souro.github.io/files/pdf/Resume_Sourabrata.typ`. Read
> `souro.github.io/files/CV_CHAT_SUMMARY.md` first for full context. Build with
> `export PATH="$HOME/.local/bin:$PATH" && cd <pdf dir> && typst compile
> --font-path fonts Resume_Sourabrata.typ Resume_Sourabrata.pdf`, and always keep
> it to ONE page (verify with `pdfinfo ... | grep Pages`). Here is my next change: …
