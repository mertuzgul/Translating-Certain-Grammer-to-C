%{
    #include <stdio.h>
    #include <string.h>
    void yyerror(char *);
    int yylex(void);
    extern FILE *yyin;
    extern int linenum;
    int orcount=1; // or sayar
    
    int c[26]; //analysis 1 için integer tutar ANALYSIS1
    char b[26][26]; //analysis1 için nonterminal tutar ANALYSIS1
    int i=0; // analysis 1 için array index counter ANALYSIS1
    int loop=0; // analysis1 için loop

    char b2[26][26]; //rule tutan array ANALYSIS2
    char b3[26][26]; //condition tutan array ANALYSIS2
    int c2[26]; // i guess it is useless now
    int loop2=0; // rule tutan arrayın loopu ANALYSIS2
    int loop3=0; // condition tutan arrayın loopu ANALYSIS2
    int j=0; // rule tutan arrayın index counteri ANALYSIS2
    
    int k=0; // condition tutan arrayın index counteri ANALYSIS2
    int m=0; // condition hata basma ve rule hata basma için loop ANALYSIS2

    //int cakal=0;
    //int cakal2=0;
    
    char conditioner[26][26]; //condition hata bulma arrayı ANALYSIS2
    char ruler[26][26]; //rule hata bulma arrayı ANALYSIS2
    int condition=0; // condition hata bulma arrayı index counteri ANALYSIS2
    int rule=0; // rule hata bulma arrayı index counteri ANALYSIS2


    char nonterminalfinder[26][26]; //nonterminal tutan array ANALYSIS3
    int nonterminalcount=0; //nonterminal tutan arrayin index counteri ANALYSIS3
    int nonterminalloop=0; // nonterminal arrayi gezmek için loop ANALYSIS3

    

    char terminalfinder[26][26]; //terminal tutan array aynı zamanda int ve float tutar ANALYSIS3
    int terminalcount=0; //terminal tutan arrayin index counteri ANALYSIS3
    int terminalloop=0; // terminal arrayi gezmek için loop ANALYSIS3

    //C code generator için tutulan kısım

    int CFlag=0; // HATA YOKSA C KODUNA GEÇME FLAGI

    char arithmeticopfinder[26][26]; //arithmeticopları tutan array
    int arithmeticopcount=0; // arithmeticop tutan arrayin index counteri
    int arithmeticoploop=0; // arithmeticop arrayi gezmek için loop
    char openparfinder[26][26]; // parantez açmaları tutan array
    int openparcount=0; // parantez açma tutan arrayin index counteri
    int openparloop=0; //parantez açma arrayinin loopu
    char closeparfinder[26][26]; // parantez kapamaları tutan array
    int closeparcount=0; //parantez kapama arrayinin index counteri
    int closeparloop=0; //parantez kapama arrayinin loopu
    int flagint=0; 
    int flagfloat=0;
    int flagplus=0;
    int flagminus=0;
    int flagtimes=0;
    int flagdivide=0;
    int flagopen=0;
    int flagclose=0;
    int area[500]; //C kodunu geliştirmek için lazım olacaktı
    int areaidentifier=0; //C kodunu geliştirmek için lazım olacaktı
    int arealoop=0; //C kodunu geliştirmek için lazım olacaktı

    
    
    
%}
%union
{
char *string;
int number;
}
%token pointer or percentage rules semicolon plusop minusop multop divideop arithmeticop openpar closepar
%token <number> integer
%token <string> nonterminal
%token <string> terminal
%token <string> type
%token <string> arithmeticop openpar closepar

%%

