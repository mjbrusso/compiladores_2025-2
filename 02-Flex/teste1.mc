// Exemplo de programa em MonoC com var
var x = 10;
var y = 0;

while (x > 0) { // Loop
    y = (y + x) * 150;
    print(y);
    x = x - 1;
    if (x == 5) {
        break;
    }
}

var valor = read();
if (valor >= 0) { // Not negative
    print(valor * 2);
} else {
    print(0); 
}

