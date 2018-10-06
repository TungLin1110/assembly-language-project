INCLUDE Irvine32.inc
.data
space BYTE " ",0
str1 BYTE "歡迎來到推箱子遊戲 ",0
str2 BYTE "----------遊戲方式----------",0
str3 BYTE "使用數字鍵8,5,4,6控制上下左右",0
str4 BYTE "將所有箱子推到目的地即可完成遊戲",0
str5 BYTE "!----玩家",0
str6 BYTE "※----牆壁",0
str7 BYTE "○----箱子",0
str8 BYTE "◎----目的地",0
str9 BYTE "○",0
str10 BYTE "※",0
str11 BYTE "●",0
str12 BYTE "  ",0
str13 BYTE "◎",0
str14 BYTE "！",0
str15 BYTE "厲害!!",0
str16 BYTE "恭喜你完成遊戲!!",0
str17 BYTE "真可惜!!",0
str18 BYTE "下次再加油!!",0
str19 BYTE "想離開請按'1'!!",0
str20 BYTE "你花的步數:",0
str21 BYTE "步數:",0
str22 BYTE "想重新開始請按'3'!!",0
str23 BYTE "輸入'1'重新遊戲!!",0
str24 BYTE "輸入'2'離開遊戲!!",0
MAP    dword 0,0,0,0,0,0,0,0
	   dword 0,0,2,4,0,0,0,0
	   dword 0,0,2,1,2,2,0,0
	   dword 0,0,2,2,0,2,0,0
	   dword 0,3,0,2,0,2,2,0
	   dword 0,3,1,2,2,0,2,0
	   dword 0,3,2,2,2,1,2,0
	   dword 0,0,0,0,0,0,0,0
MAP2   dword 0,0,0,0,0,0,0,0
	   dword 0,0,2,4,0,0,0,0
	   dword 0,0,2,1,2,2,0,0
	   dword 0,0,2,2,0,2,0,0
	   dword 0,3,0,2,0,2,2,0
	   dword 0,3,1,2,2,0,2,0
	   dword 0,3,2,2,2,1,2,0
	   dword 0,0,0,0,0,0,0,0


temp dword ?
userstand dword ?
standontarget dword ?
endcount dword ?
walkcount dword ?
.code
main PROC

mov edx,OFFSET str1
call WriteString
call ReadInt
call Clrscr
mov edx,OFFSET str2
call WriteString
call crlf
mov edx,OFFSET str3
call WriteString
call crlf
mov edx,OFFSET str4
call WriteString
call crlf
call crlf
call crlf
mov edx,OFFSET str5
call WriteString
call crlf
mov edx,OFFSET str6
call WriteString
call crlf
mov edx,OFFSET str7
call WriteString
call crlf
mov edx,OFFSET str8
call WriteString
call crlf
call crlf
call crlf
call crlf
mov edx,OFFSET str19
call WriteString
call crlf
mov edx,OFFSET str22
call WriteString
call crlf
call ReadInt


mov userstand,44
mov standontarget,0
mov endcount,3
mov walkcount,0
call PRINT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PRINT PROC
call Clrscr
mov edx,OFFSET str19
call WriteString
call crlf
mov edx,OFFSET str22
call WriteString
call crlf
mov ebx ,0
mov ecx ,8
L2:
push ecx
mov ecx,8
L1:
mov eax,MAP[ebx]
cmp MAP[ebx],0
jbe wall
cmp MAP[ebx],1
jbe box
cmp MAP[ebx],2
jbe road
cmp MAP[ebx],3
jbe target
cmp MAP[ebx],4
jbe user
cmp MAP[ebx],5
jbe good
wall:
mov edx,OFFSET str10
call WriteString
jmp ok
box:
mov edx,OFFSET str9
call WriteString
jmp ok
road:
mov edx,OFFSET str12
call WriteString
jmp ok
target:
mov edx,OFFSET str13
call WriteString
jmp ok
user:
mov edx,OFFSET str14
call WriteString
jmp ok
good:
mov edx,OFFSET str11
call WriteString
ok:
add ebx,4
dec ecx
cmp ecx,0
jne L1
call crlf
pop ecx
dec ecx
cmp ecx,0
jne L2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




PRINT ENDP

mov edx,OFFSET str21
call WriteString
mov eax,walkcount
call writedec
call crlf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp endcount,0
je endall


