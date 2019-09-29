    movdqu xmm4, xmm3
    movdqu xmm5, xmm3

    movlps xmm1, mask_g
    movhps xmm1, mask_g
    pand xmm4, xmm1

    MOVLPS xmm1, mask_b
    MOVHPS xmm1, mask_b
    pand xmm5, xmm1

    movdqu xmm1, xmm0
    movdqu xmm2, xmm0
    psrlw xmm0, 5

    movlps xmm6, mask_g
    movhps xmm6, mask_g
    pand xmm1, xmm6
    movlps xmm6, mask_b
    movhps xmm6, mask_b
    pand xmm2, xmm6

    movdqu xmm6, xmm3
    psrlw xmm3, 5

    psubw xmm0, xmm3
    psubw xmm1, xmm4
    pmullw xmm0, xmm7
    psubw xmm2, xmm5
    pmullw xmm1, xmm7
    paddw xmm0, xmm6
    pmullw xmm2, xmm7

    psrlw xmm1, 5
    psrlw xmm2, 5
    paddw xmm1, xmm4
    paddw xmm2, xmm5

    movlps xmm6, mask_r
    movhps xmm6, mask_r
    pand xmm0, xmm6
    movlps xmm6, mask_g
    movhps xmm6, mask_g
    pand xmm1, xmm6
    movlps xmm6, mask_b
    movhps xmm6, mask_b
    pand xmm2, xmm6

    por xmm0, xmm1
    por xmm0, xmm2