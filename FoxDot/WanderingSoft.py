
rphrase1 = P[1,1]
# 2
rphrase2 = P[2,1].shuffle()
# 3
rphrase3 = P[3,1].shuffle()
# rest
rphrase4 = P[1,1]

p3 >> soft(0, fmod=linvar([40,200], [rphrase1 | rphrase2 | rphrase3 | rphrase4]), dur=[rphrase1 | rphrase2 | rphrase3 | rphrase4], sus=5, amp=0.3)
