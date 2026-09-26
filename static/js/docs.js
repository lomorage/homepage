const input=document.querySelector('[data-doc-filter]');
if(input) input.addEventListener('input',()=>{
  const query=input.value.trim().toLocaleLowerCase();
  document.querySelectorAll('[data-doc-group]').forEach(group=>{
    let visible=0;
    group.querySelectorAll('a').forEach(link=>{
      const match=!query||link.textContent.toLocaleLowerCase().includes(query);
      link.hidden=!match;
      if(match) visible++;
    });
    group.hidden=!visible;
  });
});
