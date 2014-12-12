##################################################
# test11
#

    #-----------------------------------------
    # text section
    #
    .text
    .align 4

    # entry point and pre-defined functions
    .global main
    .extern Input
    .extern Output

    # scope primefactor
primefactor:
    pushl   %ebp
    movl    %esp, %ebp
    pushl   %ebx
    pushl   %esi
    pushl   %edi
    subl    $20, %esp

    movl    8(%ebp), %eax               #  0:     if     n < 1 goto 1_if_true
    cmpl    $1, %eax
    jl      l_primefactor_1_if_true
    jmp     l_primefactor_2_if_false    #  1:     goto   2_if_false
l_primefactor_1_if_true:
    jmp     l_primefactor_exit          #  3:     return 
    jmp     l_primefactor_0             #  4:     goto   0
l_primefactor_2_if_false:
    movl    8(%ebp), %eax               #  6:     if     n = 1 goto 6_if_true
    cmpl    $1, %eax
    je      l_primefactor_6_if_true
    jmp     l_primefactor_7_if_false    #  7:     goto   7_if_false
l_primefactor_6_if_true:
    pushl   $1                          #  9:     param  0 <- 1
    call    Output                      # 10:     call   Output
    addl    $4, %esp
    jmp     l_primefactor_5_else_next   # 11:     goto   5_else_next
l_primefactor_7_if_false:
l_primefactor_11_while_cond:
    movl    8(%ebp), %eax               # 14:     if     n > 1 goto 12_while_body
    cmpl    $1, %eax
    jg      l_primefactor_12_while_body
    jmp     l_primefactor_10_else_next  # 15:     goto   10_else_next
l_primefactor_12_while_body:
    movl    $2, %eax                    # 17:     assign f <- 2
    movl    %eax, -4(%ebp)
l_primefactor_16_while_cond:
    movl    -4(%ebp), %eax              # 19:     if     f <= n goto 17_while_body
    cmpl    8(%ebp), %eax
    jle     l_primefactor_17_while_body
    jmp     l_primefactor_15_while_next # 20:     goto   15_while_next
l_primefactor_17_while_body:
    movl    8(%ebp), %eax               # 22:     div    t0 <- n, f
    cdq
    movl    -4(%ebp), %ebx
    idivl   %ebx
    movl    %eax, -8(%ebp)
    movl    -8(%ebp), %eax              # 23:     mul    t1 <- t0, f
    movl    -4(%ebp), %ebx
    imull   %ebx
    movl    %eax, -12(%ebp)
    movl    -12(%ebp), %eax             # 24:     if     t1 = n goto 20_if_true
    cmpl    8(%ebp), %eax
    je      l_primefactor_20_if_true
    jmp     l_primefactor_21_if_false   # 25:     goto   21_if_false
l_primefactor_20_if_true:
    pushl   -4(%ebp)                    # 27:     param  0 <- f
    call    Output                      # 28:     call   Output
    addl    $4, %esp
    movl    8(%ebp), %eax               # 29:     div    t2 <- n, f
    cdq
    movl    -4(%ebp), %ebx
    idivl   %ebx
    movl    %eax, -16(%ebp)
    movl    -16(%ebp), %eax             # 30:     assign n <- t2
    movl    %eax, 8(%ebp)
    jmp     l_primefactor_19_while_next # 31:     goto   19_while_next
l_primefactor_21_if_false:
    movl    -4(%ebp), %eax              # 33:     add    t3 <- f, 1
    addl    $1, %eax
    movl    %eax, -20(%ebp)
    movl    -20(%ebp), %eax             # 34:     assign f <- t3
    movl    %eax, -4(%ebp)
l_primefactor_19_while_next:
    jmp     l_primefactor_16_while_cond # 36:     goto   16_while_cond
l_primefactor_15_while_next:
    jmp     l_primefactor_11_while_cond # 38:     goto   11_while_cond
l_primefactor_10_else_next:
l_primefactor_5_else_next:
l_primefactor_0:
l_primefactor_exit:
    addl    $20, %esp
    popl    %edi
    popl    %esi
    popl    %ebx
    popl    %ebp
    ret

    # scope test11
main:
    pushl   %ebp
    movl    %esp, %ebp
    pushl   %ebx
    pushl   %esi
    pushl   %edi
    subl    $4, %esp

    call    Input                       #  0:     call   t0 <- Input
    addl    $0, %esp
    movl    %eax, -4(%ebp)
    pushl   -4(%ebp)                    #  1:     param  0 <- t0
    call    primefactor                 #  2:     call   primefactor
    addl    $4, %esp
l_test11_exit:
    addl    $4, %esp
    popl    %edi
    popl    %esi
    popl    %ebx
    popl    %ebp
    ret

    # end of text section
    #-----------------------------------------

    #-----------------------------------------
    # global data section
    #
    .data
    .align 4

    # scope: test11

    # scope: primefactor

    # end of global data section
    #-----------------------------------------

    .end
##################################################
