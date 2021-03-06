/*
			More Junto

	(x) Como usário, desejo me cadastrar no sistema.
	(x) Como usuário cadastrado, desejo efetuar login no sistema.
	(x) Como usuário cadastrado, após efeturar login, gostaria de visualizar meu perfil.
	(x) Como usuário logado, gostaria de ver os anúncios.
	(x) Como usuario logado, gostaria de criar meu proprio anuncio.
	(x) Como usuario logado, gostaria de ver meus anuncio em uma aba separada.
	(x) Como usuario logado, gostaria de poder apagar meu perfil.
	(x) Como usuario logado, gostaria de poder mudar minha senha.
	(x) Como usuario logado, gostaria de deslogar do sistemas.
	(x) Como usuario logado, gostaria de poder filtrar anuncios na pagina de anuncios.
	(x) Como usuario cadastrado, gostaria que ao cadastrar um novo anuncio, eu fosse notificado por email.
	(x) Como usuario, gostaria que os anuncios tivessem a localizacao do imóvel.
	(x) Como usuario logado, gostaria de poder favoritar anuncios.
	(x) Como usuario logado, gostaria de poder avaliar anuncios cujo o imóvel eu ja fui morador.
	(x) Como usuario, gostaria que cada anuncio tivesse um preco.
	(x) Como usuario logado, gostaria de poder consultar informações dos anuncios

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

	logar : lone Login
}

sig UsuarioLogado in UsuarioCadastrado{
	
	perfil : one Perfil,
	abaAnuncio : one Anuncios,
	cadastrarAnuncio : one CadastrarAnuncio,
	meusAnuncios : one MeusAnuncios,
	configuracao : one Configuracoes
}

sig Configuracoes{
	
	excluirPerfil : one ApagarPerfil,
	trocarSenha : one MudarSenha,
	deslogar : one Deslogar
}

sig ApagarPerfil{}

sig MudarSenha{}

sig Deslogar{}

one sig Cadastro{}

one sig Login{}

sig Perfil{}

sig Anuncios{
	
	anuncio : set Anuncio,
	filtro : one Filtro
}

abstract sig Anuncio{

	consulta : one ConsultarInformacoes
}

sig AnuncioCriadoPeloUsuario extends Anuncio{

	notificaPorEmail : one NotificadoPorEmail	
}

sig AnuncioApartamento extends Anuncio{}

sig AnuncioRepublica extends Anuncio{}

sig AnuncioMoradoPeloUsuario extends Anuncio{}

sig CadastrarAnuncio{}

sig MeusAnuncios{

	anuncios : set AnuncioCriadoPeloUsuario
}

sig Localizacao{}

sig Preco{}

sig Favoritar{}

sig Avaliar{}

sig ConsultarInformacoes{

	preco : one Preco,
	favorito : one Favoritar,
	avaliar : lone Avaliar,
	localizacao : one Localizacao 
}

sig Filtro{
	
	anunciosFiltrados : set Anuncio
} 

sig NotificadoPorEmail{}

----------------------------------------------
------------------FATOS-------------------
----------------------------------------------

fact mult{
	
	--Apenas usuarios nao cadastrados podem efetuar cadastro
	all c : Cadastro | some c.~cadastrar

	--Apenas usuarios cadastrados podem efeturar login
	all l : Login | some l.~logar
	
	--Toda pagina perfil pertence a um usuario
	all p : Perfil | one  p.~perfil

	--Toda aba anuncios pertence a um usuario
	all a : Anuncios | one a.~abaAnuncio
	
	--Toda  aba de cadastrar anuncios pertence a um usuario cadastrado
	all c_a : CadastrarAnuncio| one c_a.~cadastrarAnuncio

	--Todo usuario tem acesso ao seus anuncios
	all m : MeusAnuncios | one m.~meusAnuncios

	--Cada anuncio criado por um usuario deve pertencer apenas a uma aba Meus Anuncios
	all a_c : AnuncioCriadoPeloUsuario | one a_c.~anuncios

	--Todo anuncio deve estar ligado a uma aba anuncios
	all a : Anuncio | some a.~anuncio

	--Toda pagina de configuracao de conta epode ser acessado por apenas um usuario logado dono da conta
	all c : Configuracoes | one c.~configuracao
	
	--Toda opcao de apagar perfil esta ligada a uma aba configuracoes respectivo a seu usuario
	all a : ApagarPerfil | one a.~excluirPerfil

	--Toda opcao de mudar senha esta ligada a uma aba configuracao respectivo a seu usuario
	all m : MudarSenha | one m.~trocarSenha

	--Toda opcao de deslogar esta ligada a uma aba configuracao respectivo a seu usuario
	all d : Deslogar | one d.~deslogar

	--cada filtro pertence a uma aba anuncios 
	all f : Filtro | one f.~filtro
	
	--Todo anuncio cadastrado notifica por email o usuario 
	all n : NotificadoPorEmail | one n.~notificaPorEmail

	--Toda localizacao esta associada a um anuncio
	all l : Localizacao | one l.~localizacao

	--Cada opcao de favoritar esta associdado a um anuncio
	all f : Favoritar | one f.~favorito

	--Cada opcao de avaliar anuncio esta associada a um anuncio que ja foi morado pelo usuario 
	all a : Avaliar | one a.~avaliar

	--Cada preco esta associada a um anuncio 
	all p : Preco | one p.~preco

	--Cada botao de consultar informacoes esta associado a um anuncio
	all c : ConsultarInformacoes | one c.~consulta
}

fact {

	--Nao existe nenhum usuario com o mesmo perfil
	all u1, u2 : UsuarioCadastrado | u1 != u2 implies u1.perfil != u2.perfil

	--Nao existe nenhum usuario com a mesma aba anuncio
	all u1, u2 : UsuarioCadastrado | u1 != u2 implies u1.abaAnuncio != u2.abaAnuncio

	--Nao existe nenhum usuario com a mesma aba cadastrar anuncio
	all u1,u2 : UsuarioCadastrado | u1 != u2 implies u1.cadastrarAnuncio != u2.cadastrarAnuncio
	
	--Nao existe nenhum anuncio com a mesma aba meus anuncios
	all u1,u2 : UsuarioCadastrado | u1 != u2 implies u1.meusAnuncios != u2.meusAnuncios

	--Nao existe nenhum anuncio com a mesma localizacao 
	all a1, a2 : Anuncio | a1 != a2 implies localizacaoDoAnuncio[a1] != localizacaoDoAnuncio[a2]
}

fact{
	
	--Todo anuncio criado por um usuario pertence a alguma aba anuncios que não seja a do proprio usuario
	all u : UsuarioLogado , m : MeusAnuncios, aba: Anuncios | abaAnunciosEmeusAnunciosSaoConjuntosDiferentes[aba,m,u]
}

fact usuarioLogadoNaoPodeLogarDeNovo{
	
	all u : UsuarioLogado | #u.logar = 0 
}

fact {
	
	--Um usuario nao pode avaliar um anuncio o qual ele nao tenha morado
	all a : AnuncioCriadoPeloUsuario | #avaliarDoAnuncio[a] = 0
	
	all a1 : AnuncioRepublica | #avaliarDoAnuncio[a1] = 0

	all a2 : AnuncioApartamento | #avaliarDoAnuncio[a2] = 0
	
	--Um usuario pode avaliar um anuncio que ele tenha morado
	all a3 : AnuncioMoradoPeloUsuario | #avaliarDoAnuncio[a3] = 1
}

--------------------------------------------
------------PREDICADOS--------------
--------------------------------------------

pred abaMeusAnunciosAbaAnuncioDoMesmoUsario[abaAnuncio: Anuncios, meusAnuncios : MeusAnuncios, usuario: UsuarioLogado] {

	 (abaMeusAnuncios[usuario] = meusAnuncios) and (abaAnuncioDoUsuario[usuario] = abaAnuncio)
}

pred anunciosDaAbaAnuncio[abaAnuncio : Anuncios, meusAnuncios : MeusAnuncios]{

	todosOsAnuncios[abaAnuncio] = todosOsAnuncios[abaAnuncio] - anunciosDoUsuario[meusAnuncios]
}

pred  abaAnunciosEmeusAnunciosSaoConjuntosDiferentes[abaAnuncio : Anuncios, meusAnuncios : MeusAnuncios, usuario : UsuarioLogado]{

	 abaMeusAnunciosAbaAnuncioDoMesmoUsario[abaAnuncio,meusAnuncios,usuario] implies anunciosDaAbaAnuncio[abaAnuncio,meusAnuncios]

}

--------------------------------------------
----------------FUNCOES---------------
-------------------------------------------

fun todosOsAnuncios[abaAnuncio : Anuncios] : set Anuncio{

	abaAnuncio.anuncio
}

fun abaMeusAnuncios[usuario : UsuarioLogado] : one MeusAnuncios{

	usuario.meusAnuncios 
}

fun abaAnuncioDoUsuario[usuario: UsuarioLogado] : one Anuncios{

	usuario.abaAnuncio
}

fun anunciosDoUsuario[meusAnuncios : MeusAnuncios] : set Anuncio{

	meusAnuncios.anuncios
}

fun localizacaoDoAnuncio[anuncio : Anuncio] : one Localizacao{

	anuncio.consulta.localizacao
}

fun avaliarDoAnuncio[anuncio : Anuncio] : one Avaliar{
	
	anuncio.consulta.avaliar
}

pred show[]{}
run show for 5

