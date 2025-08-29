// Exemplo de programa em MonoC com var

var x = 10;

var y = (x + 10) * 3;

while (x > 0) { // Loop
    y = (y + x) * 150;
    print(y);
    x = x - 1;
    if (not x) {
        break;
    }
}

var valor = read();
if (valor >= 0) { // Not negative
    print(valor * 2);
} else {
    print(0); 
}

