function cifrar() {
  const textoEntrada = document.getElementById("textoEntrada").value;
  const desplazamiento = parseInt(document.getElementById("desplazamiento").value);
  const textoSalida = document.getElementById("textoSalida");
  const textoCifrado = cifrarTexto(textoEntrada, desplazamiento);
  textoSalida.value = textoCifrado;
}

function descifrar() {
  const textoCifrado = document.getElementById("textoEntrada").value;
  const desplazamiento = parseInt(document.getElementById("desplazamiento").value);
  const textoSalida = document.getElementById("textoSalida");
  const textoDescifrado = descifrarTexto(textoCifrado, desplazamiento);
  textoSalida.value = textoDescifrado;
}

function cifrarTexto(texto, desplazamiento) {
  return texto
    .split("")
    .map(caracter => {
      if (caracter.match(/[a-zA-Z]/)) {
        const codigo = caracter.charCodeAt(0);
        const esMayuscula = caracter === caracter.toUpperCase();
        const codigoDesplazado = ((codigo - (esMayuscula ? 65 : 97) + desplazamiento) % 26) + (esMayuscula ? 65 : 97);
        return String.fromCharCode(codigoDesplazado);
      } else {
        return caracter;
      }
    })
    .join("");
}

function descifrarTexto(texto, desplazamiento) {
  return cifrarTexto(texto, 26 - desplazamiento);
}
