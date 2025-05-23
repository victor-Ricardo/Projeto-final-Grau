let acaoSelecionada = "";

const botaoAtualizar = document.getElementById("atualizar");
const botaoInstalar = document.getElementById("download");
const botaoLimpar = document.getElementById("limpar");
const botaoUsuarios = document.getElementById("usuarios");
const botaoBackup = document.getElementById("backup");
const botaoAutomacao = document.getElementById("automacao");

const fecharPopup = document.getElementById("cancelar");
const rodarScript = document.getElementById("confirmar");
const main = document.getElementById("main");
const footer = document.getElementById("footer");


const popup = document.querySelector(".pop-up");
const paragrafo = document.getElementById("mensagem");

function popupConfirmacao(mensagem) {
    paragrafo.textContent = mensagem;
    popup.style.display = "flex";
    main.style.display = "none";
    footer.style.display = "none";

}

botaoAtualizar.addEventListener("click", (event) => {
    event.preventDefault();
    acaoSelecionada = "atualizar";
    popupConfirmacao("Realmente gostaria de executar o script para atualizar os aplicativos?");
});

botaoInstalar.addEventListener("click", (event) => {
    event.preventDefault();
    acaoSelecionada = "download";
    popupConfirmacao("Realmente gostaria de executar o script para instalar os aplicativos?");
});

botaoAutomacao.addEventListener("click", (event) => {
    event.preventDefault();
    acaoSelecionada = "automacao";
    popupConfirmacao("Realmente gostaria de executar o script para fazer a automação?");
});

botaoBackup.addEventListener("click", (event) => {
    event.preventDefault();
    acaoSelecionada = "backup";
    popupConfirmacao("Realmente gostaria de executar o script para fazer um backup dos arquivos?");
});

botaoLimpar.addEventListener("click", (event) => {
    event.preventDefault();
    acaoSelecionada = "limpar";
    popupConfirmacao("Realmente gostaria de executar o script para fazer uma limpeza dos arquivos?");
});

botaoUsuarios.addEventListener("click", (event) => {
    event.preventDefault();
    acaoSelecionada = "usuarios";
    popupConfirmacao("Realmente gostaria de executar o script para cadastrar usuários em massa?");
});

fecharPopup.addEventListener("click", () => {
    popup.style.display = "none";
    main.style.display = "flex";
    footer.style.display = "block";

});

rodarScript.addEventListener("click", () => {
    fetch(`php/executeScript.php?script=${acaoSelecionada}`)
        .then(response => response.text())
        .then(data => {
            alert("Script funcionou: " + data);
            popup.style.display = "none";
        })
        .catch(error => {
            alert("Erro ao executar o script: " + error);
        });
    main.style.display = "flex";
    footer.style.display = "block";
});