// =============================================================
//  Sourabrata Mukherjee — CV
//  Typst design replicating the reference layout
//  Build:  typst compile --font-path fonts Resume_Sourabrata.typ
// =============================================================
#import "@preview/fontawesome:0.5.0": *

// ---- palette (sampled exactly from reference cv (1).pdf) ----
#let accent   = rgb(0, 102, 92)       // #00665C teal
#let headerbg = rgb(0, 102, 92)
#let datecol  = rgb(151, 151, 151)    // #979797 timeline dates
#let subcol   = rgb(200, 200, 200)    // #C8C8C8 header subtitle
#let pillbd   = rgb("#B9BEBE")
#let ink      = rgb(46, 46, 46)       // #2E2E2E body text
#let inst     = rgb(46, 46, 46)

// ---- fonts (reference uses Fira Sans for display, Noto Sans for body) ----
#let display = "Fira Sans"
#let body    = "Noto Sans"

#set document(title: "Sourabrata Mukherjee — CV", author: "Sourabrata Mukherjee")
#set text(font: body, weight: 300, size: 8pt, fill: ink, lang: "en")
#set par(justify: false, leading: 0.62em)

#let pagew = 21cm
#let mx = 1.15cm

#set page(
  paper: "a4",
  margin: (left: mx, right: mx, top: 1.0cm, bottom: 0.7cm),
  background: place(top + left, dx: 6.65cm, dy: 1.0cm,
    line(angle: 90deg, length: 27.3cm, stroke: 0.6pt + rgb("#C4C9C9"))),
  footer: context [
    #set text(7.3pt, fill: datecol)
    #align(center)[Sourabrata Mukherjee · CV #h(4pt)·#h(4pt) August, 2026]
  ],
)

// ---------- helpers ----------
#let icon-txt(ic, body) = box[#text(fill: white)[#ic] #h(3pt) #body]

// main section heading: Fira Sans small caps, teal, with trailing rule
#let section(title) = {
  v(5pt)
  grid(columns: (auto, 1fr), column-gutter: 9pt, align: (left+horizon, left+horizon),
    text(font: display, fill: accent, weight: 400, size: 12.5pt)[#smallcaps(title)],
    line(length: 100%, stroke: 0.5pt + accent),
  )
  v(4pt)
}

// sidebar section heading: Fira Sans small caps, teal, with short rule
#let side-section(title) = {
  v(2.5pt)
  text(font: display, fill: accent, weight: 400, size: 9.4pt)[#smallcaps(title)]
  v(0.5pt)
  line(length: 100%, stroke: 0.5pt + accent)
  v(1pt)
}

#let pill(txt) = box(
  stroke: 0.5pt + pillbd, radius: 2pt, inset: (x: 4pt, y: 2.5pt),
  outset: (y: 1.5pt),
)[#text(size: 6.6pt, fill: ink, txt)]

#let langbar(name, level) = {
  block(spacing: 3.2pt)[
    #grid(columns: (1.55cm, 1fr), column-gutter: 4pt, align: (left + horizon, left + horizon),
      text(size: 7.3pt, name),
      grid(columns: (1fr,)*5, column-gutter: 2.5pt,
        ..range(5).map(i => box(width: 100%, height: 3.4pt, radius: 1pt,
          fill: if i < level { accent } else { white },
          stroke: 0.55pt + accent))))
  ]
}

// timeline: pass an array of (date, title, org, loc, desc)
#let timeline(entries) = {
  let rows = ()
  for e in entries {
    // date cell (right-aligned gray, gap before the line)
    rows.push(align(right + top)[#text(fill: datecol, size: 7.2pt, e.date)])
    // body cell — left inset keeps text off the divider; circle sits on line
    rows.push(block(below: 0pt)[
      #place(left + top, dx: -0.5cm - 3pt, dy: 2.5pt,
        circle(radius: 2.8pt, fill: accent, stroke: none))
      #text(font: body, weight: 600, size: 8.6pt, fill: ink, e.title)
      #v(2.8pt, weak: true)
      #text(fill: ink, size: 7.7pt)[#smallcaps(e.org)#if e.loc != "" [#h(5pt)#text(fill: accent)[#fa-location-dot()]#h(2pt)#smallcaps(e.loc)]]
      #if "desc" in e and e.desc != "" {
        v(2pt, weak: true)
        text(size: 7.3pt, fill: ink, e.desc)
      }
      #if "bullets" in e {
        v(2.5pt, weak: true)
        for b in e.bullets {
          block(below: 2.5pt)[
            #grid(columns: (8pt, 1fr), column-gutter: 0pt, align: (left + top, left + top),
              text(fill: accent, size: 7.3pt)[•],
              text(size: 7.3pt, fill: ink)[#b],
            )
          ]
        }
      }
    ])
  }
  grid(
    columns: (1.5cm, 1fr),
    column-gutter: 0.5cm,
    row-gutter: 0.92em,
    inset: ((:), (left: 0.5cm)),
    grid.vline(x: 1, stroke: 0.9pt + accent),
    ..rows,
  )
}

