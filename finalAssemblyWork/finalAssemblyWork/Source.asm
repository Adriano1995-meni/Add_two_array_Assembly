.MODEL FLAT, C    ;Use the flat memory model. Use C calling conventions
.CODE    ;Indicates the start of a code segment.
add_int PROC ;par�metros: unsigned char * vector1, unsigned char *vector2,
;unsigned char *resultado, int tamanho
;o tamanho � multiplo de 16 elementos
;os ponteiros est�o alinhados em m�ltiplos de 16 bytes
 push ebp ;salvar EBP na pilha
 mov ebp,esp            ;refer�ncia de pilha usando EBP
 
 push esi    ;Colocar o registo ESI no STACK
 push edi ;Colocar o registo EDI no STACK
 push ebx ;Colocar o registo EBX no STACK

 
 mov esi,[ebp+8]        ;Endre�os para os parametros da func�o add_int,  Correspondente a quarto parametro da fun�ao
 mov ebx,[ebp+12]       ;segundo parametro da fun�ao
 mov edi,[ebp+16]    
 mov ecx,[ebp+20]    
 shr ecx,2    
      ; A cada vez que � feita a opera�ao ser�o processados 4 elementos ou
;como se fosse estando a devidir o tamanho do vector por 4  ussando o registo xmm(128b).

 
 
 mov edx , 0     ;Igualar o contador a 0
 
next: cmp edx ,ecx ;Compara o contador com o Tamanho do vector
 je fim                  ;sair do ciclo em caso da Igualidade com o tamanho
 movdqa xmm0,[esi]       ;mover 16 bytes de mem�ria iniciados em esi para xmm0
 add esi,16 ;posiciona o ponteiro de esi 16 bytes � frente
 paddd xmm0,[ebx] ;adiciona 16 unsigned bytes(4 inteiros) e armazene o resultado em xmm0
 add ebx,16 ;posiciona o ponteiro ebx 16 bytes � frente
       
 movdqa [edi],xmm0       ;Guarda o resultado da soma no ponteiro de destino
 add edi,16 ;posiciona o ponteiro de edi 16 bytes � frente
 inc edx ;incrementa o contador
 jmp next                ;salta para proxima instru�ao
 fim:
 pop ebx ;retirados os 4 bytes  colocados na pilha
 pop edi
 pop esi
 pop ebp ;Restaurar o ebp
 ret ;�ltima instru��o na fun��o
 
add_int ENDP ;fim da fun��o
END