mov ebx,userstand
call ReadInt
cmp eax,1
je leavegame 
cmp eax,3
je re
cmp eax,4 
jbe left 
cmp eax,5 
jbe down 
cmp eax,6 
jbe right 
cmp eax,8 
jbe up 
;cmp eax,9
;jbe leavegame
 
left:
call doleft
jmp next

down:
call dodown
jmp next

right:
call doright
jmp next

up:
call doup
jmp next

leavegame:
jmp leaveend

re:
call restart
call print
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
doleft PROC
;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,MAP[ebx-4]
cmp eax,0
jbe cannowalk
cmp eax,1
jbe canpushornot
cmp eax,2
jbe canwalk
cmp eax,3
jbe canwalk2
cmp eax,5
jbe canpushornot2
;;;;;;;;;;;;;;;;;;;;;;;;;
cannowalk:
jmp leftend
;;;;;;;;;;;;;;;;;;;;;;;;;
canpushornot:
mov ecx,MAP[ebx-8]
cmp ecx,0
jbe cannotpush
cmp ecx,1
jbe cannotpush
cmp ecx,2
jbe canpush
cmp ecx,3
jbe canpush2
cmp ecx,5
jbe cannotpush

cannotpush:
jmp leftend

canpush:
mov MAP[ebx-8],1
mov MAP[ebx-4],4
mov MAP[ebx],2
sub userstand,4
add walkcount,1
mov edx,standontarget
cmp edx,1
jne jend1_1
mov MAP[ebx],3
mov standontarget,0
jend1_1:
jmp leftend

canpush2:
mov MAP[ebx-8],5
mov MAP[ebx-4],4
mov MAP[ebx],2
sub endcount,1
sub userstand,4
add walkcount,1
mov edx,standontarget
cmp edx,1
jne jend1_2
mov MAP[ebx],3
mov standontarget,0
jend1_2:
jmp leftend


;;;;;;;;;;;;;;;;;;;;;;;;;;;
canpushornot2:
mov ecx,MAP[ebx-8]
cmp ecx,0
jbe cannotpush_2
cmp ecx,1
jbe cannotpush_2
cmp ecx,2
jbe canpush_2
cmp ecx,3
jbe canpush2_2
cmp ecx,5
cannotpush_2:
jmp leftend
canpush_2:
mov MAP[ebx-8],1
mov MAP[ebx-4],4
mov MAP[ebx],2
sub userstand,4
add walkcount,1
mov edx,standontarget
cmp edx,1
jne jend1_3
mov MAP[ebx],3
mov standontarget,1
jend1_3:
jmp leftend
canpush2_2:
mov MAP[ebx-8],5
mov MAP[ebx-4],4
mov MAP[ebx],2
sub userstand,4
add walkcount,1
mov edx,standontarget
cmp edx,1
jne jend1_4
mov MAP[ebx],3
mov standontarget,1
jend1_4:
jmp leftend
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
canwalk:
mov MAP[ebx-4],4
mov MAP[ebx],2
sub userstand,4
add walkcount,1 
mov edx,standontarget
cmp edx,1
jne jend1_5
mov MAP[ebx],3
mov standontarget,0
jend1_5:
jmp leftend
canwalk2:
mov MAP[ebx-4],4
mov MAP[ebx],2
sub userstand,4
add walkcount,1 
mov standontarget,1
jmp leftend
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
leftend:
ret
doleft ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dodown PROC
mov eax,MAP[ebx+32]
cmp eax,0
jbe cannowalk
cmp eax,1
jbe canpushornot
cmp eax,2
jbe canwalk
cmp eax,3
jbe canwalk2
cmp eax,5
jbe canpushornot2
;;;;;;;;;;;;;;;;;;;;;;;;;
cannowalk:
jmp downend
;;;;;;;;;;;;;;;;;;;;;;;;;
canpushornot:
mov ecx,MAP[ebx+64]
cmp ecx,0
jbe cannotpush
cmp ecx,1
jbe cannotpush
cmp ecx,2
jbe canpush
cmp ecx,3
jbe canpush2
cmp ecx,5

cannotpush:
jmp downend

canpush:
mov MAP[ebx+64],1
mov MAP[ebx+32],4
mov MAP[ebx],2
add userstand,32
add walkcount,1
mov edx,standontarget
cmp edx,1
jne jend1_1
mov MAP[ebx],3
mov standontarget,0
jend1_1:
jmp downend

