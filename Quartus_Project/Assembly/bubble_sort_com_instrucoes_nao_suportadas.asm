        .data
vec:    .word 700, 82, 801, 129, 138, 290, 549, 42, 135, 165, 927, 0, 566, 832, 338, 212, 385, 687, 930, 72, 312, 887, 971, 
              864, 655,185,845,437,1021,714,14,754,392,598,52,493,997,575,687,1018,104,189,672,730,627,857,66,874,323,331,
              65,427,135,935,864,573,609,589,669,829,654,435,45,726
vecsz:  .word 64

        .text
main:   la $a0, vec
        lw $a1, vecsz
        j bubble

bubble: li $s0, 0               # (s0) i = 0

eloop:  bge $s0, $a1, end       # break if i >= vecsz
        li  $s1, 0

iloop:  bge $s1, $a1 endiloop   # break if j >= vecsz (vecsz >= j)

        sll $t1, $s0, 2         # t1 = i * 4 (para indexar o vetor)
        sll $t2, $s1, 2         # t2 = j * 4 (para indexar o vetor)

        add $t1, $a0, $t1       # endereço de vec[i] => t1 = vec + i * 4
        add $t2, $a0, $t2       # endereço de vec[j] => t2 = vec + j * 4

        lw $t3, ($t1)           # t3 = vec[i]
        lw $t4, ($t2)           # t4 = vec[j]

        blt $t3, $t4, swap

        addi $s1, $s1, 1 # j++
        j iloop

swap:
        sw $t3, ($t2)           # vec[j] = vec[i]
        sw $t4, ($t1)           # vec[i] = vec[j]

endiloop:
        addi $s0, $s0, 1        # i++
        j eloop
end:    
        li $v0, 10
        syscall