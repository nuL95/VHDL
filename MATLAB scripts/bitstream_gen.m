N = 1000;
x = randi([0 1],N,1);
x_string = string(x);
file = fopen("bitstream.txt",'w');
fprintf(file,"%s \n",x_string);