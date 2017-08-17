program labirinto;
uses crt, untPilhaVetor;

var cont, cont2, t, i, opPrinc:integer;
	parede:array[1..30, 1..23] of integer;
	pilha:T_PilhaLinear;
	pilhaDecisao:T_PilhaLinear;
	posicaoPassada:T_Item;
	flag:boolean;
	vet:array[1..4] of T_item;
	entra:boolean;
	
	
	

procedure carregaCenario();
var randX, randY:integer;
	
begin

	//Contrói contorno
	for cont:=1 to 30 do
	begin
		gotoxy(cont, 1);
		write(chr(178));
		parede[cont, 1]:=1;
	end;
	
	for cont:=2 to 23 do
	begin
		gotoxy(1, cont);
		writeln(chr(178));
		parede[1, cont]:=1;
	end;
	
	for cont:=2 to 30 do
	begin
		gotoxy(cont, 23);
		write(chr(178));
		parede[cont, 23]:=1;
	end;
	
	for cont:=2 to 22 do
	begin
		gotoxy(30, cont);
		writeln(chr(178));
		parede[30, cont]:=1;
	end;
	
	//Constrói parte interna
	randomize;
	for cont:=1 to 250 do
	begin
		randX:=random(29)+2;
		randY:=random(21)+2;
		
		gotoxy(randX,randY);
		write(chr(178));
		parede[randX, randY]:=1;
	end;
	
	
	//Define aberturas
	randomize;
	for cont:=1 to 2 do
	begin
		if (cont mod 2=0) then
		begin
			randX:=random(29)+2;
			gotoxy(randX, 1);
			write('  ');
			gotoxy(randX, 23);
			write('  ');
			parede[randX, 1]:=2;
			parede[randX+1, 1]:=2;
			parede[randX, 23]:=2;
			parede[randX+1, 23]:=2;
			
			gotoxy(randX, 2);
			write('  ');
			parede[randX, 2]:=0;
			parede[randX+1, 2]:=0;
			
			gotoxy(randX, 22);
			write('  ');
			parede[randX, 22]:=0;
			parede[randX+1, 22]:=0;
			
		end
		else
		begin
			randY:=random(21)+2;
			gotoxy(1, randY);
			write(' ');
			gotoxy(1, randY-1);
			write(' ');
			gotoxy(30, randY);
			write('  ');
			gotoxy(30, randY-1);
			write(' ');
			parede[1, randY]:=2;
			parede[1, randY-1]:=2;
			parede[30, randY]:=2;
			parede[30, randY-1]:=2;
			gotoxy(2, randY);
			write('  ');
			parede[2, randY]:=0;
			parede[3, randY]:=0;
			
			gotoxy(2, randY-1);
			write('  ');
			parede[2, randY-1]:=0;
			parede[3, randY-1]:=0;
			
			gotoxy(29, randY);
			write(' ');
			parede[29, randY]:=0;
			
			gotoxy(29, randY-1);
			write(' ');
			parede[29, randY-1]:=0;
			
			
		end;
	end;
	
	//Completa vetor 'parede' com 0
	for cont:=1 to 30 do
	begin
		for cont2:=1 to 23 do
		begin
			if((parede[cont, cont2]<2) and (parede[cont, cont2]<>1)) then
			begin
				parede[cont, cont2]:=0;
			end;
		end;
	end;
	
	
end;


procedure mostraParede();
begin
	for cont:=1 to 30 do
	begin
		for cont2:=1 to 23 do
		begin
			gotoxy(cont, cont2);
			write(parede[cont, cont2]);
		end;
	end;
end;



	
	
//Retorna a quantidade de espaços, dentre as opções de movimentação (cima, baixo, esquerda, direita), quantas o rato ja passou 
function checaPassadosAoRedor(coord:T_Item):integer;
var p:integer;
	aux:T_Item;
begin
	p:=0;
	aux.x:=coord.x+1;
	aux.y:=coord.y;
	if(buscarItem(pilha, aux)=true) then
		p:=p+1;
		
	aux.x:=coord.x-1;
	aux.y:=coord.y;
	if(buscarItem(pilha, aux)=true) then
		p:=p+1;
		
	aux.x:=coord.x;
	aux.y:=coord.y+1;
	if(buscarItem(pilha, aux)=true) then
		p:=p+1;
		
	aux.x:=coord.x;
	aux.y:=coord.y-1;
	if(buscarItem(pilha, aux)=true) then
		p:=p+1;
	
	checaPassadosAoRedor:=p;
	
end;
	
//Retorna a quantidade de parede que estão ao redor do rato, considerando as opções de movimentação(cima, baixo, esquerda, direita)
function checaParedesAoRedor(coord:T_Item):integer;
var p:integer;
begin
	p:=0;
	if(parede[coord.x+1, coord.y]=1) then
		p:=p+1;
		
	if(parede[coord.x-1, coord.y]=1) then
		p:=p+1;

	if(parede[coord.x, coord.y+1]=1) then
		p:=p+1;
			
	if(parede[coord.x, coord.y-1]=1) then
		p:=p+1;
					
	checaParedesAoRedor:=p;
