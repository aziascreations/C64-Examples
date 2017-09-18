1 rem Basic Memory Editor 1.0.1
1 rem - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1 rem This program "easily" lets you edit the memory's content
1 rem It's primary use is to enter put "asm" in the ram without a SD2IEC device
1 rem  as they are a bit expensive and I'm already resorting to cheap shit
1 rem  for diner...
1 rem - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1 rem See "BasicMemEd.md" for usage instructions.
1 rem - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1 rem Source for hex <-> dec converter: 
1 rem  http://www.lemon64.com/forum/viewtopic.php?t=8636
1 rem - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

1 rem Values:
1 rem  a  - Current address in decimal
1 rem  b  - Temp value for the decimal value to use with poke.
1 rem  c$ -  ???
1 rem  d  -  ???
1 rem  e  - Temp value for the "command" prefix
1 rem  h$ -  ???
1 rem  m  - Current mode (0-dec | 1-hex)

10 a = 53280
20 b = 0

30 print ""
40 print "current address:"+str$(a)
45 c$=""
50 input ""; c$
55 rem print len(c$)

60 if c$="" goto 120;
65 e$=left$(c$,1)
70 if e$="j" goto 250; rem jump somewhere
75 if e$="p" goto 300; rem peek
80 if e$="q" goto 400; rem quit
80 if e$="m" goto 400; rem change mode: hex <-> dec, the icon/prefix changes too
85 if e$="." goto 170; rem next(right pointing angle)
85 if e$="," goto 200; rem previous(left  pointing angle)


100 rem change value and go on
101 rem i couldn't use c$="0" after the then for some reason...
110 goto 140
120 c$="0"

140 b=val(c$)
150 poke a,b

170 a=a+1
180 rem c$=""
190 goto 30


200 rem go back
200 a=a-1
210 goto 30


250 rem jump somewhere else
250 a=val(right$(c$, len(c$)-1))
290 goto 30


300 rem peek
300 print ">"+str$(a)+" ="+str$(peek(a))

301 rem this block can be removed if you want to remove the peek@ command
302 rem not added yet

390 goto 30


400 rem exit to basic
400 end

1000 rem hex to dec 
1001 rem dec values must be 0 to 65535. hex values must be 4-digit strings, c13b 
1100 input "enter hex";h$ 
1200 d=0 
1210 for i=0 to 3 
1220 n=asc(mid$(h$,i+1,1))-48 
1230 if n<10 then d=d+n*(16^(3-i)) 
1240 if n>16 then d=d+(n-7)*(16^(3-i)) 
1250 next i 
1400 print "$"h$" hex ="d"dec"
