document.addEventListener("turbo:load", function () {
  const menuToggle = document.getElementById("menu-toggle");
  const menu = document.getElementById("menu");

  if (menuToggle && menu) {
    menuToggle.addEventListener("click", function () {
      menu.classList.toggle("hidden");
      // メニューを表示したときにトグルボタンがクリック可能であることを確認
      menuToggle.disabled = false;
    });

    // メニュー内でのクリックがトグルボタンを再度有効にする
    menu.addEventListener("click", function () {
      console.log("Menu clicked");
      menuToggle.disabled = false; // トグルボタンを再度有効にする
    });
  }
});
