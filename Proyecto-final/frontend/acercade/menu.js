document.addEventListener('DOMContentLoaded', () => {
    const menuBtn = document.getElementById('menuBtn');
    const menuMobile = document.getElementById('menuMobile');
    
    if (!menuBtn || !menuMobile) return;

    menuBtn.addEventListener('click', () => {
        menuMobile.classList.toggle('active');
        menuBtn.classList.toggle('active');
    });

    document.addEventListener('click', (e) => {
        if (!menuMobile.contains(e.target) && !menuBtn.contains(e.target)) {
            menuMobile.classList.remove('active');
            menuBtn.classList.remove('active');
        }
    });

    menuMobile.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', () => {
            menuMobile.classList.remove('active');
            menuBtn.classList.remove('active');
        });
    });
});