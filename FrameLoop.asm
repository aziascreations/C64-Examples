; FrameLoop.asm
; -====================================-
; Similar to the update()/render() functions
;  in LibGDX and Slick2D.
; --------------------------------------
; Requirements:
;  * 1 byte anywhere in memory (ZP_TIMER)
; --------------------------------------
; Source: Unable to find it back

; Notes:
;  * Using the !zone macro might help reduce the amount of labels.

*=$1000

ZP_TIMER = $02

main
	lda #$fb ; Wait for vertical retrace
main_wait_raster
	cmp $d012 ; Until it reaches 251th raster line ($fb)
	bne main_wait_raster ; Which is out of the inner screen area
	
	inc ZP_TIMER ; Increase timer and check if 50 1/50 sec passed
	lda ZP_TIMER
	cmp #$32
	bne main_skip1 ; If not, pass the color changing routine
	
	lda #$00 ; Reset timer
	sta ZP_TIMER
	
	; CODE START (Executed every second)
	;inc $D020 ; Changes the screenframe color
	; CODE END
	
main_skip1
	lda $d012 ; Make sure we reached
main_wait_next_raster
	cmp $d012 ; The next raster line so next time we
	beq main_wait_next_raster ; Should catch the same line next frame
	
	; CODE START (Executed every frame)
	;inc $D020 ; Changes the screenframe color
	; CODE END
	
	jmp main
