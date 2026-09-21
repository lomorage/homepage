// Progressive enhancement: installers and app links work without JavaScript.
// Copying only puts text on the clipboard; it never runs an installer.
document.querySelectorAll('[data-copy]').forEach(button => {
  button.hidden = false;
  button.addEventListener('click', async () => {
    const code = document.getElementById(button.dataset.copy);
    const status = button.closest('li').querySelector('[role="status"]');
    if (!code || !status) return;
    try {
      await navigator.clipboard.writeText(code.textContent);
      status.textContent = button.dataset.success;
    } catch {
      const range = document.createRange();
      range.selectNodeContents(code);
      const selection = window.getSelection();
      selection.removeAllRanges();
      selection.addRange(range);
      code.focus();
      status.textContent = button.dataset.failure;
    }
  });
});
