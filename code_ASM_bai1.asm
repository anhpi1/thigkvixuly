.model small
.stack 100h
.data
    getstring DB 10 , 0 , 10 dup(0)    
    
    
    ;begin user data
    ;main data       
    ARR db 8 dup(0) 
    
    ;count,sum,max,min
    groupA db 0,0,0,9
    groupB db 0,0,0,9
    groupC db 0,0,0,9
    errorA db " no element in groupA $"
    errorB db " no element in groupB $"
    errorC db " no element in groupC $"
    ;end user data
       
       
                    
                    
    ;convertCharToInt
    decIntUser db 10 , 0, 10 dup(0)
                    
    ;convetHexToCharDec
    cTemp db 10 dup(0)
    cPrint db 10 dup(0)
.code 
main proc    
    ;dung de sua lech vung nho     
    mov ax,@data
    mov ds,ax 
    
          
      
    ;nhap 8 so nguyen tu ban phim moi so tu 0 den 9 luu vao mang ARR
    ;begin user code1
         
    ;reset bien 
    mov ax,0
    mov bx,0 
    mov cx,0
    mov dx,0
    mov si,0
    mov di,0
      
    ;lay ki tu tu ban phim
    mov dx, offset getstring
    call gets    
    call convertCharToInt   
     
            
            
    ;di chuyen ki tu vao ARR
            
    mov si, offset decIntUser
    mov cl, [si+1]   ; Bl lam bien dem
    add si, 2
    mov di, offset ARR
        
    mainloop1:
        mov al, [si+bx]     
        mov [di+bx], al
        
        inc bl
        cmp bl, cl
        jb mainloop1                                                    
                                                                       
    ;end user code1            
    
    
    
    
    
       
    ;phan loai cac so thanh 3 nhom   
    ;begin user code2 
    
    ;reset bien 
    mov ax,0
    mov bx,0 
    mov cx,0
    mov dx,0
    mov si,0
    mov di,0           
          
    ;lay so luong vong lap va lay mang       
    mov si, offset decIntUser
    mov cl,[si+1]
    mov si,offset ARR 
     
    
    mainloop21:     
        
        ;dieu kien chia nhom
        ;dieu kien chia het cho 3
        mov ax,0  
        mov al, [si+bx]
        mov dl,3            
        div dl       
        cmp ah,0
        je mainIf2
        
        ;dieu kien chia het cho 2   
        mov ax,0   
        mov al, [si+bx]
        mov dl,2
        div dl  
        cmp ah,0
        jne mainElseIf2
        
        jmp mainElse2:      
         
              
        mainIf2: 
            mov ax,0  
            mov al,[si+bx]
            mov di, offset groupA
            call addGroup  
              
            jmp mainEndIf2
            
        mainElseIf2:
            mov ax,0 
            mov al,[si+bx]
            mov di, offset groupB
            call addGroup 
        
            jmp mainEndIf2
        mainElse2:    
            mov ax,0  
            mov al,[si+bx]
            mov di, offset groupC
            call addGroup
        
            jmp mainEndIf2
            
        mainEndIf2:
        
        inc bl   
        
        cmp bl,cl 
        jb mainloop21:         
    ;end user code2 
      
    ;begin user code3
    mov dl,0Ah
    mov ah, 2
    int 21h  
    ;end user code3  
        
        
    ;phan code di in
    ;begin user code4
    ;reset bien 
    mov ax,0
    mov bx,0 
    mov cx,0
    mov dx,0
    mov si,0
    mov di,0 
    
    mov bx,0
    mov cl,4
    mov si, offset groupA  
    cmp [si],0
    je noElementInGroupA:
    
    mainLoop41:       
        mov dx,0
        mov ax,0
        mov al,[si+bx]
        call convetHexToCharDec  
        mov dx, offset cprint
        call puts 
          
        
        mov dx,0
        mov ax,0
        mov dl,32
        mov ah, 2
        int 21h 
        
        inc bl
        cmp bl,cl
        jb mainLoop41
    jmp hasElementInGroupA 
        
    noElementInGroupA:
    mov dx, offset errorA
    call puts 

    hasElementInGroupA:
    ;reset bien 
    mov ax,0
    mov bx,0 
    mov cx,0
    mov dx,0
    mov si,0
    mov di,0 
    
    mov bx,0
    mov cl,4
    mov si, offset groupB  
    cmp [si],0
    je noElementInGroupB:
    
    mainLoop42:       
        mov dx,0
        mov ax,0
        mov al,[si+bx]
        call convetHexToCharDec  
        mov dx, offset cprint
        call puts  
        
          
        mov dx,0
        mov ax,0
        mov dl,32
        mov ah, 2
        int 21h 
        
        inc bl
        cmp bl,cl
        jb mainLoop42   
    jmp hasElementInGroupB 
        
    noElementInGroupB:
    mov dx, offset errorB
    call puts 

    hasElementInGroupB:    
    ;reset bien 
    mov ax,0
    mov bx,0 
    mov cx,0
    mov dx,0
    mov si,0
    mov di,0 
    
    mov bx,0
    mov cl,4
    mov si, offset groupC 
    cmp [si],0
    je noElementInGroupC:
    mainLoop43:       
        mov dx,0
        mov ax,0
        mov al,[si+bx]
        call convetHexToCharDec  
        mov dx, offset cprint
        call puts 
        
        mov dx,0
        mov ax,0
        mov dl,32
        mov ah, 2
        int 21h 
        
        inc bl
        cmp bl,cl
        jb mainLoop43  
    jmp hasElementInGroupC 
        
    noElementInGroupC:
    mov dx, offset errorC
    call puts 

    hasElementInGroupC:                
                     
        
    ;end user code4
    
    
                                                                      
    ; theo chat gpt said de chuong trinh k bi soc neu lenh cuoi là call
    mov ah, 4Ch
    int 21h
