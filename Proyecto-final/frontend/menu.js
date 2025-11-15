document.addEventListener('DOMContentLoaded', () => {
    const menuBtn = document.getElementById('menuBtn');
    const menuMobile = document.getElementById('menuMobile');
    if (menuBtn && menuMobile) {
        menuBtn.addEventListener('click', e => {
            e.stopPropagation();
            menuMobile.classList.toggle('active');
        });
        document.addEventListener('click', e => {
            if(!menuMobile.contains(e.target) && !menuBtn.contains(e.target)) {
                menuMobile.classList.remove('active');
            }
        });
        menuMobile.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', () => menuMobile.classList.remove('active'));
        });
        document.addEventListener('keydown', e => {
            if(e.key==='Escape') menuMobile.classList.remove('active');
        });
    }
});