end;
	
//Inserir o rato dentro do labirinto
procedure carregaRato();
var randX, randY:integer;
	isAlive:boolean;
begin
	isAlive:=false;
	
	while(isAlive=false) do
	begin
		randomize;
		randX:=random(29)+2;
		randY:=random(22)+2;
		
		posicaoPassada.x:=randX;
		posicaoPassada.y:=randY;
		
		if((parede[randX, randY]=0) and (checaParedesAoRedor(posicaoPassada) < 3)) then
		begin
			gotoxy(randX, randY);
			write(chr(2));
			posicaoPassada.x:=randX;
			posicaoPassada.y:=randY;
			if(checaParedesAoRedor(posicaoPassada)<4) then
			begin
				Inserir(pilha, posicaoPassada);
				isAlive:=true;
			end;
		end;
	end;
end;
	
function condicaoDesempilhaParada(coord:T_Item):boolean;
var flag:boolean;
begin
	flag:=false;
	if((coord.x+1=pilhaDecisao.Dados[pilhaDecisao.topo].x) and (coord.y=pilhaDecisao.Dados[pilhaDecisao.topo].y)) then
		flag:=true;
	if((coord.x-1=pilhaDecisao.Dados[pilhaDecisao.topo].x) and (coord.y=pilhaDecisao.Dados[pilhaDecisao.topo].y)) then
		flag:=true;
	if((coord.x=pilhaDecisao.Dados[pilhaDecisao.topo].x) and (coord.y+1=pilhaDecisao.Dados[pilhaDecisao.topo].y)) then
		flag:=true;
	if((coord.x=pilhaDecisao.Dados[pilhaDecisao.topo].x) and (coord.y-1=pilhaDecisao.Dados[pilhaDecisao.topo].y)) then
		flag:=true;
	
	condicaoDesempilhaParada:=flag;
end;
	
//Procedimento resposável por fazer o rato retornar a alguma determinada posição que ele já tenha passado
procedure desempilha();
var topo, p:integer;
	
begin
	topo:=pilha.topo;
	while(topo>=pilha.base) do
	begin
		gotoxy(posicaoPassada.x, posicaoPassada.y);
		write(' ');
		gotoxy(posicaoPassada.x, posicaoPassada.y);
		posicaoPassada.x:=pilha.Dados[topo-1].x;
		posicaoPassada.y:=pilha.Dados[topo-1].y;
		gotoxy(posicaoPassada.x, posicaoPassada.y);
		write(chr(2));
		gotoxy(posicaoPassada.x, posicaoPassada.y);
		
		
		if(condicaoDesempilhaParada(posicaoPassada)=true) then
		begin
			posicaoPassada.x:=pilhaDecisao.Dados[pilhaDecisao.topo].x;
			posicaoPassada.y:=pilhaDecisao.Dados[pilhaDecisao.topo].y;
			Retirar(pilhaDecisao);
			
			//parede[pilha.Dados[topo].x, pilha.Dados[topo].y]:=1;
			Retirar(pilha);
			entra:=false;
			break;
		end;
		
		Retirar(pilha);
		
		if(pilha.base=pilha.topo) then
		begin
			
			break;
		end;
			
			
		
		
		gotoxy(40, 10);
		write('(', pilha.Dados[pilha.topo].x,', ', pilha.Dados[pilha.topo].y,')');	
		
		delay(1);
		topo:=topo-1;
	end;
end;
		
	
procedure verificaPosicoesPossiveis(coord:T_Item);
var i:integer;
	aux:T_Item;
begin
	i:=1;
	
	aux.x:=coord.x+1;
	aux.y:=coord.y;
	if(((parede[aux.x, aux.y]=0) or (parede[aux.x, aux.y]=2)) and (buscarItem(pilha, aux)=false)) then
	begin
		vet[i].x:=aux.x;
		vet[i].y:=aux.y;
		i:=i+1;
	end;
		
	aux.x:=coord.x-1;
	aux.y:=coord.y;
	if(((parede[aux.x, aux.y]=0) or (parede[aux.x, aux.y]=2)) and (buscarItem(pilha, aux)=false)) then
	begin
		vet[i].x:=aux.x;
		vet[i].y:=aux.y;
		i:=i+1;
	end;
		
	aux.x:=coord.x;
	aux.y:=coord.y+1;
	if(((parede[aux.x, aux.y]=0) or (parede[aux.x, aux.y]=2)) and (buscarItem(pilha, aux)=false)) then
	begin
		vet[i].x:=aux.x;
		vet[i].y:=aux.y;
		i:=i+1;
	end;
		
	aux.x:=coord.x;
	aux.y:=coord.y-1;
	if(((parede[aux.x, aux.y]=0) or (parede[aux.x, aux.y]=2)) and (buscarItem(pilha, aux)=false)) then
	begin
		vet[i].x:=aux.x;
		vet[i].y:=aux.y;
		i:=i+1;
	end;
