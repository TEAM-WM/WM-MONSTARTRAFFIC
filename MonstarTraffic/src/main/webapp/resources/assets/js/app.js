// 스크롤 내리면 화살표 보이게
const arrowUp = document.querySelector('.arrow-up');
document.addEventListener('scroll', () => {
  if (window.scrollY > 100 / 2) {
    arrowUp.classList.add('visible');
  } else {
    arrowUp.classList.remove('visible');
  }
});

// 화살표 클릭하면 위로 가기
arrowUp.addEventListener('click', () => {
  scrollIntoView('body');
});

function scrollIntoView(selector) {
  //https://developer.mozilla.org/ko/docs/Web/API/Element/scrollIntoView
  const scrollTo = document.querySelector(selector);
  scrollTo.scrollIntoView({ behavior: 'smooth' });
}

// 상단 메뉴 드롭다운
const subDropdown = document.querySelector('.sub-dropdown');
const subMenu = subDropdown.querySelector('.sub-menu');

subDropdown.addEventListener('click', function(e) {
  e.preventDefault(); // 클릭 시 페이지 이동 방지
  subDropdown.classList.toggle('active');
  subMenu.classList.toggle('active');
});


// 사이드 메뉴 border
window.addEventListener('load', adjustNavHeight);
window.addEventListener('resize', adjustNavHeight);

function adjustNavHeight() {
    const contentWrap = document.querySelector('.content-wrap');
    const asideWrap = document.querySelector('.aside-wrap');
    const nav = asideWrap.querySelector('nav');

    if (contentWrap.offsetHeight > asideWrap.offsetHeight) {
        nav.style.height = contentWrap.offsetHeight + 'px';
    }
}

// 초기 페이지 로드 & 창 크기 변경 시 높이 변경
adjustNavHeight();



