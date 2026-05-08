# souro.github.io

Personal website of **Sourabrata Mukherjee** — postdoctoral researcher at Microsoft Research.

Live: https://souro.github.io

## Stack

A hand-built static site. No build step.

```
index.html              ← single-page site
404.html                ← error page
.nojekyll               ← disable Jekyll on GitHub Pages
assets/css/main.css     ← all styles (light + dark theme)
assets/js/main.js       ← theme toggle, reveal-on-scroll, nav state
images/                 ← portrait + favicons
files/pdf/
  Resume_Sourabrata.tex ← one-page CV source
  Resume_Sourabrata.pdf ← compiled CV (linked from /CV)
```

## Local preview

```sh
python3 -m http.server 4000
# open http://localhost:4000
```

## Updating the CV

```sh
cd files/pdf
pdflatex Resume_Sourabrata.tex
rm Resume_Sourabrata.{aux,log,out}
```

## Adding a blog post

Drop `blog/<slug>.html` in the project, then add a list item to the
`#blogList` UL inside `index.html`:

```html
<li>
  <a href="blog/your-post.html">
    <span class="blog-title">Your post title</span>
    <span class="blog-date">2026-05-08</span>
  </a>
</li>
```