statement:

	percentage rules statement2 semicolon happyhour		{
								for(loop2=0;loop2<j;loop2++) //rule fazlalığı için
								{
									for(loop3=0;loop3<k;loop3++)
									{
										if(strcmp(b2[loop2],b3[loop3])==0)
										{
											break;
										}
										else if(loop3 == k-1) //sona geldiyse zaten fazlalık her türlü bulundu.
										{
											CFlag=1;
											strcpy(conditioner[condition],b2[loop2]);
											condition++;
											break;
										}	
									}
								}
								for(m=0;m<condition;m++)
									printf("***ERROR IN ANALYSIS 2***\n\nCondition Missing %s\n\n",conditioner[m]);
	/*ANALYSIS 2 HANDLED*/							}
								{
								for(loop3=0;loop3<k;loop3++) //condition fazlalağı için
								{
									for(loop2=0;loop2<j;loop2++)
									{
										if(strcmp(b2[loop2],b3[loop3])==0)
										{
											break;
										}
										else if(loop2 == j-1) //sona geldiyse zaten fazlalık her türlü bulundu.
										{
											CFlag=1;
											strcpy(ruler[rule],b3[loop3]);
											rule++;
										}
									}
								}
								for(m=0;m<rule;m++)
									printf("***ERROR IN ANALYSIS 2***\n\nRule Missing %s\n\n",ruler[m]);
								
								
					
								
				
								
							
						
							for(loop2=0;loop2<j;loop2++)
							{
								for(loop3=0;loop3<k;loop3++) //eşleştirmece yapar debug içindi sonra printini sildim örneğin E matched with E yazardı
								{
									if(strcmp(b2[loop2],b3[loop3])==0)
									{
		
											
									}
									
								}
								
							}
						}
						{
/*ANALYSIS3 HANDLED*/				for(nonterminalloop=0;nonterminalloop<nonterminalcount;nonterminalloop++)
							{
								for(loop2=0;loop2<j;loop2++)
								{
								
									if(strcmp(b2[loop2],nonterminalfinder[nonterminalloop])==0)
									{

										break;
									}
									else if(loop2 == j-1)
									{	CFlag=1;
										printf("***ERROR IN ANALYSIS 3***\n\n%s is referenced but not defined as a rule\n\n",nonterminalfinder[nonterminalloop]);
									}
								}
							}
						}
						
						;

statement2:

	nonterminal integer{strcpy(b[i],$1);strcpy(b2[j],$1);c[i]=$2;/*c2 may be useless check it later*/c2[j]=$2;i++;j++;} statement2  // %rules T 3 E 2; is handled 
	|
	;
	// or it can end here but that may be a mistake
happyhour:
	// T-> handled and afterhour called for next steps
	nonterminal pointer afterhour{strcpy(b3[k],$1);k++;}  semicolon   
							{for(loop=0;loop<i;loop++)//analysis 1 handled
								{
								if(strcmp(b[loop],$1)==0)
									{
									if(c[loop]==orcount)
										{

										}
									else
										{
										CFlag=1;
										printf("***ERROR IN ANALYSIS 1***\n\n");
										printf("%s has %d rules but you are trying to implement %d rules\n\n",b[loop],c[loop],orcount);
										}
									}
								
								}
						
							
							
							
						 orcount=1;							
						 }
						happyhour // tekrar condition yazmak istersek diye burada yatıyor semicolondan önce

						 
	|
	// or it can end here
	; 
	
afterhour://bütün işleri hallediyor
	nonterminal or afterhour {orcount++;strcpy(nonterminalfinder[nonterminalcount],$1);nonterminalcount++;}
	|
	terminal or afterhour {orcount++;strcpy(terminalfinder[terminalcount],$1);terminalcount++;}
	|
	nonterminal  {strcpy(nonterminalfinder[nonterminalcount],$1);nonterminalcount++;}
	|
	terminal {strcpy(terminalfinder[terminalcount],$1);terminalcount++;}
	|
	type {strcpy(terminalfinder[terminalcount],$1);terminalcount++;}
	|
	type or afterhour {orcount++;strcpy(terminalfinder[terminalcount],$1);terminalcount++;}
	|
	type arithmeticop operator {strcpy(terminalfinder[terminalcount],$1);terminalcount++;strcpy(arithmeticopfinder[arithmeticopcount],$2);arithmeticopcount++;}
	|
	nonterminal arithmeticop operator afterhour {strcpy(nonterminalfinder[nonterminalcount],$1);nonterminalcount++;strcpy(arithmeticopfinder[arithmeticopcount],$2);arithmeticopcount++;}
	|
	terminal arithmeticop operator afterhour {strcpy(terminalfinder[terminalcount],$1);terminalcount++;strcpy(arithmeticopfinder[arithmeticopcount],$2);arithmeticopcount++;}
	|
	openpar afterhour closepar afterhour {strcpy(openparfinder[openparcount],$1);openparcount++;strcpy(closeparfinder[closeparcount],$3);closeparcount++;}
	|
	openpar afterhour closepar arithmeticop afterhour {strcpy(openparfinder[openparcount],$1);openparcount++;strcpy(closeparfinder[closeparcount],$3);closeparcount++;strcpy(arithmeticopfinder[arithmeticopcount],$4);arithmeticopcount++;}
	|
	or afterhour {orcount++;}
	|
	;
