let acaoSelecionada = ""; // guardará a ação atual

const botaoAtualizar = document.getElementById("atualizar");
const botaoInstalar = document.getElementById("download");
const botaoLimpar = document.getElementById("limpar");
const botaoUsuarios = document.getElementById("usuario");
const botaoBackup = document.getElementById("backup");
const botaoAutomacao = document.getElementById("automacao");

const fecharPopup = document.getElementById("cancelar");
const rodarScript = document.getElementById("confirmar");

const popup = document.querySelector(".pop-up");

const paragrafo = document.getElementById("mensaagem");


function alternarPopup(){
    popup.classList.toggle("aberto");
}


botaoAtualizar.addEventListener("click", (event) =>{
    event.preventDefault();
    acaoSelecionada = "atualizar";
    paragrafo.textContent += "atualizar os aplicativos?";
    alternarPopup();
});

botaoInstalar.addEventListener("click", (event) =>{
    event.preventDefault();
    acaoSelecionada = "instalar";
    paragrafo.textContent += "instalar os aplicativos?";
    alternarPopup();
});

botaoAutomacao.addEventListener("click", (event) =>{
    event.preventDefault();
    acaoSelecionada = "automacao";
    paragrafo.textContent += "fazer a automação?";
    alternarPopup();
});

botaoBackup.addEventListener("click", (event) =>{
    event.preventDefault();
    acaoSelecionada = "backup";
    paragrafo.textContent += "fazer um backup dos arquivos?";
    alternarPopup();
});

botaoLimpar.addEventListener("click", (event) =>{
    event.preventDefault();
    acaoSelecionada = "limpar";
    paragrafo.textContent += "fazer uma limpeza dos arquivos?";
    alternarPopup();
});

botaoUsuarios.addEventListener("click", (event) =>{
    event.preventDefault();
    acaoSelecionada = "usuarios";
    paragrafo.textContent = "fazer um cadastro de usuários em massa?";
    alternarPopup();
});

fecharPopup.addEventListener("click", () => {
    popup.classList.remove("aberto");
});


rodarScript.addEventListener("click", () => {
  
});
