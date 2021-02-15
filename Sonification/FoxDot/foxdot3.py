p = FileSynthDef("plant")
p.add()
p2 >> p(0, fmod=linvar([-200,3000], [4,100]), dur=30, sus=30, amp=0.4, pan=linvar([-0.5,0.5],8))