#let pub(body) = block(below: 0.5em)[#text(size: 7.2pt, fill: ink, body)]

// Google Scholar profile (all publications link here)
#let scholar = "https://scholar.google.com/citations?view_op=list_works&hl=en&hl=en&user=sYNjrdsAAAAJ"

// publication entry: title + venue (+ optional note), on the timeline
#let publ(title, venue, note: none) = block(below: 0pt)[
  #place(left + top, dx: -0.5cm - 3pt, dy: 2.5pt,
    circle(radius: 2.8pt, fill: accent, stroke: none))
  #text(font: body, weight: 500, size: 7.9pt, fill: ink)[#title]
  #linebreak()
  #text(size: 7.4pt)[#smallcaps(venue)#if note != none [#if note == "Communicated" [ #text(size: 6.6pt, style: "italic", fill: datecol)[(#note)]] else [ · #note]]]
]

// small filled teal dot for the publications timeline
#let yeardot = place(left + top, dx: -0.5cm - 2.5pt, dy: 3pt,
  circle(radius: 2.5pt, fill: accent, stroke: none))

// =============================================================
//  HEADER BAND (full bleed, page 1)
// =============================================================
#place(top + left, dx: -mx, dy: -1.0cm, float: false,
  block(width: pagew, height: 2.95cm, fill: headerbg, inset: (left: mx, right: mx, top: 0.55cm, bottom: 0.45cm))[
    #grid(columns: (1.12fr, 1fr), align: (left + horizon, left + horizon), column-gutter: 8pt,
      [
        #stack(spacing: 7pt,
          text(font: display, fill: white, size: 27pt, hyphenate: false)[#text(weight: 300)[Sourabrata] #text(weight: 500)[Mukherjee]],
          text(font: display, fill: subcol, weight: 400, size: 10pt)[#smallcaps[Research Scientist] #h(2pt)·#h(2pt) #smallcaps[Applied Scientist] #h(2pt)·#h(2pt) #smallcaps[NLP – LLMs]],
        )
      ],
      [
        #set text(font: body, weight: 300, fill: white, size: 7.9pt)
        #pad(left: 8pt)[
          #grid(columns: (auto, auto), column-gutter: 14pt, row-gutter: 5pt,
            icon-txt(fa-location-dot(), [Bengaluru, India]),
            icon-txt(fa-linkedin(), link("https://www.linkedin.com/in/souro")[in/souro]),
            icon-txt(fa-globe(), link("https://souro.github.io")[Personal Website]),
            icon-txt(fa-graduation-cap(), link("https://scholar.google.com/citations?user=sYNjrdsAAAAJ")[Google Scholar]),
            icon-txt(fa-envelope(), link("mailto:connect.souro@gmail.com")[connect.souro\@gmail.com]),
            icon-txt(fa-github(), link("https://github.com/souro")[souro]),
            icon-txt(fa-envelope(), link("mailto:sourabrata.mukhergeek@gmail.com")[sourabrata.mukhergeek\@gmail.com]),
            box[#box(baseline: 1.5pt, image("pics/hf.svg", height: 8pt)) #h(3pt) #link("https://huggingface.co/Souro")[Hugging Face]],
          )
        ]
      ],
    )
  ]
)

#v(2.05cm)

