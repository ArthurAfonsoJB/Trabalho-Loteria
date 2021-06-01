programa
{
	inclua biblioteca Util --> u
	inclua biblioteca Texto --> t
	inclua biblioteca Tipos --> tp

	inteiro sorteado[50]
	cadeia user[1000][100]
	
	funcao inicio()
	{
		/*
		 *  0 - Loteria
		 *  1 - Número de dezenas que ele vai apostar
		 *  2 - cartela 1
		 *  3 - cartela 2
		 *  ...
		 */

		cadeia tiposLoterias[4] = {"MegaSena", "LotoFacil", "LotoMania", "Quina"}
		inteiro jogo, nmrCartelaUser, vezesMacro = 0, tipoPadrao, dezenas = 0
		
		inteiro MegaSena[4] =  {6, 15, 6, 60}	//4-6
		inteiro LotoFacil[4] = {15, 20, 15, 25}	//15-11
		inteiro LotoMania[4] = {50, 50, 20, 100}//20-15 ou senhuma
		inteiro Quina[4] =     {5, 15, 5, 80}	//5-2

		escreva("	  PROGRAMA\n\npadrão[1]	não padrão[2]\n\n")
		leia(tipoPadrao)
		limpa()

		escreva("Qual jogo você quer apostar?\n\n")
		para(inteiro i=0; i < u.numero_elementos(tiposLoterias); i++){
			escreva(tiposLoterias[i], "[", i, "]	")
			se(i == 1){
				escreva("\n")
			}senao se(i == 3){
				escreva("\n\n")
			}
		}
		leia(jogo)

		user[0][0] = tiposLoterias[jogo]

		limpa()

		escreva("Quantas cartelas você ira preencher?\n\n")
		leia(nmrCartelaUser)
		
		limpa() 

		
		se(tipoPadrao == 2){
			escolha (jogo){
				caso 0:
					funcoes(MegaSena, nmrCartelaUser, vezesMacro, verdadeiro)
				pare
	
				caso 1:
					funcoes(LotoFacil, nmrCartelaUser, vezesMacro, verdadeiro)
				pare
	
				caso 2:
					funcoes(LotoMania, nmrCartelaUser, vezesMacro, verdadeiro)
				pare
				
				caso 3:
					funcoes(Quina, nmrCartelaUser, vezesMacro, verdadeiro)
				pare
				
			}
		}senao se(tipoPadrao == 1){
			escolha (jogo){
				caso 0:
					funcoes(MegaSena, nmrCartelaUser, vezesMacro, falso)
				pare
	
				caso 1:
					funcoes(LotoFacil, nmrCartelaUser, vezesMacro, falso)
				pare
	
				caso 2:
					funcoes(LotoMania, nmrCartelaUser, vezesMacro, falso)
				pare
				
				caso 3:
					funcoes(Quina, nmrCartelaUser, vezesMacro, falso)
				pare
				
			}
		}
	}

	funcao validarDezenas(inteiro jogo[],  inteiro nmrCartelaUser, logico validar){

		//Da p modularizar
		inteiro userInt = 0
		cadeia naoTrocarVazio[50]
		
		para(inteiro i = 0; i < nmrCartelaUser; i++){
			se(nmrCartelaUser == 1){
				escreva("Quantas dezenas você deseja apostar?\n\n")
				leia(user[1][i])

				userInt = tp.cadeia_para_inteiro(user[1][i], 10)
				
				se(userInt < jogo[0] ou userInt > jogo[1]){
					limpa()
					escreva("ERRO!! A ", user[0][0], " só aceita de ", jogo[0], " a ", jogo[1], " números apostados por cartela\n\n")
					i--
				}senao{
					limpa()
				}
				
			}senao se(nmrCartelaUser != 1){
				escreva("Quantas dezenas deseja apostar na sua ", i+1, "º cartela?\n\n")
				leia(user[1][i])

				userInt = tp.cadeia_para_inteiro(user[1][i], 10)
				
				se(userInt < jogo[0] ou userInt > jogo[1]){
					limpa()
					escreva("ERRO!! A ", user[0][0], " só aceita de ", jogo[0], " a ", jogo[1], " números apostados por cartela\n\n")
					i--
				}senao{
					limpa()
				}
				
			}
		}

		organizarLinha(nmrCartelaUser, -1)

		limpa()
		escreva("Organizando as suas cartelas em ordem crescente...")
		u.aguarde(1500)
		limpa()

		se(nao validar){
			para(inteiro i=0; i < nmrCartelaUser; i++){
				surpresinha(jogo, tp.cadeia_para_inteiro(user[1][i], 10), (i+1), naoTrocarVazio)
				organizarLinha(tp.cadeia_para_inteiro(user[1][i], 10), i)
			}
		}
	}

	funcao receberApostas(inteiro &nmrCartelaUser, inteiro jogo[]){

		inteiro novoNmr, userReserva[51], repetir, reAleatoriar, vezes = 0, erro = 0
		inteiro userInt, respostaMudar, respostaMudarTrocar
		cadeia resposta, respostaReAleatoriar = "", naoTrocar[51]
		
		para(inteiro i=0; i < nmrCartelaUser; i++){

			//2 pq é apartir da 2 linha q as cartelas são colocadas
			para(inteiro k=0; k < nmrCartelaUser + 2; k++){	
				se(user[k][0] == ""){
					i = k - 2
					k = nmrCartelaUser + 2
					vezes++
				}
			}
			se(vezes == 0){
				pare
			}
			vezes = 0

			para(inteiro c=0; c < nmrCartelaUser; c++){
				se(i > 0){
					se(user[c + 2][0] != ""){
						escreva(c + 1, "º cartela: ")
						mostrar(c)
						escreva("\n\n")
					}
				}
			}

			userInt = tp.cadeia_para_inteiro(user[1][i], 10)

			vezes = 0
			
			para(inteiro b=0; b < userInt; b++){
				erro = 0
				escreva("Qual o seu ", b+1, "º número da ", i+1, "º cartela?\nsortear os ", userInt - b, " números restantes[s]\n\n")
				leia(user[i+2][b])

				se(user[i+2][b] == "s"){
						user[i+2][b] = ""
						naoTrocar[b] = ""
						surpresinha(jogo, (userInt - b), (i+1), naoTrocar)
						b = userInt
						vezes++
				}senao se(tp.cadeia_para_inteiro(user[i+2][b], 10) > jogo[3] ou tp.cadeia_para_inteiro(user[i+2][b], 10) < 1){
					limpa()
					escreva("Digite um número válido!! A ", user[0][0], " só aceita números de 1 a ", jogo[3], "\n\n")
					user[i+2][b] = ""
					b--
					erro++
				}senao{
					para(inteiro k=0; k < b; k++){
						se(user[i+2][k] == user[i+2][b]){
							limpa()
							escreva("Digite um número válido!! Você já escolheu esse número!!\n\n")
							user[i+2][b] = ""
							b--
							erro++
						}senao{
							erro = 0
						}
					}
				}

				
				se(erro == 0){
					naoTrocar[b] = user[i+2][b]
	
					limpa()

					se(user[i+2][tp.cadeia_para_inteiro(user[1][i], 10) - 1] != ""){
						faca{
							para(inteiro k=0; k < userInt; k++){
								se(naoTrocar[k] != ""){
									user[i+2][k] = naoTrocar[k]
								}senao{
									k = 51
								}
							}
							organizarLinha(userInt, i)
							
							limpa()
		
							mostrar(i)
							
							se(vezes != 0){
								escreva("\n\nDeseja sortear novamente?\nsim[s]	não[n]\n\n")
								leia(respostaReAleatoriar)
				
								se(respostaReAleatoriar == "s"){
									para(inteiro k=0; k < userInt; k++){
										user[i+2][k] = ""
									}
									surpresinha(jogo, userInt, (i+1), naoTrocar)
								}
							}senao{
								respostaReAleatoriar = "n"
							}
						}enquanto(respostaReAleatoriar != "n")
	
						limpa()
	
						faca{
							mostrar(i)	
							escreva("\n\nDeseja mudar algum número dessa sua ", i+1, "º cartela? \nsim[s]	não[n]\n\n")
							leia(resposta)
							limpa()
							
							vezes = 1
							se(resposta == "s"){
								faca{
									vezes = 0	
									mostrar(i)
									escreva("\n\nQual número você deseja mudar?\n\n")
									leia(respostaMudar)

									para(inteiro c=0; c < userInt; c++){
										se(user[i+2][c] == tp.inteiro_para_cadeia(respostaMudar, 10)){
											vezes++
										}senao se(vezes > 1){
											escreva("ERRO!! Este número não está sendo apostado\n\n")
										}
									}

									se(vezes == 1){
										vezes = 0
										escreva("\nQual o novo número que você quer?\n\n")
										leia(respostaMudarTrocar)
		
										para(inteiro k=1; k < userInt; k++){
											se(user[i+2][k] == tp.inteiro_para_cadeia(respostaMudarTrocar, 10)){
												limpa()
												escreva("ERRO!! Este número já está sendo apostado\n\n")
												vezes++
											}senao se(respostaMudarTrocar > jogo[3] ou respostaMudarTrocar < 1){
												limpa()
												escreva("ERRO!! Este número é maior ou menor que o permitido ( 1 - ", jogo[3], " )\n\n")
												vezes++
											}
										}
	
										se(vezes == 0){
											para(inteiro g=0; g < userInt; g++){
												se(respostaMudar == tp.cadeia_para_inteiro(user[i+2][g], 10)){
													user[i+2][g] = tp.inteiro_para_cadeia(respostaMudarTrocar, 10)
					
													organizarLinha(userInt, i)
													limpa()
													g = userInt
												}
											}
										}
									}		
								}enquanto(vezes != 0)
							}senao se(resposta == "n"){
								resposta = "n"
							}
						}enquanto(resposta != "n")
	
						limpa()
	
						mostrar(i)

						vezes = 0
	
						se(nmrCartelaUser > i+1){
							escreva("\n\nDeseja realizar uma teimozinha com esse seu jogo?\nsim[s]	não[n]\n\n")
							leia(resposta)
			
							se(resposta == "s"){
								escreva("\n\nPara mais quantas cartelas você deseja fazer esse mesmo jogo?\n\n")
								leia(repetir)
		
								limpa()
								
								teimosinha((i+1), nmrCartelaUser, repetir, jogo, 0)
								
							}senao se(resposta == "n"){
								limpa()
							}
						}
					}
				}	
			}
		}
	}
	//***********************************************************************************

	funcao sortear(inteiro tipoLoteria[], inteiro nmrCartelaUser){

		limpa()

		preco(nmrCartelaUser)
		
		escreva("\n\nOs números sorteados foram: ")

		para(inteiro i=0; i < tipoLoteria[2]; i++){
			sorteado[i] = u.sorteia(1, tipoLoteria[3])

			para(inteiro j=0; j < i; j++){
				se(sorteado[i] == sorteado[j]){
					i--
				}senao{
				}
			}
		}
		
		organizar(sorteado)

		para(inteiro i=0; i < u.numero_elementos(sorteado); i++){
			se(sorteado[i] != 0){
				escreva(sorteado[i], "	")
			}senao{
				i = 51
			}
		}

		escreva("\n\nE as suas cartelas foram:")
		para(inteiro i=0; i < nmrCartelaUser; i++){
			escreva("\n", i+1, "º cartela: ")
			para(inteiro j=0; j < tp.cadeia_para_inteiro(user[1][i], 10); j++){
				escreva(user[i+2][j], "	")
			}
		}escreva("\n\n")
	}

	//***********************************************************************************

	funcao organizar(inteiro &serOrganizado[]){
		inteiro reserva
		
		para(inteiro i=0; i < u.numero_elementos(serOrganizado); i++){
			se(serOrganizado[i] != 0){
				para(inteiro b=0; b < i; b++){
					se(serOrganizado[i] < serOrganizado[b]){
						reserva = serOrganizado[i]
						serOrganizado[i] = serOrganizado[b]
						serOrganizado[b] = reserva

						i = 0
					}

				}
			}senao{
				pare
			}
		}
	}

	funcao inteiro comparar(inteiro nmrCartelaUser, inteiro &vezesMacro, inteiro tipoLoteria[]){

		inteiro vezes = 0
		
		para(inteiro i=0; i < nmrCartelaUser ; i++){
			para(inteiro b=0; b < tp.cadeia_para_inteiro(user[1][i], 10); b++){
				para(inteiro j=0; j < u.numero_elementos(sorteado); j++){
					se(sorteado[j] != 0){
						se(tp.cadeia_para_inteiro(user[i+2][b], 10) == sorteado[j]){
							vezes++
						}
					}senao{
						j = u.numero_elementos(sorteado) - 1
					}
				}
			}

			se(vezes == tipoLoteria[0]){
				vezesMacro++
			}

			vezes = 0
		}

		retorne vezesMacro
	}

	funcao surpresinha(inteiro tipoLoteria[], inteiro vezes, inteiro nmrCartelaUser, cadeia naoTrocar[]){
		cadeia sorteado1
		inteiro i = nmrCartelaUser, sorteadoInt, contador = 0
		
		para(inteiro p=0; p < vezes; p++){
			contador = 0
			sorteadoInt = u.sorteia(1, tipoLoteria[3])
			sorteado1 = tp.inteiro_para_cadeia(sorteadoInt, 10)

			para(inteiro w=0; w < tp.cadeia_para_inteiro(user[1][i - 1], 10); w++){
				se(sorteado1 == user[i+1][w] ou (naoTrocar[w] != "" e naoTrocar[w] == sorteado1)){
					p--
					w = tp.cadeia_para_inteiro(user[1][i - 1], 10)
				}senao{
					contador++
				}
			}

			se(contador == tp.cadeia_para_inteiro(user[1][i - 1], 10)){
				para(inteiro v=0; v < tp.cadeia_para_inteiro(user[1][i - 1], 10); v++){
					se(user[i+1][v] == ""){
						user[i+1][v] = sorteado1
						v = tp.cadeia_para_inteiro(user[1][i - 1], 10)
					}
				}
			}
			
		}	
	}

	funcao teimosinha(inteiro nmrCartelaUser, inteiro nmrCartelasTotais, inteiro repetir, inteiro jogo[], inteiro erro){
		inteiro auxilio, auxilioAuxiliar, vezesContador = 0, vezes[50]
		cadeia resposta

		se(erro != 0){
			mostrar(nmrCartelaUser)
			escreva("\n\nPara mais quantas cartelas você deseja fazer esse mesmo jogo?\n\n")
			leia(repetir)
		}
		
		se(repetir > (nmrCartelasTotais-nmrCartelaUser)){
			limpa()
			escreva("Erro!! Você só tem mais ", nmrCartelasTotais-nmrCartelaUser, " cartelas para preencher. \n\n")
			erro++
			teimosinha(nmrCartelaUser, nmrCartelasTotais, repetir, jogo, erro)
		}senao se(repetir < 0){
			limpa()
			escreva("Engraçadinho você, né? Insira um valor válido!!\n\n")
			erro++
			teimosinha(nmrCartelaUser, nmrCartelasTotais, repetir, jogo, erro)
		}senao{
			para(inteiro i=0; i < repetir + nmrCartelaUser - 1; i++){
				para(inteiro b=0; b < tp.cadeia_para_inteiro(user[1][nmrCartelaUser - 1], 10); b++){
					user[i + 3][b] = user[nmrCartelaUser + 1][b]
				}
			}
	
			limpa()
	
			para(inteiro i=nmrCartelaUser + 1; i < repetir + nmrCartelaUser + 1; i++){
				se(tp.cadeia_para_inteiro(user[1][i-1], 10) > tp.cadeia_para_inteiro(user[1][nmrCartelaUser-1], 10)){
					erro = 1
					faca{
						erro = 0
						auxilio = 0
						auxilioAuxiliar = 0
						
						para(inteiro j=tp.cadeia_para_inteiro(user[1][nmrCartelaUser - 1], 10); j < tp.cadeia_para_inteiro(user[1][i-1], 10); j++){
							erro = 0
							mostrar(i-1)
							escreva("\n\nA sua ", i, "º cartela tem ", user[1][i- 1], " dezenas, e resta preencher os últimos ", tp.cadeia_para_inteiro(user[1][i-1], 10) - tp.cadeia_para_inteiro(user[1][nmrCartelaUser - 1], 10) - auxilio, " números, escolha o ", j+1, "º número.\n\n")
							leia(resposta)
							auxilio++

							se(auxilioAuxiliar != 0){
								auxilio = auxilioAuxiliar
								auxilioAuxiliar = 0
							}

							para(inteiro k=0; k < tp.cadeia_para_inteiro(user[1][nmrCartelaUser - 1], 10) + j; k++){
								se(user[i+1][k] == resposta ou tp.cadeia_para_inteiro(resposta, 10) < 1 ou tp.cadeia_para_inteiro(resposta, 10) > jogo[3]){
									limpa()
									escreva("Valor não permitido")
									auxilioAuxiliar = auxilio
									auxilio--
									j--
									erro++
									k = tp.cadeia_para_inteiro(user[1][nmrCartelaUser - 1], 10) + j
								}
							}
							se(erro == 0){
								user[i+1][j] = resposta
								organizarLinha(tp.cadeia_para_inteiro(user[1][nmrCartelaUser - 1], 10)+ auxilio, (i-1))
								limpa()
							}
						}
					}enquanto(erro != 0)
				}
			}
				
			escreva("Feito!!")
			u.aguarde(1000)
			limpa()
		}
	}

	funcao mostrar(inteiro i){
		para(inteiro c=0; c < tp.cadeia_para_inteiro(user[1][i], 10); c++){
			escreva(user[i+2][c], "	")
		}
	}

	funcao organizarLinha(inteiro userInt, inteiro i){
		inteiro userReserva[50]
		
		para(inteiro y=0; y < userInt; y++){
			userReserva[y] = tp.cadeia_para_inteiro(user[i+2][y], 10)
		}
						
		organizar(userReserva)
		
		para(inteiro j=0; j < userInt; j++){
			user[i+2][j] = tp.inteiro_para_cadeia(userReserva[j], 10)
		}
	}

	funcao casoErro(inteiro auxilioAuxiliar, inteiro auxilio, inteiro j, inteiro erro, cadeia frase){
		limpa()
		escreva(frase)
		auxilioAuxiliar = auxilio
		auxilio--
		j--
		erro++
	}

	funcao funcoes(inteiro jogo[], inteiro nmrCartelaUser, inteiro vezesMacro, logico validar){
		cadeia naoTrocarVazio[50]
		
		validarDezenas(jogo, nmrCartelaUser, validar)
		se(validar){
			receberApostas(nmrCartelaUser, jogo)
		}
		sortear(jogo, nmrCartelaUser)
		comparar(nmrCartelaUser, vezesMacro, jogo)
		se(vezesMacro >= 1){
			escreva("GANHOOU!! Em ", vezesMacro, " cartela(s)!!\n")
		}senao{
			escreva("Perdeeeu\n")
		}
	}

	funcao preco(inteiro nmrCartelaUser){
		se(user[0][0] == "MegaSena"){
			real numeroDeDezenas[10] = {4.50, 31.50, 126.0, 378.0, 945.0, 2079.0, 4158.0, 7722.0, 13513.0, 22522.0}
			assistentePreco(nmrCartelaUser, numeroDeDezenas, 6)
		}senao se(user[0][0] == "LotoFacil"){
			real numeroDeDezenas[6] = { 2.50, 40.0, 340.0, 2040.0, 9690.0, 38760.0}
			assistentePreco(nmrCartelaUser, numeroDeDezenas, 15)
		}senao se(user[0][0] == "Quina"){
			real numeroDeDezenas[11] = { 2.0, 12.0, 42.0, 112.0, 252.0, 504.0, 924.0, 1584.0, 2574.0, 4004.0, 6006.0}
			assistentePreco(nmrCartelaUser, numeroDeDezenas, 5)
		}senao{
			escreva("Totalizando ", nmrCartelaUser * 2.5, " reais.\n\n")
		}

	}

	funcao assistentePreco(inteiro nmrCartelaUser, real numeroDeDezenas[], inteiro diferenca){
		real soma = 0.0
		inteiro vezes = 1, auxiliar = 0
		
		para(inteiro i=0; i < nmrCartelaUser; i++){
			soma += numeroDeDezenas[tp.cadeia_para_inteiro(user[1][i], 10) - diferenca]
			escreva("A sua ", i+1, "º cartela teve ", user[1][i], " dezenas.\n")
		}

		escreva("\nTotalizando ", soma, " reais.")
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 15405; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = {user, 8, 8, 4}-{nmrCartelaUser, 94, 48, 14}-{k, 156, 16, 1}-{j, 348, 16, 1}-{j, 348, 16, 1}-{auxilio, 456, 10, 7}-{auxilioAuxiliar, 456, 19, 15}-{vezesContador, 456, 36, 13};
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
