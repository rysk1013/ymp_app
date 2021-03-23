function comment() {
  const submit = document.getElementById("submit");
  submit.addEventListener("click", (e) => {
    const formPath = document.getElementById("form").getAttribute("action");
    const formData = new FormData(document.getElementById("form"));
    const XHR = new XMLHttpRequest();
    XHR.open("POST", `${formPath}`, true);
    XHR.responseType = "json";
    XHR.send(formData);

    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      }
      const comment = XHR.response.comment;
      const user = XHR.response.user;
      const list = document.getElementById("list");
      const formText = document.getElementById("content");
      const HTML = `
        <li class="comments-list">
          <a href="/users/${user.id}">
          ${user.nickname}: 
          </a> 
          ${comment.text}
        </li>`;
      list.insertAdjacentHTML("beforebegin", HTML);
      formText.value = "";
    };
    e.preventDefault();
  });
}
window.addEventListener('load', comment);