canpush2:
mov MAP[ebx+64],5
mov MAP[ebx+32],4
mov MAP[ebx],2
sub endcount,1
add userstand,32
add walkcount,1
mov edx,standontarget
cmp edx,1
jne jend1_2
mov MAP[ebx],3
mov standontarget,0
jend1_2:
jmp downend
;;;;;;;;;;;;;;;;;;;;;;;;;;;
canpushornot2:
mov ecx,MAP[ebx+64]
cmp ecx,0
jbe cannotpush_2
cmp ecx,1
jbe cannotpush_2
cmp ecx,2
jbe canpush_2
cmp ecx,3
jbe canpush2_2
cmp ecx,5
cannotpush_2:
jmp downend
canpush_2:
mov MAP[ebx+64],1
mov MAP[ebx+32],4
mov MAP[ebx],2
add userstand,32
add walkcount,1
mov edx,standontarget
cmp edx,1
jne jend1_3
mov MAP[ebx],3
mov standontarget,1
jend1_3:
jmp downend
canpush2_2:
mov MAP[ebx+64],5
mov MAP[ebx+32],4
mov MAP[ebx],2
add userstand,32
add walkcount,1
mov edx,standontarget
cmp edx,1
jne jend1_4
mov MAP[ebx],3
mov standontarget,1
jend1_4:
jmp downend
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
canwalk:
mov MAP[ebx+32],4
mov MAP[ebx],2
add userstand,32
add walkcount,1
mov edx,standontarget
cmp edx,1
jne jend1_5
mov MAP[ebx],3
mov standontarget,0
jend1_5:
jmp downend

canwalk2:
mov MAP[ebx+32],4
mov MAP[ebx],3
add userstand,32
add walkcount,1
mov standontarget,1
jmp downend
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
downend:
ret
dodown ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
doright PROC
mov eax,MAP[ebx+4]
cmp eax,0
jbe cannowalk
cmp eax,1
jbe canpushornot
cmp eax,2
jbe canwalk
cmp eax,3
jbe canwalk2
cmp eax,5
jbe canpushornot2
;;;;;;;;;;;;;;;;;;;;;;;;;
cannowalk:
jmp rightend
;;;;;;;;;;;;;;;;;;;;;;;;;
canpushornot:
mov ecx,MAP[ebx+8]
cmp ecx,0
jbe cannotpush
cmp ecx,1
jbe cannotpush
cmp ecx,2
jbe canpush
cmp ecx,3
jbe canpush2
cmp ecx,5

cannotpush:
jmp rightend

canpush:
mov MAP[ebx+8],1
mov MAP[ebx+4],4
mov MAP[ebx],2
add userstand,4
add walkcount,1
mov edx,standontarget
cmp edx,1
jne jend1_1
mov MAP[ebx],3
mov standontarget,0
jend1_1:
jmp rightend

canpush2:
mov MAP[ebx+8],5
mov MAP[ebx+4],4
mov MAP[ebx],2
add userstand,4
add walkcount,1
sub endcount,1
mov edx,standontarget
cmp edx,1
jne jend1_2
mov MAP[ebx],3
mov standontarget,0
jend1_2:
jmp rightend
;;;;;;;;;;;;;;;;;;;;;;;;;;;
canpushornot2:
mov ecx,MAP[ebx+8]
cmp ecx,0
jbe cannotpush_2
cmp ecx,1
jbe cannotpush_2
cmp ecx,2
jbe canpush_2
cmp ecx,3
jbe canpush2_2
cmp ecx,5
cannotpush_2:
jmp rightend
canpush_2:
mov MAP[ebx+8],1
mov MAP[ebx+4],4
mov MAP[ebx],2
mov edx,standontarget
cmp edx,1
jne jend1_3
mov MAP[ebx],3
mov standontarget,1
add userstand,4
add walkcount,1
jend1_3:
jmp rightend
canpush2_2:
mov MAP[ebx+8],5
mov MAP[ebx+4],4
mov MAP[ebx],2
mov edx,standontarget
cmp edx,1
jne jend1_4
mov MAP[ebx],3
mov standontarget,1
add userstand,4
add walkcount,1
jend1_4:
jmp rightend
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
canwalk:
mov MAP[ebx+4],4
mov MAP[ebx],2
add userstand,4
add walkcount,1 
mov edx,standontarget
cmp edx,1
jne jend1_5
mov MAP[ebx],3
mov standontarget,0
jend1_5:
jmp rightend
canwalk2:
mov MAP[ebx+4],4
mov MAP[ebx],3
mov standontarget,1
add userstand,4
add walkcount,1 
jmp rightend
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
rightend:
ret
doright ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
doup PROC
mov eax,MAP[ebx-32]
cmp eax,0
jbe cannowalk
cmp eax,1
jbe canpushornot
cmp eax,2
jbe canwalk
cmp eax,3
jbe canwalk2
cmp eax,5
jbe canpushornot2
;;;;;;;;;;;;;;;;;;;;;;;;;
cannowalk:
jmp upend
;;;;;;;;;;;;;;;;;;;;;;;;;
canpushornot:
mov ecx,MAP[ebx-64]
cmp ecx,0
jbe cannotpush
cmp ecx,1
jbe cannotpush
cmp ecx,2
jbe canpush
cmp ecx,3
jbe canpush2
cmp ecx,5

