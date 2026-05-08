// ──────────────────────────────────────────────
// theme toggle + persistence
// ──────────────────────────────────────────────
(function () {
  const root = document.documentElement;
  const toggle = document.getElementById('themeToggle');
  if (!toggle) return;

  toggle.addEventListener('click', () => {
    const current = root.getAttribute('data-theme') === 'dark' ? 'dark' : 'light';
    const next = current === 'dark' ? 'light' : 'dark';
    root.setAttribute('data-theme', next);
    try { localStorage.setItem('theme', next); } catch (e) {}
  });
})();

// ──────────────────────────────────────────────
// nav border on scroll
// ──────────────────────────────────────────────
(function () {
  const nav = document.getElementById('nav');
  if (!nav) return;
  const onScroll = () => {
    nav.classList.toggle('scrolled', window.scrollY > 4);
  };
  document.addEventListener('scroll', onScroll, { passive: true });
  onScroll();
})();

// ──────────────────────────────────────────────
// reveal on scroll
// ──────────────────────────────────────────────
(function () {
  const items = document.querySelectorAll('.reveal');
  if (!('IntersectionObserver' in window) || items.length === 0) {
    items.forEach(i => i.classList.add('in'));
    return;
  }
  const io = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.classList.add('in');
        io.unobserve(e.target);
      }
    });
  }, { threshold: 0.08, rootMargin: '0px 0px -40px 0px' });
  items.forEach(i => io.observe(i));
})();

// ──────────────────────────────────────────────
// year + blog placeholder
// ──────────────────────────────────────────────
(function () {
  const y = document.getElementById('year');
  if (y) y.textContent = new Date().getFullYear();

  const list = document.getElementById('blogList');
  const empty = document.getElementById('blogEmpty');
  if (list && empty) {
    if (list.children.length === 0) empty.style.display = 'block';
    else empty.style.display = 'none';
  }
})();