main endp  
      

  

addGroup proc  
    ;input AL chua du lieu can so sanh
    ;      DI chua dia chi group
    ;output   
    
    ;cac du lieu can khai bao trong data  
    ;count,sum,max,min
    ;groupA db 0,0,0,9
    ;groupB db 0,0,0,9
    ;groupC db 0,0,0,9

      
    ;luu gia tri ban dau
    push ax
    push bx
    push cx
    push dx
    push si 
    push di 
    
    ;reset bien 
    
    mov bx,0
    mov cx,0
    mov dx,0
    mov si,0
         
         
    ;begin user code
        ;count,sum,max,min
        
        ;them so phan tu     
        inc [di+0]
                  
        ;tinh tong
        add [di+1], al 
        
        ;tim phan tu max
        cmp al, [di+2]
        jbe mainNotMax2        
        mov [di+2], al        
        mainNotMax2:
        
        ;tim phan tu min 
        cmp al, [di+3]
        jae mainNotMin2        
        mov [di+3], al        
        mainNotMin2:
        
    ;end user code  
       
    ;tra lai gia tri ban dau   
    pop di
    pop si 
    pop dx
    pop cx
    pop bx
    pop ax 
    ret
addGroup endp 

          
convertCharToInt proc  
    ;input: DI chua dia chi vung nho chua ki tu duoc nhap vao 
    ;luu y dinh dang vung nho duoc dx tro vao        
    ;vi du ve chuoi getstring DB 100 , 0 , 100 dup(0) 
    ;hai phan tu dau tien la so ki tu toi da phan tu thu 2 la so ki tu trong chuoi
    
    ;output: decIntUser phan tu dau tien la so ki tu toi da phan tu thu w la do dai chuoi tu phan tu thu 3 la chuoi ki tu  
    
    ;cac du lieu can khai bao trong data  \
    ;decIntUser db 100 , 0, 100 dup(0)
         
         
        

      
    ;luu gia tri ban dau
    push ax
    push bx
    push cx
    push dx
    push si 
    push di 
    
    ;reset bien 
    mov ax,0
    mov bx,0 
    mov cx,0
    mov si,0
    mov di,0
         
         
    ;begin user code 
    ;bx lam chi so
     
    mov si, dx
    
    
    
    mov di, offset decIntUser
    
    mov ah,[si] 
    mov [di],ah
    mov ah,0
           
    mov ah, [si+1]    
    mov [di+1], ah  
    mov cl, ah ; cx lam bien dem
    mov ah,0 
               
    add si, 2
    add di, 2
               
    convertCharToIntLoop1:
        
                   
        mov al, [si+bx]            
        sub al, '0'        
        mov [di+bx], al
        inc bx
        cmp bl, cl
        jb convertCharToIntLoop1 
     
    ;end user code  
       
    ;tra lai gia tri ban dau   
    pop di
    pop si 
    pop dx
    pop cx
    pop bx
    pop ax 
    ret
