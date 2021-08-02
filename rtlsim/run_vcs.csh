rm test.dump


#vcs +v2k -f test_moa_8x8p2_rt8_mfa42.f -l vcs.log -o simv +define+DUMP
#vcs +v2k -f test_moa_8x8p2_rt8_fa42.f -l vcs.log -o simv +define+DUMP
#vcs +v2k -f test_moa_8x8p1_tree.f -l vcs.log -o simv +define+DUMP
#vcs +v2k -f test_amoa_8x8p2_rt8_apxe4.f -l vcs.log -o simv +define+DUMP
#vcs +v2k -f test_amoa_8x8p2_rt8_apx2.f -l vcs.log -o simv +define+DUMP
#vcs +v2k -f test_amoa_8x8p1_rt8_apx2.f -l vcs.log -o simv +define+DUMP


./simv -l simv.log