operator: //H*(A+B)|;
	nonterminal {strcpy(nonterminalfinder[nonterminalcount],$1);nonterminalcount++;}
	|
	terminal {strcpy(terminalfinder[terminalcount],$1);terminalcount++;}
	|
	type {strcpy(terminalfinder[terminalcount],$1);terminalcount++;}
	|
	type or operator {orcount++;strcpy(terminalfinder[terminalcount],$1);terminalcount++;} 
	|
	type arithmeticop operator {strcpy(terminalfinder[terminalcount],$1);terminalcount++;strcpy(arithmeticopfinder[arithmeticopcount],$2);arithmeticopcount++;}
	|
	nonterminal or operator {orcount++;strcpy(nonterminalfinder[nonterminalcount],$1);nonterminalcount++;} 
	|
	terminal or operator {orcount++;strcpy(terminalfinder[terminalcount],$1);terminalcount++;} 
	|
	nonterminal arithmeticop operator {strcpy(nonterminalfinder[nonterminalcount],$1);nonterminalcount++;strcpy(arithmeticopfinder[arithmeticopcount],$2);arithmeticopcount++;}
	|
	terminal arithmeticop operator{strcpy(terminalfinder[terminalcount],$1);terminalcount++;strcpy(arithmeticopfinder[arithmeticopcount],$2);arithmeticopcount++;}
	|
	openpar operator closepar {strcpy(openparfinder[openparcount],$1);openparcount++;strcpy(closeparfinder[closeparcount],$3);closeparcount++;}
	; 
%%
void yyerror(char *s) 
{
    CFlag=1;
    fprintf(stderr, "%s\n ++++ %d", s,linenum);
}
int yywrap()
{
	return 1;
}
int main(int argc, char *argv[])
{
	yyin=fopen(argv[1],"r");
	yyparse();
	
	if(CFlag!=1)
	{
		printf("#include <stdio.h>\n");	
		printf("typedef enum {");

		for(terminalloop=0;terminalloop<terminalcount;terminalloop++) //by the way terminalfinder keeps all 															(int,float),start,...
		{								// but i take int,float in lex with name type
									// but i take start,end,begin... in lex with name terminal
									// it is not an error it is just a recall 
			if(strcmp(terminalfinder[terminalloop],"int")==0)
			{
				if(flagint==0)
				{
					printf("INT,");
					flagint=1;
				}
			}
			else if(strcmp(terminalfinder[terminalloop],"float")==0)
			{
				if(flagfloat==0)
				{
					printf("FLOAT,");
					flagfloat=1;
				}
			}
		}
		for(arithmeticoploop=0;arithmeticoploop<arithmeticopcount;arithmeticoploop++)
		{
			if(strcmp(arithmeticopfinder[arithmeticoploop],"+")==0)
			{
				if(flagplus==0)
				{
					printf("PLUS,");
					flagplus=1;
				}
			}
			else if(strcmp(arithmeticopfinder[arithmeticoploop],"-")==0)
			{
				if(flagminus==0)
				{
					printf("MINUS,");
					flagminus=1;
				}
			}
			else if(strcmp(arithmeticopfinder[arithmeticoploop],"*")==0)
			{
				if(flagtimes==0)
				{
					printf("TIMES,");
					flagtimes=1;
				}
			}
			else if(strcmp(arithmeticopfinder[arithmeticoploop],"/")==0)
			{
				if(flagdivide==0)
				{
					printf("DIVIDE,");
					flagdivide=1;
				}
			}
		}
		if(openparcount>0)
		{
			printf("OPEN,CLOSE,");
		}
		printf("END} TOKEN;\n");
		printf("YOU CAN ENTER YOUR INPUT HERE\n");
		printf("TOKEN *next = input;\n\n");
		for(loop2=0;loop2<j;loop2++)
		{
			printf("int %s(); ",b2[loop2]);
			for(loop=0;loop<c[loop2];loop++)
			{
				printf("int %s%d(); ",b2[loop2],loop+1);
			}
		}
		printf("\nint term(TOKEN tok) {return *next++ == tok;}\n");

		for(loop2=0;loop2<j;loop2++)
		{
			
			for(loop=0;loop<c[loop2];loop++)
			{
				printf("int %s%d() \n",b2[loop2],loop+1);
				for(nonterminalloop=0;nonterminalloop<nonterminalcount;nonterminalloop++)
				{
					//i cant do the beyond
				}
			}
			printf("int %s(); \n",b2[loop2]);
		}
		printf("int main(void)\n{\n");
		printf("if (%s() && term(END))\n",b3[0]);
		printf("  printf(\"Accept!\\n\");\n");
		printf("else\n");
		printf("  printf(\"Reject!\\n\");\n");
		printf("return 0;\n}\n");
		















							
	}				
	fclose(yyin);
	return 0;
}