// =============================================================
//  SINGLE-PAGE BODY — two columns
// =============================================================
#grid(
  columns: (5.2cm, 1fr),
  column-gutter: 0.65cm,
  // ---------- left sidebar ----------
  [
    #align(center)[
      #box(width: 2.75cm, height: 2.75cm, radius: 50%, clip: true, stroke: 1.5pt + accent, fill: white)[
        #place(top + center, dy: 0.15cm)[
          #image("pics/profile.jpg", width: 2.55cm)
        ]
      ]
    ]
    #v(2pt)

    #side-section[About me]
    #text(size: 7.3pt)[
      Research scientist and engineer working on LLM training, alignment,
      interpretability, and evaluation. Postdoctoral Researcher at Microsoft
      Research; PhD from Charles University, Prague; 6+ years shipping
      production ML under real-world constraints.
    ]

    #side-section[Research Interests]
    #set text(size: 7.3pt)
    - LLM Evaluation & LLM-as-Judge
    - Post-training & Alignment
    - Mechanistic Interpretability
    - Multilingual & Cultural NLP
    - Controllable Generation
    - Reasoning & Agentic Systems

    #side-section[Skills & Knowledge]
    #text(size: 6.9pt, weight: 600, fill: accent)[Training & Alignment] #v(1.5pt, weak: true)
    #pill[Full fine-tuning] #pill[PEFT / LoRA] #pill[Instruction tuning]
    #pill[DPO] #pill[PPO] #pill[GRPO] #pill[RLHF] #pill[Reward modelling]
    #v(3pt, weak: true)
    #text(size: 6.9pt, weight: 600, fill: accent)[Interpretability & Evaluation] #v(1.5pt, weak: true)
    #pill[Mechanistic interpretability] #pill[Probing] #pill[LLM-as-Judge]
    #pill[Benchmark design] #pill[Human evaluation] #pill[Calibration]
    #v(3pt, weak: true)
    #text(size: 6.9pt, weight: 600, fill: accent)[Engineering] #v(1.5pt, weak: true)
    #pill[Python] #pill[PyTorch] #pill[Hugging Face] #pill[vLLM]
    #pill[Distributed training] #pill[RAG & agents]

    #side-section[Service]
    #text(size: 7.3pt)[
      Reviewer · #text(weight: 600)[ACL, EMNLP, NeurIPS, ICLR, COLM, INLG]
    ]

    #side-section[Languages]
    #langbar("Bengali", 5)
    #langbar("English", 5)
    #langbar("Hindi", 4)
    #langbar("Czech", 1)
    #langbar("German", 1)

    #v(1pt)
    #side-section[Awards]
    #set text(size: 7.3pt)
    #set list(spacing: 2pt)
    - #text(weight: 600)[Best Paper Award] · BLP \@ EMNLP 2023
    - #text(weight: 600)[CU Grant Agency Award] · as PI
    - #text(weight: 600)[Star Employee of the Year] · Amdocs & Tricon
    - #text(weight: 600)[National Winner] · IBM Tech Competition

    #side-section[Certification]
    #set text(size: 7.3pt)
    #set list(spacing: 1.5pt)
    - Generative AI with LLMs
    - Deep Neural Networks & Tuning
    - Machine Learning & Statistics
    #text(size: 6.8pt, fill: accent)[#fa-graduation-cap() #h(2pt)#text(fill: datecol)[via Coursera]]
  ],
  // ---------- right main ----------
  [
    #section("Research & Software Development")
    #timeline((
      (date: [since 07/2025], title: "Postdoctoral Researcher",
       org: "Microsoft Research", loc: "Bengaluru, India",
       desc: "LLM evaluation, multilingual NLP, alignment, and controllable generation for Language AI."),
      (date: [from 07/2024 #linebreak() to 03/2025], title: "Visiting Researcher",
       org: "MBZUAI", loc: "Abu Dhabi, UAE",
       desc: "Cultural and cross-lingual dimensions of large language models."),
      (date: [from 01/2022 #linebreak() to 06/2022], title: "Research Intern",
       org: "Panlingua Language Processing", loc: "New Delhi, India",
       desc: "Low-resource machine translation for Indian languages."),
      (date: [from 10/2019 #linebreak() to 04/2025], title: "PhD Researcher",
       org: "UFAL, Charles University", loc: "Prague, Czechia",
       desc: "Research on Text Style Transfer with neural language models."),
      (date: [from 12/2018 #linebreak() to 05/2019], title: "Research Assistant",
       org: "UKP Lab, TU Darmstadt", loc: "Darmstadt, Germany",
       desc: "Context detection for scientific data-to-text generation."),
      (date: [from 02/2018 #linebreak() to 08/2018], title: "Data Science Visiting Intern",
       org: "Indian Institute of Science (IISc)", loc: "Bengaluru, India",
       desc: "Time-series forecasting and predictive analytics."),
      (date: [from 06/2017 #linebreak() to 09/2019], title: "Senior ML Engineer → AI Tech Lead",
       org: "Tricon Infotech", loc: "Bengaluru, India",
       desc: "Product- and domain-specific recommendation engine at scale."),
      (date: [from 04/2016 #linebreak() to 05/2017], title: "Senior Big Data Engineer",
       org: "Avaya", loc: "Bengaluru, India",
       desc: "Log-analysis pipeline with optimized storage and real-time monitoring."),
      (date: [from 05/2015 #linebreak() to 03/2016], title: "Senior Analytics Engineer",
       org: "o9 Solutions", loc: "Bengaluru, India",
       desc: "Scalable enterprise planning recommendation framework."),
      (date: [from 01/2014 #linebreak() to 04/2015], title: "Software → Senior Software Engineer",
       org: "Amdocs", loc: "Pune, India",
       desc: "Recommendation engine and search for e-commerce platforms."),
    ))

    #section("Education")
    #timeline((
      (date: [from 10/2019 #linebreak() to 04/2025], title: "PhD in Computational Linguistics",
       org: "Charles University", loc: "Prague, Czechia",
       bullets: (
         [#text(weight: 600)[Thesis:] Text Style Transfer using Neural Models],
         [#text(weight: 600)[Advisor:] Ondřej Dušek],
       )),
      (date: [from 2011 #linebreak() to 2013], title: "M.Tech in Computer Science & Engineering",
       org: "NIT Durgapur", loc: "Durgapur, India",
       bullets: (
         [#text(weight: 600)[GPA:] 9.06 / 10],
         [#text(weight: 600)[Thesis:] Real-world multi-objective optimization using evolutionary algorithms],
         [Among the top-ranked students of the class],
       )),
      (date: [from 2007 #linebreak() to 2011], title: "B.Tech in Computer Science & Engineering",
       org: "West Bengal University of Technology", loc: "Kolkata, India",
       bullets: (
         [#text(weight: 600)[GPA:] 8.79 / 10],
         [#text(weight: 600)[Project:] Random number generation using Monte Carlo methods],
         [Graduated as college topper],
       )),
    ))

    #v(4pt)
    #grid(columns: (auto, auto, 1fr), column-gutter: 7pt, align: (left+horizon, left+horizon, left+horizon),
      text(font: display, fill: accent, weight: 400, size: 12.5pt)[#smallcaps[Recent Publications]],
      link("https://scholar.google.com/citations?user=sYNjrdsAAAAJ")[#text(fill: accent, size: 7.3pt)[#fa-google-scholar() #h(2pt)#text(weight: 500)[View all] #fa-arrow-up-right-from-square(size: 0.75em)]],
      line(length: 100%, stroke: 0.5pt + accent),
    )
    #v(3pt)
    #grid(columns: (1.5cm, 1fr), column-gutter: 0.5cm, row-gutter: 0.62em,
      inset: ((:), (left: 0.5cm)),
      grid.vline(x: 1, stroke: 0.9pt + accent),
      [], publ("Actions Speak Louder than Words: On the Cross-Lingual Invariance of Agentic Tool Use", "COLM 26", note: "Spotlight · Top 15%"),
      [], publ("Building Benchmarks from the Ground Up: Community-Centered Evaluation of LLMs in Healthcare Chatbot Settings", "CHI 26", note: "Honorable Mention"),
      [], publ("Women, Infamous, and Exotic Beings: A Comparative Study of Honorific Usages in Wikipedia and LLMs for Bengali and Hindi", "EMNLP Main 25"),
      [], publ("The Geometry of LLM-as-Judge: Why Inter-LLM Consensus Is Not Human Alignment", "EMNLP 26", note: "Communicated"),
      [], publ("Opening the Judge: What LLM Evaluators Compute but Do Not Report", "EACL 26", note: "Communicated"),
      [], publ("Evaluation Is Training: Confidence Outruns Correctness When the Judge Is the Target", "EACL 26", note: "Communicated"),
    )
  ],
)
