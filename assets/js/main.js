/* ============================================================
   Sourabrata Mukherjee — personal site · interactions
   Theme · nav · scroll progress · reveal · scrollspy ·
   stat counters · marquee · mobile menu · to-top
   ============================================================ */
(function () {
  "use strict";

  var root = document.documentElement;

  /* ── theme toggle + persistence ───────────────────────── */
  var themeToggle = document.getElementById("themeToggle");
  function setTheme(t) {
    root.setAttribute("data-theme", t);
    try { localStorage.setItem("theme", t); } catch (e) {}
  }
  if (themeToggle) {
    themeToggle.addEventListener("click", function () {
      var next = root.getAttribute("data-theme") === "dark" ? "light" : "dark";
      setTheme(next);
    });
  }

  /* ── nav scrolled state + scroll progress ─────────────── */
  var nav = document.getElementById("nav");
  var progress = document.getElementById("scrollProgress");
  function onScroll() {
    var y = window.scrollY || window.pageYOffset;
    if (nav) nav.classList.toggle("scrolled", y > 12);

    if (progress) {
      var h = document.documentElement.scrollHeight - window.innerHeight;
      var pct = h > 0 ? (y / h) * 100 : 0;
      progress.style.width = pct + "%";
    }

    var toTop = document.getElementById("toTop");
    if (toTop) toTop.classList.toggle("show", y > 600);
  }
  window.addEventListener("scroll", onScroll, { passive: true });
  onScroll();

  /* ── mobile menu ──────────────────────────────────────── */
  var burger = document.getElementById("navBurger");
  var mobileMenu = document.getElementById("mobileMenu");
  var mobileClose = document.getElementById("mobileClose");
  function closeMenu() { if (mobileMenu) mobileMenu.classList.remove("open"); }
  if (burger && mobileMenu) {
    burger.addEventListener("click", function () { mobileMenu.classList.add("open"); });
  }
  if (mobileClose) mobileClose.addEventListener("click", closeMenu);
  if (mobileMenu) {
    mobileMenu.querySelectorAll("a").forEach(function (a) {
      a.addEventListener("click", closeMenu);
    });
  }
  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape") closeMenu();
  });

  /* ── to-top button ────────────────────────────────────── */
  var toTop = document.getElementById("toTop");
  if (toTop) {
    toTop.addEventListener("click", function () {
      window.scrollTo({ top: 0, behavior: "smooth" });
    });
  }

  /* ── skills marquee (build seamless loop) ─────────────── */
  var skills = [
    "Python", "PyTorch", "NLP", "LLMs", "Machine Learning",
    "Multilingual NLP", "Text Generation", "Evaluation",
    "Hugging Face", "Distributed Training", "RLHF / Alignment",
    "Interpretability", "Transformers", "Prompt Engineering"
  ];
  var track = document.getElementById("skillTrack");
  if (track) {
    var build = function () {
      return skills.map(function (s) {
        return '<span class="skill-pill"><span class="dot"></span>' + s + "</span>";
      }).join("");
    };
    // duplicate the set twice for a seamless infinite scroll
    track.innerHTML = build() + build();
  }

  /* ── reveal on scroll (IntersectionObserver) ──────────── */
  var reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  var reveals = document.querySelectorAll(".reveal");
  if (reduce || !("IntersectionObserver" in window)) {
    reveals.forEach(function (el) { el.classList.add("in"); });
  } else {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add("in");
          io.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12, rootMargin: "0px 0px -8% 0px" });
    reveals.forEach(function (el) { io.observe(el); });
  }

  /* ── stat counters ────────────────────────────────────── */
  function animateCount(el) {
    var target = parseInt(el.getAttribute("data-count"), 10) || 0;
    if (reduce) { el.textContent = target; return; }
    var start = null, dur = 1400;
    function step(ts) {
      if (!start) start = ts;
      var p = Math.min((ts - start) / dur, 1);
      var eased = 1 - Math.pow(1 - p, 3);
      el.textContent = Math.round(eased * target);
      if (p < 1) requestAnimationFrame(step);
      else el.textContent = target;
    }
    requestAnimationFrame(step);
  }
  var counters = document.querySelectorAll("[data-count]");
  if (counters.length) {
    if (!("IntersectionObserver" in window)) {
      counters.forEach(animateCount);
    } else {
      var cio = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            animateCount(entry.target);
            cio.unobserve(entry.target);
          }
        });
      }, { threshold: 0.6 });
      counters.forEach(function (el) { cio.observe(el); });
    }
  }

  /* ── scrollspy: highlight active nav link ─────────────── */
  var navLinks = Array.prototype.slice.call(
    document.querySelectorAll('.nav-links a[href^="#"]')
  );
  var sections = navLinks
    .map(function (l) {
      var id = l.getAttribute("href").slice(1);
      return id ? document.getElementById(id) : null;
    })
    .filter(Boolean);

  if (sections.length && "IntersectionObserver" in window) {
    var spy = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          var id = entry.target.id;
          navLinks.forEach(function (l) {
            l.classList.toggle("active", l.getAttribute("href") === "#" + id);
          });
        }
      });
    }, { rootMargin: "-45% 0px -50% 0px", threshold: 0 });
    sections.forEach(function (s) { spy.observe(s); });
  }

  /* ── smooth-scroll for in-page anchors ────────────────── */
  document.querySelectorAll('a[href^="#"]').forEach(function (a) {
    a.addEventListener("click", function (e) {
      var id = a.getAttribute("href");
      if (id === "#" || id === "#top") {
        e.preventDefault();
        window.scrollTo({ top: 0, behavior: "smooth" });
        return;
      }
      var target = document.querySelector(id);
      if (target) {
        e.preventDefault();
        var top = target.getBoundingClientRect().top + window.scrollY - 76;
        window.scrollTo({ top: top, behavior: "smooth" });
      }
    });
  });

  /* ── footer year ──────────────────────────────────────── */
  var yearEl = document.getElementById("year");
  if (yearEl) yearEl.textContent = new Date().getFullYear();

  /* ── hero highlight belt (seamless scrolling marquee) ─── */
  var heroBelt = document.getElementById("heroBelt");
  if (heroBelt) {
    var beltItems = [
      "PhD · Charles University",
      "Microsoft Research · Postdoctoral Researcher",
      "6+ years of ML engineering",
      "8+ years of research experience"
    ];
    var beltBuild = function () {
      return beltItems.map(function (s) {
        return '<span class="belt-item"><span class="belt-dot"></span>' + s + "</span>";
      }).join("");
    };
    // duplicate the set for a seamless infinite loop
    heroBelt.innerHTML = beltBuild() + beltBuild();
  }
})();
