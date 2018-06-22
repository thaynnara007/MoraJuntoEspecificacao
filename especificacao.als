/*
			More Junto

	(x) Como usário, desejo me cadastrar no sistema
	(x) Como usuário cadastrado, desejo efetuar login no sistema
	(x) Como usuário cadastrado, após efeturar login, gostaria de visualizar meu perfil
	(x) Como usuário logado, gostaria de ver os anúncios
	(x) Como usuario logado, gostaria de criar meu proprio anuncio
	(x) Como usuario logado, gostaria de ver meus anuncio em uma aba separada

*/
module moreJunto
------------------------------------------------
-------------ASSINATURAS----------------
------------------------------------------------
abstract sig Usuario{}

sig UsuarioNaoCadastrado{

	cadastrar : one Cadastro
}

sig UsuarioCadastrado extends Usuario{

	logar : one Login
}

sig UsuarioLogado extends Usuario{
	
	perfil : one Perfil,
	abaAnuncio : one Anuncios,
	criarAnuncio : one CadastrarAnuncio,
	meusAnuncios : one MeusAnuncios
}

one sig Cadastro{}

one sig Login{}

sig Perfil{}

sig Anuncios{
	
	anuncio : set Anuncio
}

abstract sig Anuncio{}

sig AnuncioApartamento extends Anuncio{}

sig AnuncioRepublica extends Anuncio{}

sig AnuncioCriadoPeloUsuario extends Anuncio{}

sig AnuncioMoradoPeloUsuario extends Anuncio{}

sig CadastrarAnuncio{}

sig MeusAnuncios{

	anuncios : set AnuncioCriadoPeloUsuario
}

sig Localizacao{}

sig Preco{}

sig Favoritar{}

sig Avaliar{}

sig Consultar{}

sig Filtro{} 

sig NotificadoPorEmail{}

sig Deslogar{} 

----------------------------------------------
------------------FATOS-------------------
----------------------------------------------
fact mult{
	
	//Apenas usuarios nao cadastrados podem fazer cadastro
	all c : Cadastro | some c.~cadastrar

	//Apenas usuarios cadastrados podem efeturar login
	all l : Login | some l.~logar
	
	//Toda pagina de perfil esta ligada à um usuario
	all p : Perfil | one p.~perfil 

	//Cada usuario tem sua aba anuncios
	all a : Anuncios | one a.~abaAnuncio

	//Cada usuario tem sua aba de cadastrar anuncios
	all c_a : CadastrarAnuncio| one c_a.~criarAnuncio

	//Cada usuario tem acesso ao seus anuncios
	all m : MeusAnuncios | one m.~meusAnuncios

	//Cada anuncio criado por um usuario deve pertencer apenas a uma aba Meus Anuncios
	all a_c : AnuncioCriadoPeloUsuario | one a_c.~anuncios
}

fact anuncioCriadoEstaContidoEmTodosOsAnuncios{
	
	//Para todo anuncio criado pelo usuario existe uma aba anuncio onde esse anuncio esta contido
	some b : Anuncios | all a : AnuncioCriadoPeloUsuario | anunciosContemAnuncioCriado[a,b]
}

--------------------------------------------
------------PREDICADOS--------------
--------------------------------------------

pred anunciosContemAnuncioCriado[anuncio : AnuncioCriadoPeloUsuario, abaAnuncio : Anuncios]{

	 (anuncio in todosOsAnuncios[abaAnuncio])
} 

--------------------------------------------
----------------FUNCOES---------------
-------------------------------------------
fun anunciosDoUsuario[user : UsuarioLogado] : set AnuncioCriadoPeloUsuario{

	user.meusAnuncios.anuncios
}

fun todosOsAnuncios[abaAnuncio : Anuncios] : set Anuncio{

	abaAnuncio.anuncio
}

pred show[]{}
run show for 8