convertCharToInt endp          
          

convetHexToCharDec proc
    ;input: dx:ax   
    ;output: cPrint
    
    ;cac du lieu can khai bao trong data
         
    ;cTemp db 100 dup(0)
    ;cPrint db 100 dup(0)
     
    ;luu gia tri ban dau  
    push ax
    push bx
    push cx
    push dx
    push si 
    push di    
            
    ;reset bien 
    mov si,0
    mov di,0    
    mov bx,0
    mov cx,0    
    
    ;begin user code  
     
    ;vong lap tach cac so va sau do ghi ki tu vao bien cTemp    
    convetHexToCharDecLoop0:    
        ;lay chu so cuoi cung
        mov cx, 0ah
        div cx    
        
        ;chuyen doi so sang ki tu           
        mov cx, '0'
        add cx,dx    
        
        
        mov si, offset cTemp
        
        mov [si+bx] , cx
        
        ;lay bx lam chi so vong lap      
        inc bx
        
        ; dieu kien vong lap lap cho den khi chia het 
        mov dx,0      
        cmp ax, 0
        jne convetHexToCharDecLoop0      
    
    ;du lieu sau xu ly bi nguoc va can phai dao lai them ki tu ket thuc o cuoi chuoi             
    mov cx,bx      
    mov bx,0  
               
    ;su dung bx lam chi so vong lap
    convetHexToCharDecLoop1:                              
        mov si, offset cTemp    
        mov di, offset cprint
        
        ;lay dia chi phan tu cuoi cung
        add si,cx
        dec si    
                
        sub si,bx   
        mov dl,[si]
        mov [di+bx],dl
        
        inc bx
        cmp bx, cx
        jb convetHexToCharDecLoop1
    
    mov di, offset cprint 
    
    add di, cx
    mov [di], '$'  
    
    
    ;end user code         
                 
    ; lenh reset bo nho sau khi dung
    mov di, offset cTemp    
    mov cx, 10         
    mov al, 0           
    rep stosb           
            
    
    ;tra lai gia tri ban dau        
    pop di
    pop si 
    pop dx
    pop cx
    pop bx
    pop ax 
    ret
convetHexToCharDec endp    
 
    
puts proc
    ;input: dx chua dia chi chuoi can in
    ;chuoi can phai duoc ket thuc bang $
     
    
    push ax
    push bx
    push cx
    push dx
    push si 
    push di
            
    ;reset bien  
    mov ax,0
       
    ;begin user code   
    mov ah,9
    int 21h
    ;end user code       
                          
    ;tra lai gia tri ban dau      
    pop di
    pop si 
    pop dx
    pop cx
    pop bx
    pop ax 
    ret  
puts endp      

gets proc  
    ;input dx chua dia chi chuoi
    ;output du lieu duoc ghi trong dia chi cua dx   
    
    ;cac du lieu can khai bao trong data
    ;vi du ve chuoi getstring DB 100 , 0 , 100 dup(0) 
    ;hai phan tu dau tien la so ki tu toi da phan tu thu 2 la so ki tu trong chuoi 
      
    ;luu gia tri ban dau
    push ax
    push bx
    push cx
    push dx
    push si 
    push di 
    
    ;reset bien 
    mov ax,0
    mov bx,0
         
         
    ;begin user code     
    mov ah,10
    int 21h
        
    
    
    mov ax,0
    mov al,getstring[1]
    mov bx, dx
    add bx, ax
    add bx, 2
    mov [bx], '$' 
    ;end user code  
       
    ;tra lai gia tri ban dau   
    pop di
    pop si 
    pop dx
    pop cx
    pop bx
    pop ax 
    ret
gets endp

name proc  
    ;input 
    ;output   
    
    ;cac du lieu can khai bao trong data

      
    ;luu gia tri ban dau
    push ax
    push bx
    push cx
    push dx
    push si 
    push di 
    
    ;reset bien 
    mov ax,0
    mov bx,0
    mov cx,0
    mov dx,0
    mov si,0
    mov di,0
         
         
    ;begin user code     
     
    ;end user code  
       
    ;tra lai gia tri ban dau   
    pop di
    pop si 
    pop dx
    pop cx
    pop bx
    pop ax 
    ret
name endp


end main  


  