cannotpush:
jmp upend

canpush:
mov MAP[ebx-64],1
mov MAP[ebx-32],4
mov MAP[ebx],2
sub userstand,32
add walkcount,1
mov edx,standontarget
cmp edx,1
jne jend1_1
mov MAP[ebx],3
mov standontarget,0
jend1_1:
jmp upend

canpush2:
mov MAP[ebx-64],5
mov MAP[ebx-32],4
mov MAP[ebx],2
sub endcount,1
sub userstand,32
add walkcount,1
mov edx,standontarget
cmp edx,1
jne jend1_2
mov MAP[ebx],3
mov standontarget,0
jend1_2:
jmp upend
;;;;;;;;;;;;;;;;;;;;;;;;;;;
canpushornot2:
mov ecx,MAP[ebx-64]
cmp ecx,0
jbe cannotpush_2
cmp ecx,1
jbe cannotpush_2
cmp ecx,2
jbe canpush_2
cmp ecx,3
jbe canpush2_2
cmp ecx,5
cannotpush_2:
jmp upend
canpush_2:
mov MAP[ebx-64],1
mov MAP[ebx-32],4
mov MAP[ebx],2
mov edx,standontarget
cmp edx,1
jne jend1_3
mov MAP[ebx],3
mov standontarget,1
sub userstand,32
add walkcount,1
jend1_3:
jmp upend
canpush2_2:
mov MAP[ebx-64],5
mov MAP[ebx-32],4
mov MAP[ebx],2
mov edx,standontarget
cmp edx,1
jne jend1_4
mov MAP[ebx],3
mov standontarget,1
sub userstand,32
add walkcount,1
jend1_4:
jmp upend
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
canwalk:
mov MAP[ebx-32],4
mov MAP[ebx],2
sub userstand,32
add walkcount,1
mov edx,standontarget
cmp edx,1
jne jend1_5
mov MAP[ebx],3
mov standontarget,0
jend1_5:
jmp upend
canwalk2:
mov MAP[ebx-32],4
mov MAP[ebx],3
mov standontarget,1
sub userstand,32
add walkcount,1
jmp upend
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
upend:
ret
doup ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
next:
call print

restart PROC
mov userstand,44
mov standontarget,0
mov endcount,3
mov walkcount,0
call Clrscr
mov ebx ,0
mov ecx ,8
L2:
push ecx
mov ecx,8
L1:
mov eax,map2[ebx]
mov map[ebx],eax
ok:
add ebx,4
dec ecx
cmp ecx,0
jne L1
call crlf
pop ecx
dec ecx
cmp ecx,0
jne L2
ret
restart ENDP


leaveend:
call Clrscr
mov edx,OFFSET str17
call WriteString
call crlf
mov edx,OFFSET str18
call WriteString
call crlf
mov edx,OFFSET str23
call WriteString
call crlf
mov edx,OFFSET str24
call WriteString
call crlf
call readint
cmp eax,1
je end_re
cmp eax,2
jbe end_end
end_re:
call restart
call print
end_end:
exit

endall:
call Clrscr
mov edx,OFFSET str15
call WriteString
call crlf
mov edx,OFFSET str16
call WriteString
call crlf
mov edx,OFFSET str20
call WriteString
mov eax,walkcount
call writedec
call crlf
exit

exit
main ENDP
END main