library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_to_seven_segment is
    port(ia, ib, ic, id, not_lt, not_rbi: in std_logic;
         oa, ob, oc, od, oe, o_f, og : out std_logic;
         not_bi_bro : inout std_logic );
end bcd_to_seven_segment;

--0.  |H H L L L L H| (not_lt and not_rbi and (not id) and (not ic) and (not ib) and (not ia) and not_bi_bro)
--1.  |H X L L L H H| (not_lt and (not id) and (not ic) and (not ib) and ia and not_bi_bro)
--2.  |H X L L H L H| (not_lt and (not id) and (not ic) and ib and (not ia) and not_bi_bro)
--3.  |H X L L H H H| (not_lt and (not id) and (not ic) and ib and ia and not_bi_bro) 
--4.  |H X L H L L H| (not_lt and (not id) and ic and (not ib) and (not ia) and not_bi_bro) 
--5.  |H X L H L H H| (not_lt and (not id) and ic and (not ib) and ia and not_bi_bro) 
--6.  |H X L H H L H| (not_lt and (not id) and ic and ib and (not ia) and not_bi_bro)
--7.  |H X L H H H H| (not_lt and (not id) and ic and ib and ia and not_bi_bro) 
--8.  |H X H L L L H| (not_lt and id and (not ic) and (not ib) and (not ia) and not_bi_bro) 
--9.  |H X H L L H H| (not_lt and id and (not ic) and (not ib) and ia and not_bi_bro)
--10. |H X H L H L H| (not_lt and id and (not ic) and ib and (not ia) and not_bi_bro)
--11. |H X H L H H H| (not_lt and id and (not ic) and ib and ia and not_bi_bro)
--12. |H X H H L L H| (not_lt and id and ic and (not ib) and (not ia) and not_bi_bro)
--13. |H X H H L H H| (not_lt and id and ic and (not ib) and ia and not_bi_bro)
--14. |H X H H H L H| (not_lt and id and ic and ib and (not ia) and not_bi_bro)  
--15. |H X H H H H H| (not_lt and id and ic and ib and ia and not_bi_bro)  
--BI  |X X X X X X L| (not not_bi_bro)
--RBI |H L L L L L L| (not_lt and (not not_rbi) and (not id), and (not ic) and (not ib) and (not ia) and (not not_bi_bro))     
--LT  |L X X X X X H| ((not not_lt) and not_bi_bro)

architecture logic_ops_and_parallel_assign of bcd_to_seven_segment is
begin
    oa <= ((not_lt and not_rbi and (not id) and (not ic) and (not ib) and (not ia) and not_bi_bro) or   --0
           (not_lt and (not id) and (not ic) and ib and not_bi_bro) or                                  --2,3
           (not_lt and (not id) and ic and (not ib) and ia and not_bi_bro) or                           --5
           (not_lt and (not id) and ic and ib and ia and not_bi_bro) or                                 --7
           (not_lt and id and (not ic) and (not ib) and not_bi_bro) or                                  --8,9
           (not_lt and id and ic and (not ib) and ia and not_bi_bro) or                                 --13
           ((not not_lt) and not_bi_bro));                                                              --LT
           
    ob <=  ((not_lt and not_rbi and (not id) and (not ic) and (not ib) and (not ia) and not_bi_bro) or  --0
            (not_lt and (not id) and (not ic) and (not ib) and ia and not_bi_bro)  or                   --1
            (not_lt and (not id) and (not ic) and ib and not_bi_bro) or                                 --2,3
            (not_lt and (not id) and ic and (not ib) and (not ia) and not_bi_bro) or                    --4
            (not_lt and (not id) and ic and ib and ia and not_bi_bro)  or                               --7
            (not_lt and id and (not ic) and (not ib) and not_bi_bro)  or                                --8,9
            (not_lt and id and ic and (not ib) and (not ia) and not_bi_bro) or                          --12
            ((not not_lt) and not_bi_bro) );                                                            --LT   
            
    oc <=  ((not_lt and not_rbi and (not id) and (not ic) and (not ib) and (not ia) and not_bi_bro) or   --0
            (not_lt and (not id) and (not ic) and (not ib) and ia and not_bi_bro) or                     --1
            (not_lt and (not id) and (not ic) and ib and ia and not_bi_bro) or                           --3
            (not_lt and (not id) and ic and not_bi_bro) or                                               --4,5,6,7
            (not_lt and id and (not ic) and (not ib) and not_bi_bro)  or                                 --8,9    
            (not_lt and id and (not ic) and ib and ia and not_bi_bro) or                                 --11
            ((not not_lt) and not_bi_bro) );                                                             --LT   
            
    od <=   ((not_lt and (not id) and (not ic) and (not ib) and ia and not_bi_bro) or                    --1
             (not_lt and (not id) and (not ic) and ib and not_bi_bro) or                                 --2,3
             (not_lt and (not id) and ic and (not ib) and ia and not_bi_bro) or                         --5
             (not_lt and (not id) and ic and ib and (not ia) and not_bi_bro) or                          --6
             (not_lt and id and (not ic) and (not ib) and (not ia) and not_bi_bro) or                   --8
             (not_lt and id and (not ic) and ib and not_bi_bro) or                                       --10,11
             (not_lt and id and ic and (not ib) and ia and not_bi_bro) or                                 --13,
             (not_lt and id and ic and ib and (not ia) and not_bi_bro) or                                --14
             ((not not_lt) and not_bi_bro));                                                             --LT
               
    oe <=   ((not_lt and not_rbi and (not id) and (not ic) and (not ib) and (not ia) and not_bi_bro) or    --0
             (not_lt and (not id) and (not ic) and ib and (not ia) and not_bi_bro) or                      --2
             (not_lt and (not id) and ic and ib and (not ia) and not_bi_bro) or                            --6
             (not_lt and id and (not ic) and (not ib) and (not ia) and not_bi_bro) or                       --8
             (not_lt and id and (not ic) and ib and (not ia) and not_bi_bro) or                            --10
             (not_lt and id and ic and ib and (not ia) and not_bi_bro) or                                   --14
             ((not not_lt) and not_bi_bro));
                                                                         --LT
    o_f <= ((not_lt and (not id) and (not ic) and (not ib) and ia and not_bi_bro) or                     --1
           (not_lt and (not id) and ic and (not ib) and not_bi_bro) or                                  --4,5
           (not_lt and (not id) and ic and ib and (not ia) and not_bi_bro) or                           --6
           (not_lt and id and (not ic) and (not ib) and not_bi_bro)  or                                 --8,9
           (not_lt and id and ic and (not ib) and not_bi_bro) or                                        --12,13
           (not_lt and id and ic and ib and (not ia) and not_bi_bro) or                                 --14
           ((not not_lt) and not_bi_bro));                                                              --LT
            
    og <= ((not_lt and (not id) and (not ic) and ib and not_bi_bro) or                                  --2,3
           (not_lt and (not id) and ic and (not ib) and not_bi_bro) or                                  --4,5
           (not_lt and (not id) and ic and ib and (not ia) and not_bi_bro) or                           --6
           (not_lt and id and (not ic) and not_bi_bro) or                                               --8,9,10,11
           (not_lt and id and ic and (not ib) and not_bi_bro) or                                        --12,13
           (not_lt and id and ic and ib and (not ia) and not_bi_bro) or                                 --14
           ((not not_lt) and not_bi_bro));                                                              --LT
            
end logic_ops_and_parallel_assign;
 



