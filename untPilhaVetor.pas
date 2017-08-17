unit untPilhaVetor;

interface

Const Max = 300;

type T_Item = record
       x, y : integer;
     end;

type T_PilhaLinear = record
    Base : integer;
    Topo : integer;
    QtdeAtual : integer;
    Dados : array[1..Max] of T_Item;
end;


procedure IniciarPilha(var Pilha : T_PilhaLinear);
function chkPilhaVazia(var Pilha : T_PilhaLinear) : boolean;
function Inserir(var Pilha : T_PilhaLinear; Item : T_Item) : boolean;
function Retirar(var Pilha : T_PilhaLinear) : boolean;
procedure Exibir(var Pilha: T_PilhaLinear);
function buscarItem(var Pilha:T_PilhaLinear; Item:T_Item):boolean;

Implementation

procedure IniciarPilha(var Pilha : T_PilhaLinear);
begin
  Pilha.Base := 1;
  Pilha.Topo := 0;
end;

function chkPilhaVazia(var Pilha : T_PilhaLinear) : boolean;
begin
  chkPilhaVazia := Pilha.Topo = 0;
end;

function Inserir(var Pilha : T_PilhaLinear; Item : T_Item) : boolean;
var flag : boolean;
begin
  if Pilha.QtdeAtual >= Max Then
    flag := false
  else
  begin
    Pilha.Topo := Pilha.Topo + 1;
    Pilha.Dados[Pilha.Topo] := Item;

    Pilha.QtdeAtual := Pilha.QtdeAtual + 1;
    flag := true;
  end;

  Inserir := flag;
end;

function Retirar(var Pilha : T_PilhaLinear) : boolean;
var flag : boolean;
begin
  if chkPilhaVazia(Pilha) Then
    flag := false
  else
  begin
    Pilha.Topo := Pilha.Topo - 1;

    Pilha.QtdeAtual := Pilha.QtdeAtual - 1;
    flag := true;
  end;

  Retirar := flag;
end;

procedure Exibir(var Pilha: T_PilhaLinear);
var i : integer;
begin
  for i := Pilha.Base to Pilha.Topo do
     writeln('[', Pilha.Dados[i].x,', ', Pilha.Dados[i].y, ']');
end;

function buscarItem(var Pilha:T_PilhaLinear; Item:T_Item):boolean;
var i:integer;
	flag:boolean;
begin
	flag:=false;
	for i:=Pilha.Base to Pilha.Topo do
	begin
		if((Pilha.Dados[i].x=Item.x) and (Pilha.Dados[i].y=Item.y)) then
		begin
			flag:=true;
			break;
		end;
	end;
	buscarItem:=flag;
end;

end.
