const toggle = document.querySelector('.nav-toggle');
const navigation = document.querySelector('.site-nav');

function closeNavigation() {
  if (!toggle || !navigation) return;
  toggle.setAttribute('aria-expanded', 'false');
  navigation.classList.remove('is-open');
}

if (toggle && navigation) {
  toggle.addEventListener('click', () => {
    const expanded = toggle.getAttribute('aria-expanded') === 'true';
    toggle.setAttribute('aria-expanded', String(!expanded));
    navigation.classList.toggle('is-open', !expanded);
  });

  navigation.addEventListener('click', (event) => {
    if (event.target.closest('a')) closeNavigation();
  });

  document.addEventListener('keydown', (event) => {
    if (event.key === 'Escape' && toggle.getAttribute('aria-expanded') === 'true') {
      closeNavigation();
      toggle.focus();
    }
  });
}

document.addEventListener('DOMContentLoaded', () => {
  if (window.renderMathInElement) {
    window.renderMathInElement(document.body, {
      delimiters: [
        { left: '\\[', right: '\\]', display: true },
        { left: '\\(', right: '\\)', display: false }
      ],
      throwOnError: false,
      output: 'htmlAndMathml'
    });
  }

  document.querySelectorAll('.prose table').forEach((table, index) => {
    if (table.parentElement.classList.contains('table-scroll')) return;
    const wrapper = document.createElement('div');
    wrapper.className = 'table-scroll';
    wrapper.setAttribute('role', 'region');
    const caption = table.querySelector('caption')?.textContent.trim();
    wrapper.setAttribute('aria-label', caption ? `${caption}, scrollable table` : `Scrollable data table ${index + 1}`);
    wrapper.setAttribute('tabindex', '0');
    table.parentNode.insertBefore(wrapper, table);
    wrapper.appendChild(table);
  });

  document.querySelectorAll('.article-body h2[id], .article-body h3[id], .article-body h4[id]').forEach((heading) => {
    const anchor = document.createElement('a');
    anchor.className = 'heading-anchor';
    anchor.href = `#${heading.id}`;
    anchor.textContent = '#';
    anchor.setAttribute('aria-label', `Link to ${heading.textContent.trim()}`);
    heading.prepend(anchor);
  });

  document.querySelectorAll('.article-body pre').forEach((pre) => {
    if (pre.classList.contains('mermaid') || pre.closest('.mermaid')) return;
    let frame = pre.parentElement;
    if (!frame.classList.contains('highlight')) {
      frame = document.createElement('div');
      frame.className = 'code-block';
      pre.parentNode.insertBefore(frame, pre);
      frame.appendChild(pre);
    }
    if (frame.querySelector(':scope > .copy-code')) return;

    const button = document.createElement('button');
    button.className = 'copy-code';
    button.type = 'button';
    button.textContent = 'Copy';
    button.setAttribute('aria-label', 'Copy code to clipboard');
    button.addEventListener('click', async () => {
      const code = pre.querySelector('code');
      try {
        await navigator.clipboard.writeText((code || pre).innerText);
        button.textContent = 'Copied';
        window.setTimeout(() => { button.textContent = 'Copy'; }, 1800);
      } catch {
        const range = document.createRange();
        range.selectNodeContents(code || pre);
        window.getSelection().removeAllRanges();
        window.getSelection().addRange(range);
        button.textContent = 'Selected';
        window.setTimeout(() => { button.textContent = 'Copy'; }, 1800);
      }
    });
    frame.appendChild(button);
  });

  const readingBody = document.querySelector('[data-reading-body]');
  const progressBar = document.querySelector('#reading-progress-bar');
  if (readingBody && progressBar) {
    let scheduled = false;
    const updateProgress = () => {
      const start = readingBody.getBoundingClientRect().top + window.scrollY;
      const available = Math.max(readingBody.offsetHeight - window.innerHeight * 0.45, 1);
      const progress = Math.min(1, Math.max(0, (window.scrollY - start + window.innerHeight * 0.18) / available));
      progressBar.style.transform = `scaleX(${progress})`;
      scheduled = false;
    };
    const requestProgress = () => {
      if (scheduled) return;
      scheduled = true;
      window.requestAnimationFrame(updateProgress);
    };
    window.addEventListener('scroll', requestProgress, { passive: true });
    window.addEventListener('resize', requestProgress);
    updateProgress();
  }

  const tocLinks = [...document.querySelectorAll('.toc a[href^="#"]')];
  if (tocLinks.length && 'IntersectionObserver' in window) {
    const linksById = new Map(tocLinks.map((link) => [decodeURIComponent(link.hash.slice(1)), link]));
    const headings = [...linksById.keys()].map((id) => document.getElementById(id)).filter(Boolean);
    const visible = new Set();
    const setActiveLink = () => {
      const active = headings.find((heading) => visible.has(heading)) || headings
        .filter((heading) => heading.getBoundingClientRect().top < window.innerHeight * 0.3)
        .at(-1);
      tocLinks.forEach((link) => link.removeAttribute('aria-current'));
      if (active) linksById.get(active.id)?.setAttribute('aria-current', 'location');
    };
    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => entry.isIntersecting ? visible.add(entry.target) : visible.delete(entry.target));
      setActiveLink();
    }, { rootMargin: '-18% 0px -70% 0px' });
    headings.forEach((heading) => observer.observe(heading));
  }

  const glossarySearch = document.querySelector('[data-glossary-search]');
  const glossaryItems = [...document.querySelectorAll('[data-glossary-item]')];
  const glossaryEmpty = document.querySelector('[data-glossary-empty]');
  const glossaryStatus = document.querySelector('#glossary-search-status');
  const termCount = document.querySelector('[data-term-count]');
  if (glossarySearch && glossaryItems.length) {
    glossarySearch.addEventListener('input', () => {
      const query = glossarySearch.value.trim().toLocaleLowerCase();
      let visibleCount = 0;
      glossaryItems.forEach((item) => {
        const matches = !query || item.dataset.searchText.includes(query);
        item.hidden = !matches;
        if (matches) visibleCount += 1;
      });
      if (glossaryEmpty) glossaryEmpty.hidden = visibleCount !== 0;
      const label = `${visibleCount} ${visibleCount === 1 ? 'term' : 'terms'}`;
      if (termCount) termCount.textContent = label;
      if (glossaryStatus) glossaryStatus.textContent = `${label} shown`;
    });
  }
});