end;
	
procedure movimentaRato();
var velocidade, dir:integer;
	
begin
	velocidade:=1;
	entra:=true;
	while(parede[posicaoPassada.x, posicaoPassada.y]<>2) do
	begin
		
		while((pilha.Dados[pilha.topo].x=posicaoPassada.x) and (pilha.Dados[pilha.topo].y=posicaoPassada.y) and (entra=true)) do
		begin
			randomize;
			dir:=random(4)+1;
			case dir of
				1:posicaoPassada.x:=posicaoPassada.x+velocidade;
				2:posicaoPassada.x:=posicaoPassada.x-velocidade;
				3:posicaoPassada.y:=posicaoPassada.y+velocidade;
				4:posicaoPassada.y:=posicaoPassada.y-velocidade;
			end;
			
			
			if((parede[posicaoPassada.x, posicaoPassada.y]=1) or (buscarItem(pilha, posicaoPassada)=true)) then
			begin
				posicaoPassada.x:=pilha.Dados[pilha.topo].x;
				posicaoPassada.y:=pilha.Dados[pilha.topo].y;
			end;
				
		end;
			
		if(parede[posicaoPassada.x, posicaoPassada.y]=0) then
		begin
			Inserir(pilha, posicaoPassada);
			gotoxy(posicaoPassada.x, posicaoPassada.y);
			write(chr(2));
			gotoxy(pilha.Dados[pilha.topo-1].x, pilha.Dados[pilha.topo-1].y);
			write(chr(9));
			gotoxy(posicaoPassada.x, posicaoPassada.y);
			gotoxy(40, 10);
			write('(', pilha.Dados[pilha.topo].x,', ', pilha.Dados[pilha.topo].y,')');
		end;
		
		delay(1);
		
		if(parede[posicaoPassada.x, posicaoPassada.y]=2) then
		begin
			Inserir(pilha, posicaoPassada);
			gotoxy(posicaoPassada.x, posicaoPassada.y);
			write(chr(2));
			gotoxy(pilha.Dados[pilha.topo-1].x, pilha.Dados[pilha.topo-1].y);
			write(chr(9));
			gotoxy(posicaoPassada.x, posicaoPassada.y);
			break;
		end;
		
		if(checaParedesAoRedor(posicaoPassada)+checaPassadosAoRedor(posicaoPassada)=4) then
		begin
			desempilha();
		end
		else
		begin
			entra:=true;
			if(checaParedesAoRedor(posicaoPassada)+checaPassadosAoRedor(posicaoPassada)=2) then
			begin
				verificaPosicoesPossiveis(posicaoPassada);
				posicaoPassada.x:=vet[1].x;
				posicaoPassada.y:=vet[1].y;
				Inserir(pilhaDecisao, vet[2]);
				
				//Mostra posicao topo da pilha de decisao
				//gotoxy(40, 8);
				//write('(', pilhaDecisao.Dados[pilhaDecisao.topo].x,', ', pilhaDecisao.Dados[pilhaDecisao.topo].y,')');
			
				entra:=false;
			end;
		end;
	end;
end;

procedure apresentacao();
begin
	
	for cont:=25 to 55 do
	begin
		gotoxy(cont, 5);
		write(chr(176));
	end;
	for cont:=5 to 15 do
	begin
		gotoxy(25, cont);
		write(chr(176));
	end;
	for cont:=26 to 55 do
	begin
		gotoxy(cont, 15);
		write(chr(176));
	end;
	for cont:=5 to 14 do
	begin
		gotoxy(55, cont);
		write(chr(176));
	end;
	
	gotoxy(36, 10);
	write('LABIRINTO');
	
	gotoxy(26, 17);
	write('GRUPO:');
	gotoxy(26, 18);
	write('Anderson Sampaio');
	gotoxy(26, 19);
	write('Gabriel Barros');
	gotoxy(26, 20);
	write('Gabriel Santana');
	gotoxy(26, 21);
	write('Pedro Arruda');
	gotoxy(26, 22);
	write('Vitor Rabelo');
		
end;


begin
	i:=1;
	opPrinc:=0;
	apresentacao();
	readkey;
	
	clrscr;
	
	iniciarPilha(pilhaDecisao);
	iniciarPilha(pilha);
	carregaCenario();

	carregaRato();	

	gotoxy(34, 12);
	write('Pressione uma tecla para iniciar');
	readkey;
	gotoxy(32,12);
	write('                                  ');

	movimentaRato();

	mostraParede();
	gotoxy(34, 12);
	write('Ratinho encontrou uma saida!');
	readkey;
		
	clrscr;
	
end.