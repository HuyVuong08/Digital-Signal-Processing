// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008-2009 - INRIA - Michael Baudin
// Copyright (C) 2009-2011 - DIGITEO - Michael Baudin
// Copyright (C) 2016 - Samuel GOUGEON
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
//
// Check the bitxor function.
//
icodes = [0 1 2 4 8 11 12 14 18];

// Tests 1 : 
//  - all inttypes are accepted
//  - Rows, columns, and matrices are accepted
// =============================================================================

// test 1.1
A = [0 1 0 1];
B = [0 0 1 1];
C = [0 1 1 0];
for it = icodes
    a = iconvert(A, it);
    b = iconvert(B, it);
    c = iconvert(C, it);
    assert_checkequal(bitxor(a, b), c);
    assert_checkequal(typeof(c), typeof(a));
end

// test 1.2
A = [0 1 ; 0 1];
B = [0 0 ; 1 1];
C = [0 1 ; 1 0];
for it = icodes
    a = iconvert(A, it);
    b = iconvert(B, it);
    c = iconvert(C, it);
    assert_checkequal(bitxor(a, b), c);
    assert_checkequal(typeof(c), typeof(a));
end

// test 1.3
A = [0 ; 1 ; 0 ; 1];
B = [0 ; 0 ; 1 ; 1];
C = [0 ; 1 ; 1 ; 0];
for it = icodes
    a = iconvert(A, it);
    b = iconvert(B, it);
    c = iconvert(C, it);
    assert_checkequal(bitxor(a, b), c);
    assert_checkequal(typeof(c), typeof(a));
end


// Tests 2 : mismatching input types must all be accepted
// =============================================================================
A = [0 1 0 1];
B = [0 0 1 1];
for i = 2:length(icodes)-1
    for j = i+1:length(icodes)
        a = iconvert(A,icodes(i));
        b = iconvert(B,icodes(j));
        assert_checktrue(execstr("bitxor(a, b);","errcatch")==0);
    end
end


// Tests 3 : size of output
// =============================================================================
A = floor(100 * rand(100,20));
B = floor(100 * rand(100,20));
C = floor(100 * rand(1,1));
for it = icodes
    a = iconvert(A, it);
    b = iconvert(B, it);
    c = iconvert(C, it);
    d = bitxor(a,b);
    assert_checkequal(size(a), size(d));
    d = bitxor(a,c);
    assert_checkequal(size(a), size(d));
    d = bitxor(c,a);
    assert_checkequal(size(a), size(d));
end

// Tests 4 : decimal numbers > 2^52  are  accepted
// =============================================================================
for i = 301:400
    a = sum(2 .^(i- (0:10:60)));
    b = sum(2 .^(i- (5:5:40)));
    c = sum(2 .^(i-[0 5 15 25 35 50 60]));
    assert_checkequal(bitxor(a,b), c);
end

// Test 5
// =============================================================================
A = [ ..
    299.    258.    314.    359.    616.    152.    834.    68.     175.    734.    749.    976.    261.    214.    94.     217.    754.    245.    693.    557.  ; ..
    409.    783.    234.    932.    811.    552.    272.    375.    551.    373.    477.    784.    736.    15.     712.    419.    204.    949.    12.     682.  ; ..
    261.    273.    627.    652.    209.    280.    855.    221.    243.    720.    430.    936.    767.    48.     191.    731.    896.    18.     372.    527.  ; ..
    646.    848.    629.    446.    624.    194.    89.     948.    217.    786.    873.    374.    400.    215.    302.    766.    804.    442.    285.    476.  ; ..
    654.    127.    42.     559.    679.    811.    872.    769.    604.    453.    47.     220.    447.    333.    385.    915.    418.    270.    85.     583.  ; ..
    560.    432.    600.    158.    280.    327.    874.    625.    689.    178.    600.    19.     444.    423.    303.    128.    653.    420.    394.    99.   ; ..
    161.    739.    408.    134.    775.    955.    86.     133.    207.    589.    276.    644.    312.    819.    190.    996.    999.    969.    776.    353.  ; ..
    765.    53.     958.    530.    658.    567.    665.    447.    672.    549.    132.    651.    4.      114.    379.    941.    971.    713.    490.    395.  ; ..
    697.    613.    118.    798.    627.    430.    475.    538.    286.    324.    750.    550.    701.    298.    567.    106.    189.    483.    25.     793.  ; ..
    89.     809.    27.     587.    151.    393.    839.    811.    452.    286.    304.    23.     501.    770.    658.    467.    482.    771.    246.    464.  ; ..
    198.    192.    364.    532.    417.    391.    730.    442.    274.    992.    529.    85.     786.    984.    805.    23.     867.    843.    185.    994.  ; ..
    259.    541.    18.     303.    656.    875.    990.    0.      347.    357.    376.    801.    735.    490.    643.    878.    319.    587.    287.    152.  ; ..
    509.    415.    752.    82.     540.    526.    638.    658.    966.    193.    488.    221.    473.    160.    131.    80.     627.    399.    464.    959.  ; ..
    167.    286.    292.    201.    715.    985.    230.    174.    792.    303.    914.    245.    945.    427.    225.    920.    110.    401.    873.    999.  ; ..
    340.    511.    379.    221.    206.    132.    488.    450.    888.    4.      664.    41.     652.    387.    620.    998.    2.      873.    998.    347.  ; ..
    895.    767.    977.    562.    323.    323.    165.    765.    843.    849.    546.    963.    938.    980.    650.    195.    653.    131.    503.    220.  ; ..
    667.    378.    74.     594.    248.    601.    77.     723.    984.    815.    6.      21.     240.    909.    668.    987.    357.    587.    33.     127.  ; ..
    25.     934.    150.    336.    74.     154.    443.    790.    951.    998.    174.    670.    292.    482.    672.    424.    340.    202.    314.    513.  ; ..
    31.     488.    191.    944.    278.    751.    925.    113.    495.    689.    377.    76.     653.    665.    141.    868.    811.    725.    582.    886.  ; ..
    427.    998.    456.    225.    892.    31.     275.    852.    313.    652.    564.    34.     993.    246.    407.    45.     764.    445.    354.    343.  ; ..
    108.    593.    580.    61.     718.    140.    942.    652.    683.    265.    647.    444.    449.    771.    627.    649.    29.     372.    573.    579.  ; ..
    767.    892.    475.    334.    514.    573.    668.    396.    876.    24.     506.    323.    509.    899.    448.    58.     395.    648.    715.    774.  ; ..
    373.    995.    364.    956.    981.    351.    157.    269.    143.    430.    484.    356.    377.    915.    403.    238.    629.    11.     91.     145.  ; ..
    151.    481.    266.    111.    930.    313.    117.    979.    997.    273.    556.    689.    92.     986.    587.    992.    953.    294.    152.    792.  ; ..
    721.    77.     478.    875.    541.    562.    820.    835.    301.    650.    504.    355.    300.    207.    115.    255.    500.    605.    84.     53.   ; ..
    539.    68.     214.    955.    98.     536.    11.     867.    752.    733.    815.    298.    978.    631.    768.    114.    800.    714.    995.    136.  ; ..
    145.    567.    792.    271.    225.    858.    442.    355.    681.    444.    94.     318.    786.    911.    234.    507.    84.     713.    310.    822.  ; ..
    745.    599.    365.    664.    288.    836.    28.     930.    794.    749.    46.     83.     931.    575.    589.    469.    336.    233.    728.    53.   ; ..
    257.    106.    548.    68.     115.    204.    609.    511.    922.    248.    823.    262.    976.    691.    320.    29.     835.    587.    676.    306.  ; ..
    770.    381.    844.    771.    219.    382.    9.      531.    351.    276.    557.    505.    146.    903.    742.    790.    853.    837.    521.    654.  ; ..
    997.    259.    58.     886.    395.    969.    997.    454.    871.    307.    393.    61.     41.     727.    498.    93.     134.    389.    864.    331.  ; ..
    845.    6.      504.    575.    678.    609.    267.    800.    331.    11.     584.    214.    770.    298.    903.    748.    395.    210.    46.     920.  ; ..
    646.    810.    600.    729.    615.    937.    384.    948.    593.    645.    756.    781.    405.    875.    670.    467.    226.    760.    617.    627.  ; ..
    720.    266.    563.    265.    318.    59.     756.    76.     436.    716.    295.    882.    114.    379.    853.    192.    874.    640.    22.     402.  ; ..
    674.    124.    517.    290.    650.    84.     915.    23.     282.    854.    893.    784.    485.    87.     175.    82.     635.    489.    632.    163.  ; ..
    354.    187.    518.    781.    840.    296.    931.    485.    497.    427.    773.    403.    830.    635.    764.    916.    747.    97.     968.    466.  ; ..
    327.    112.    124.    957.    342.    503.    810.    555.    205.    975.    61.     382.    163.    225.    300.    234.    409.    241.    82.     382.  ; ..
    23.     664.    936.    844.    491.    38.     344.    243.    922.    383.    447.    270.    844.    446.    513.    898.    986.    644.    451.    205.  ; ..
    593.    145.    411.    132.    974.    78.     500.    146.    292.    278.    476.    121.    102.    310.    625.    147.    762.    635.    721.    900.  ; ..
    924.    430.    751.    807.    771.    799.    864.    389.    914.    513.    174.    867.    514.    588.    543.    816.    603.    129.    643.    844.  ; ..
    672.    614.    228.    945.    547.    181.    239.    481.    205.    849.    836.    22.     590.    727.    936.    320.    684.    801.    680.    194.  ; ..
    484.    216.    206.    500.    208.    312.    864.    40.     21.     168.    461.    674.    244.    314.    918.    768.    617.    671.    15.     514.  ; ..
    641.    968.    900.    371.    797.    247.    871.    646.    56.     797.    91.     714.    323.    178.    865.    88.     148.    194.    832.    203.  ; ..
    594.    663.    567.    914.    981.    590.    538.    815.    312.    252.    56.     856.    392.    491.    864.    427.    873.    710.    485.    412.  ; ..
    106.    519.    458.    287.    327.    848.    45.     827.    772.    79.     884.    754.    732.    752.    784.    546.    129.    379.    373.    843.  ; ..
    808.    867.    999.    316.    852.    684.    656.    680.    90.     994.    127.    139.    812.    166.    914.    255.    452.    178.    97.     639.  ; ..
    516.    287.    322.    770.    554.    275.    196.    909.    769.    697.    440.    880.    499.    574.    216.    824.    72.     10.     365.    652.  ; ..
    61.     143.    418.    27.     254.    767.    369.    13.     275.    17.     448.    319.    445.    304.    901.    638.    399.    572.    219.    129.  ; ..
    16.     187.    588.    110.    674.    63.     317.    50.     515.    773.    802.    897.    196.    684.    519.    7.      101.    734.    853.    491.  ; ..
    509.    619.    630.    558.    308.    73.     52.     977.    395.    177.    243.    944.    88.     72.     93.     901.    64.     222.    285.    54.   ; ..
    469.    217.    542.    54.     17.     567.    365.    760.    83.     137.    493.    687.    904.    240.    157.    193.    547.    620.    109.    749.  ; ..
    528.    445.    451.    915.    864.    283.    429.    348.    335.    544.    478.    559.    522.    828.    832.    910.    283.    731.    943.    703.  ; ..
    33.     408.    985.    108.    295.    241.    496.    641.    309.    911.    395.    874.    501.    390.    967.    563.    616.    310.    10.     313.  ; ..
    711.    636.    740.    559.    312.    44.     314.    408.    519.    888.    365.    351.    607.    884.    846.    262.    928.    288.    226.    2.    ; ..
    790.    497.    722.    600.    728.    794.    480.    237.    9.      518.    190.    325.    598.    489.    735.    399.    640.    799.    866.    952.  ; ..
    623.    739.    101.    588.    735.    343.    47.     566.    868.    947.    452.    867.    477.    829.    912.    768.    765.    234.    706.    451.  ; ..
    799.    0.      631.    93.     262.    521.    49.     703.    353.    992.    488.    304.    41.     136.    576.    949.    704.    932.    537.    135.  ; ..
    42.     428.    478.    116.    784.    302.    998.    566.    623.    448.    840.    604.    598.    832.    580.    972.    41.     685.    524.    108.  ; ..
    867.    878.    372.    991.    411.    984.    990.    602.    153.    795.    155.    70.     1.      222.    367.    442.    888.    792.    833.    68.   ; ..
    345.    809.    666.    369.    506.    415.    235.    611.    776.    218.    663.    588.    976.    542.    146.    608.    644.    148.    533.    351.  ; ..
    798.    819.    405.    135.    124.    424.    764.    492.    51.     832.    761.    445.    235.    42.     260.    618.    337.    401.    314.    174.  ; ..
    372.    326.    944.    619.    861.    347.    448.    217.    286.    661.    868.    427.    124.    42.     828.    155.    868.    748.    405.    229.  ; ..
    186.    525.    12.     276.    670.    18.     807.    441.    635.    553.    781.    722.    521.    95.     383.    390.    131.    65.     116.    862.  ; ..
    505.    795.    299.    636.    965.    834.    435.    979.    413.    199.    368.    584.    406.    502.    13.     781.    682.    763.    405.    244.  ; ..
    342.    772.    709.    901.    545.    890.    787.    525.    795.    131.    671.    576.    961.    666.    730.    899.    10.     608.    624.    470.  ; ..
    582.    973.    114.    632.    856.    17.     656.    690.    136.    919.    778.    705.    895.    690.    463.    929.    841.    544.    359.    254.  ; ..
    92.     791.    288.    280.    840.    859.    269.    187.    524.    200.    522.    841.    71.     167.    158.    826.    620.    915.    185.    211.  ; ..
    639.    109.    423.    678.    825.    469.    543.    68.     732.    494.    936.    579.    893.    204.    225.    431.    993.    491.    128.    657.  ; ..
    328.    929.    42.     285.    76.     791.    965.    359.    266.    880.    69.     423.    880.    811.    885.    567.    589.    240.    823.    105.  ; ..
    ];

B = [ ..
    511.    299.    529.    766.    739.    39.     125.    996.    368.    699.    914.    155.    428.    455.    616.    283.    424.    803.    615.    922.  ; ..
    403.    223.    453.    985.    260.    337.    35.     632.    64.     113.    551.    688.    331.    580.    463.    859.    689.    839.    780.    362.  ; ..
    827.    66.     978.    614.    218.    678.    161.    20.     560.    768.    596.    890.    553.    53.     853.    856.    480.    429.    772.    419.  ; ..
    589.    677.    202.    42.     319.    256.    772.    61.     840.    507.    931.    68.     147.    638.    708.    406.    269.    599.    98.     105.  ; ..
    298.    994.    102.    50.     811.    524.    521.    618.    997.    538.    934.    439.    592.    754.    812.    889.    399.    300.    884.    943.  ; ..
    750.    321.    48.     310.    370.    948.    80.     245.    226.    670.    818.    373.    979.    272.    977.    20.     120.    839.    539.    242.  ; ..
    605.    885.    102.    86.     269.    308.    723.    151.    307.    253.    61.     463.    588.    379.    777.    270.    910.    368.    147.    532.  ; ..
    889.    20.     483.    246.    947.    795.    186.    755.    81.     768.    113.    88.     853.    511.    339.    190.    319.    312.    374.    662.  ; ..
    724.    518.    73.     894.    321.    922.    883.    758.    406.    470.    227.    179.    192.    567.    854.    768.    53.     626.    860.    333.  ; ..
    122.    726.    397.    287.    566.    459.    294.    34.     257.    61.     855.    504.    806.    761.    605.    73.     869.    799.    550.    568.  ; ..
    702.    915.    256.    290.    123.    780.    939.    129.    985.    639.    863.    33.     535.    680.    742.    203.    797.    457.    750.    890.  ; ..
    562.    646.    707.    169.    769.    226.    84.     970.    964.    322.    252.    971.    760.    240.    574.    836.    239.    469.    818.    351.  ; ..
    250.    477.    828.    368.    794.    940.    381.    978.    719.    681.    475.    998.    863.    319.    31.     551.    822.    570.    913.    43.   ; ..
    485.    2.      265.    453.    408.    613.    387.    298.    231.    101.    675.    471.    193.    689.    892.    701.    297.    835.    0.      390.  ; ..
    59.     763.    740.    509.    933.    443.    469.    678.    101.    757.    858.    193.    778.    385.    10.     915.    297.    213.    829.    602.  ; ..
    464.    368.    504.    384.    164.    290.    303.    505.    725.    900.    670.    738.    185.    477.    373.    457.    513.    458.    56.     130.  ; ..
    27.     748.    605.    327.    664.    860.    805.    229.    783.    334.    335.    607.    373.    898.    564.    739.    274.    976.    896.    785.  ; ..
    822.    203.    393.    286.    820.    856.    1.      856.    651.    735.    897.    974.    737.    489.    385.    907.    483.    719.    192.    307.  ; ..
    485.    963.    211.    267.    26.     905.    63.     266.    993.    875.    65.     625.    529.    379.    420.    953.    737.    473.    975.    100.  ; ..
    862.    5.      297.    449.    803.    679.    343.    818.    257.    94.     694.    717.    922.    623.    515.    97.     404.    265.    816.    470.  ; ..
    382.    72.     303.    20.     784.    533.    143.    609.    203.    458.    301.    204.    678.    959.    238.    267.    689.    937.    49.     233.  ; ..
    715.    389.    169.    756.    727.    788.    186.    267.    643.    929.    527.    430.    497.    189.    221.    100.    27.     120.    432.    738.  ; ..
    647.    819.    212.    895.    358.    713.    298.    260.    240.    712.    118.    350.    699.    857.    60.     981.    446.    584.    499.    55.   ; ..
    192.    133.    0.      22.     166.    403.    566.    520.    858.    848.    849.    904.    747.    928.    279.    444.    687.    694.    600.    943.  ; ..
    897.    99.     69.     333.    903.    197.    327.    123.    715.    40.     90.     269.    693.    775.    938.    811.    732.    926.    177.    356.  ; ..
    663.    854.    477.    8.      304.    187.    928.    77.     632.    990.    670.    266.    601.    550.    507.    947.    82.     46.     599.    822.  ; ..
    767.    541.    101.    94.     47.     704.    96.     452.    535.    500.    868.    705.    610.    593.    450.    716.    799.    385.    707.    773.  ; ..
    486.    204.    314.    298.    575.    404.    854.    43.     389.    61.     382.    374.    181.    588.    339.    497.    546.    456.    442.    621.  ; ..
    686.    965.    283.    749.    721.    203.    728.    552.    515.    403.    165.    819.    396.    768.    694.    945.    827.    974.    731.    983.  ; ..
    854.    259.    424.    411.    547.    831.    435.    292.    221.    576.    864.    325.    925.    746.    221.    207.    349.    701.    92.     182.  ; ..
    371.    538.    721.    326.    337.    877.    355.    779.    357.    946.    475.    910.    872.    490.    596.    836.    813.    842.    410.    945.  ; ..
    918.    17.     81.     719.    235.    392.    203.    474.    305.    289.    602.    729.    20.     814.    342.    123.    84.     105.    235.    261.  ; ..
    956.    2.      998.    638.    592.    246.    503.    6.      610.    455.    484.    746.    333.    287.    330.    752.    308.    466.    841.    172.  ; ..
    597.    418.    188.    671.    395.    833.    409.    798.    488.    80.     286.    95.     78.     307.    841.    263.    226.    487.    391.    266.  ; ..
    943.    194.    655.    391.    827.    136.    535.    617.    290.    430.    832.    561.    294.    742.    751.    180.    134.    665.    523.    49.   ; ..
    435.    988.    665.    431.    236.    357.    227.    998.    522.    999.    994.    41.     567.    335.    145.    994.    426.    281.    578.    727.  ; ..
    454.    671.    465.    947.    500.    200.    393.    272.    820.    927.    60.     304.    130.    737.    296.    959.    963.    675.    933.    508.  ; ..
    154.    937.    681.    253.    105.    707.    15.     962.    420.    629.    526.    982.    385.    549.    427.    574.    858.    359.    943.    479.  ; ..
    808.    984.    404.    12.     327.    736.    555.    452.    336.    292.    668.    896.    153.    449.    229.    104.    775.    774.    90.     296.  ; ..
    962.    209.    832.    459.    994.    745.    28.     950.    601.    367.    586.    261.    58.     299.    169.    864.    889.    232.    629.    637.  ; ..
    883.    315.    811.    905.    368.    144.    43.     535.    483.    168.    443.    357.    109.    649.    800.    214.    39.     604.    4.      892.  ; ..
    175.    421.    260.    805.    124.    888.    774.    110.    714.    405.    157.    351.    115.    199.    367.    774.    293.    256.    594.    827.  ; ..
    104.    260.    341.    802.    159.    786.    825.    301.    53.     544.    174.    173.    673.    46.     114.    316.    427.    921.    580.    432.  ; ..
    119.    747.    98.     71.     90.     751.    410.    912.    209.    57.     530.    564.    243.    59.     852.    657.    177.    88.     918.    691.  ; ..
    891.    823.    471.    824.    324.    670.    468.    578.    494.    607.    697.    483.    595.    796.    808.    577.    328.    247.    146.    938.  ; ..
    452.    490.    205.    820.    149.    920.    94.     123.    638.    518.    822.    542.    656.    441.    522.    616.    452.    830.    280.    304.  ; ..
    185.    569.    779.    424.    272.    647.    780.    720.    883.    851.    490.    15.     59.     371.    211.    57.     705.    356.    796.    241.  ; ..
    955.    164.    16.     293.    993.    706.    906.    848.    326.    978.    373.    603.    582.    787.    652.    334.    70.     847.    601.    660.  ; ..
    715.    801.    480.    591.    995.    83.     734.    54.     749.    472.    989.    508.    8.      926.    31.     839.    407.    850.    431.    561.  ; ..
    234.    295.    173.    250.    613.    34.     655.    847.    202.    132.    50.     594.    856.    109.    972.    501.    165.    188.    204.    718.  ; ..
    292.    821.    997.    318.    0.      567.    741.    726.    493.    134.    906.    42.     925.    724.    81.     949.    162.    844.    251.    120.  ; ..
    633.    724.    357.    46.     614.    24.     582.    735.    174.    473.    972.    125.    39.     411.    596.    9.      589.    550.    116.    488.  ; ..
    92.     342.    197.    953.    436.    566.    460.    911.    597.    853.    361.    591.    343.    234.    469.    746.    637.    277.    731.    854.  ; ..
    787.    779.    363.    286.    312.    329.    376.    562.    334.    81.     527.    887.    261.    224.    87.     798.    950.    864.    219.    192.  ; ..
    834.    186.    570.    810.    805.    409.    454.    510.    480.    625.    113.    671.    465.    762.    506.    374.    419.    893.    334.    529.  ; ..
    558.    249.    673.    876.    178.    677.    91.     658.    323.    915.    545.    943.    937.    823.    808.    278.    89.     607.    711.    492.  ; ..
    509.    987.    573.    176.    783.    917.    233.    582.    392.    717.    792.    428.    113.    140.    624.    736.    11.     67.     577.    842.  ; ..
    453.    376.    589.    29.     381.    286.    172.    202.    294.    688.    28.     421.    452.    616.    145.    681.    787.    744.    617.    54.   ; ..
    142.    22.     846.    976.    861.    794.    156.    246.    293.    731.    348.    386.    203.    569.    215.    708.    257.    537.    136.    700.  ; ..
    909.    106.    203.    747.    369.    674.    940.    848.    962.    167.    805.    705.    843.    839.    15.     240.    259.    751.    818.    126.  ; ..
    400.    979.    549.    186.    223.    948.    530.    17.     735.    953.    144.    689.    370.    489.    968.    264.    446.    277.    651.    214.  ; ..
    897.    393.    3.      268.    357.    824.    225.    565.    30.     994.    753.    955.    212.    842.    217.    695.    590.    160.    75.     335.  ; ..
    9.      721.    909.    77.     816.    528.    495.    873.    701.    535.    785.    355.    678.    752.    243.    277.    4.      521.    258.    415.  ; ..
    45.     277.    580.    861.    230.    496.    445.    615.    784.    899.    656.    454.    942.    873.    491.    168.    495.    580.    728.    263.  ; ..
    386.    391.    673.    771.    380.    139.    235.    165.    508.    47.     79.     271.    888.    751.    761.    338.    610.    708.    2.      622.  ; ..
    786.    772.    664.    87.     527.    614.    991.    222.    717.    137.    252.    718.    743.    110.    527.    771.    597.    876.    940.    592.  ; ..
    892.    775.    882.    934.    567.    633.    174.    171.    660.    302.    9.      716.    895.    897.    730.    351.    78.     212.    452.    223.  ; ..
    746.    994.    326.    974.    772.    977.    344.    659.    469.    201.    423.    427.    889.    801.    395.    300.    616.    158.    562.    488.  ; ..
    134.    234.    546.    949.    699.    645.    354.    988.    286.    489.    546.    458.    93.     320.    808.    322.    882.    602.    577.    641.  ; ..
    ];

 C  = [
   212.    41.     811.   921.   139.   191.    831.    928.    479.    101.    383.    843.    169.    273.    566.    450.   858.   982.    210.    439. 
   10.     976.    303.   125.   559.   889.    307.    783.    615.    260.    1018.   416.    939.    587.    775.    760.   637.   242.    768.    960. 
   574.    339.    417.   234.   11.    958.    1014.   201.    707.    464.    1018.   210.    214.    5.      1002.   387.   608.   447.    624.    940. 
   203.    501.    703.   404.   847.   450.    861.    905.    913.    745.    202.    306.    259.    681.    1002.   872.   553.   1005.   383.    437. 
   932.    925.    76.    541.   396.   295.    353.    363.    441.    991.    905.    363.    1007.   959.    685.    234.   45.    34.     801.    488. 
   222.    241.    616.   424.   106.   755.    826.    644.    595.    556.    362.    358.    623.    183.    766.    148.   757.   739.    913.    145. 
   764.    406.    510.   208.   522.   655.    645.    18.     508.    688.    297.    843.    884.    584.    951.    746.   105.   697.    923.    885. 
   388.    33.     605.   740.   289.   300.    547.    844.    753.    293.    245.    723.    849.    397.    40.     787.   756.   1009.   156.    797. 
   109.    99.     63.    96.    818.   564.    680.    236.    136.    146.    525.    661.    637.    797.    353.    874.   136.   913.    837.    596. 
   35.     511.    406.   852.   673.   66.     609.    777.    197.    291.    615.    495.    723.    507.    207.    410.   647.   28.     720.    1000.
   632.    851.    108.   822.   474.   651.    369.    315.    715.    415.    334.    116.    261.    368.    451.    220.   126.   642.    599.    152. 
   817.    155.    721.   390.   401.   905.    906.    970.    671.    39.     388.    234.    39.     282.    189.    42.    464.   926.    557.    455. 
   263.    66.     460.   290.   262.   418.    771.    320.    265.    616.    51.     827.    646.    415.    156.    631.   325.   949.    577.    916. 
   322.    284.    45.    268.   851.   444.    357.    388.    1023.   330.    305.    290.    880.    794.    925.    293.   327.   722.    873.    609. 
   367.    772.    927.   288.   875.   319.    61.     868.    797.    753.    450.    232.    390.    2.      614.    117.   299.   956.    219.    769. 
   687.    911.    553.   946.   487.   97.     394.    772.    414.    213.    188.    289.    787.    521.    1023.   266.   140.   329.    463.    94.  
   640.    918.    535.   789.   608.   261.    872.    566.    215.    609.    329.    586.    389.    15.     168.    312.   119.   411.    929.    878. 
   815.    877.    287.   78.    894.   962.    442.    78.     316.    313.    815.    336.    965.    11.     801.    547.   183.   517.    506.    818. 
   506.    555.    108.   699.   268.   358.    930.    379.    526.    474.    312.    573.    156.    994.    297.    221.   458.   780.    393.    786. 
   757.    995.    225.   288.   95.    696.    68.     102.    56.     722.    130.    751.    123.    665.    916.    76.    872.   180.    594.    129. 
   274.    537.    875.   41.    478.   665.    801.    237.    608.    195.    938.    368.    871.    188.    669.    898.   684.   733.    524.    682. 
   52.     761.    370.   954.   213.   297.    550.    135.    495.    953.    1013.   237.    12.     830.    285.    94.    400.   752.    891.    484. 
   1010.   208.    440.   195.   691.   918.    439.    9.      127.    870.    402.    58.     962.    202.    431.    827.   971.   579.    424.    166. 
   87.     356.    266.   121.   772.   170.    579.    475.    191.    577.    381.    313.    695.    122.    860.    604.   278.   912.    704.    183. 
   336.    46.     411.   550.   410.   759.    627.    824.    998.    674.    418.    110.    921.    968.    985.    980.   808.   451.    229.    337. 
   140.    786.    267.   947.   338.   675.    939.    814.    136.    259.    433.    32.     395.    81.     763.    961.   882.   740.    436.    958. 
   622.    42.     893.   337.   206.   410.    474.    167.    190.    72.     826.    1023.   368.    478.    296.    823.   843.   840.    1013.   51.  
   783.    667.    87.    946.   799.   720.    842.    905.    671.    720.    336.    293.    790.    115.    798.    36.    882.   289.    866.    600. 
   943.    943.    831.   681.   674.   7.      185.    983.    409.    363.    914.    565.    604.    435.    1014.   940.   120.   389.    127.    741. 
   84.     126.    740.   664.   760.   577.    442.    823.    386.    852.    333.    188.    783.    365.    571.    985.   520.   504.    597.    568. 
   662.    793.    747.   560.   218.   164.    646.    717.    514.    641.    82.     947.    833.    829.    934.    793.   939.   719.    762.    762. 
   219.    23.     425.   240.   589.   1001.   448.    762.    122.    298.    18.     527.    790.    516.    721.    663.   479.   187.    197.    669. 
   314.    808.    446.   167.   55.    863.    119.    946.    51.     834.    784.    487.    216.    628.    980.    803.   470.   810.    288.    735. 
   133.    168.    655.   918.   181.   890.    877.    850.    92.     668.    57.     813.    60.     72.     28.     455.   904.   871.    401.    152. 
   269.    190.    138.   165.   433.   220.    388.    638.    56.     760.    61.     289.    195.    689.    576.    230.   765.   880.    115.    146. 
   209.    871.    159.   674.   932.   77.     832.    515.    1019.   588.    231.    442.    265.    820.    621.    118.   833.   376.    394.    773. 
   129.    751.    429.   14.    162.   319.    675.    827.    1017.   80.     1.      78.     33.     512.    4.      853.   602.   594.    1015.   130. 
   141.    305.    257.   945.   386.   741.    343.    817.    574.    778.    945.    728.    717.    923.    938.    444.   128.   995.    620.    274. 
   377.    841.    15.    136.   649.   686.    991.    342.    116.    50.     832.    1017.   255.    247.    660.    251.   509.   381.    651.    684. 
   94.     383.    431.   748.   225.   502.    892.    563.    459.    878.    740.    614.    568.    871.    694.    80.    290.   105.    246.    305. 
   467.    861.    975.   56.    851.   37.     196.    1014.   302.    1017.   767.    371.    547.    94.     136.    406.   651.   381.    684.    958. 
   331.    381.    458.   721.   172.   576.    102.    70.     735.    317.    336.    1021.   135.    509.    761.    6.     844.   927.    605.    313. 
   745.    716.    721.   593.   898.   997.    94.     939.    13.     317.    245.    615.    994.    156.    787.    356.   319.   859.    260.    379. 
   549.    124.    597.   981.   911.   161.    896.    191.    489.    197.    554.    364.    379.    464.    52.     826.   984.   670.    627.    815. 
   785.    304.    29.    551.   3.     462.    505.    377.    746.    528.    461.    785.    143.    492.    56.     99.    457.   396.    487.    225. 
   748.    649.    810.   520.   961.   308.    718.    723.    548.    484.    841.    661.    444.    287.    408.    663.   0.     908.    377.    847. 
   701.    806.    585.   682.   826.   916.    968.    349.    114.    490.    82.     895.    456.    845.    11.     769.   649.   366.    625.    637. 
   902.    43.     434.   318.   799.   61.     763.    861.    85.     963.    181.    868.    1019.   547.    265.    816.   457.   371.    642.    533. 
   731.    922.    940.   545.   321.   108.    995.    4.      238.    733.    255.    637.    204.    306.    536.    832.   498.   396.    762.    986. 
   279.    844.    731.   724.   849.   107.    699.    158.    321.    53.     193.    482.    768.    37.     913.    624.   229.   98.     465.    760. 
   241.    1004.   507.   264.   17.    0.      904.    46.     446.    15.     615.    645.    21.     548.    204.    884.   641.   288.    150.    661. 
   105.    873.    166.   957.   262.   259.    1003.   899.    481.    1017.   530.    594.    557.    679.    276.    903.   854.   253.    987.    855. 
   125.    206.    796.   981.   147.   711.    60.     270.    864.    218.    226.    293.    162.    364.    530.    217.   21.    35.     721.    623. 
   468.    375.    911.   817.   0.     357.    66.     938.    841.    809.    866.    552.    858.    916.    793.    536.   22.    576.    57.     194. 
   84.     331.    232.   370.   509.   643.    38.     275.    489.    119.    207.    986.    903.    787.    805.    249.   803.   98.     556.    425. 
   65.     538.    708.   288.   621.   1010.   116.    164.    551.    32.     997.    204.    628.    10.     184.    534.   676.   693.    5.      47.  
   738.    987.    74.    237.   521.   412.    216.    249.    233.    301.    752.    156.    88.     4.      48.     341.   715.   999.    88.     973. 
   495.    212.    915.   105.   621.   48.     842.    764.    841.    880.    852.    1017.   914.    296.    725.    357.   826.   69.     101.    90.  
   1005.   888.    570.   15.    710.   194.    834.    684.    444.    448.    455.    452.    202.    743.    440.    894.   633.   257.    969.    760. 
   724.    835.    593.   922.   139.   829.    839.    307.    202.    125.    434.    141.    155.    345.    157.    656.   903.   635.    295.    289. 
   654.    224.    944.   61.    163.   540.    238.    509.    748.    249.    617.    780.    409.    451.    716.    866.   239.   132.    945.    120. 
   757.    207.    947.   871.   568.   611.    289.    748.    256.    375.    405.    528.    168.    864.    997.    556.   298.   588.    478.    426. 
   179.    220.    897.   345.   430.   514.    712.    720.    198.    62.     28.     945.    175.    687.    396.    147.   135.   584.    374.    705. 
   468.    526.    879.   289.   803.   690.    14.     436.    653.    836.    992.    910.    568.    671.    486.    933.   837.   191.    845.    499. 
   212.    643.    100.   134.   861.   1009.   1016.   680.    743.    172.    720.    847.    185.    117.    35.     721.   616.   164.    626.    952. 
   340.    201.    746.   559.   343.   631.    335.    620.    581.    798.    1014.   15.     408.    732.    960.    162.   284.   332.    715.    686. 
   800.    16.     594.   702.   383.   290.    419.    16.     152.    486.    515.    389.    824.    806.    580.    613.   546.   839.    381.    12.  
   149.    911.    225.   360.   61.    516.    839.    727.    777.    295.    527.    1000.   4.      1005.   362.    131.   393.   373.    690.    889. 
   462.    843.    520.   680.   759.   402.    679.    699.    20.     665.    615.    109.    813.    619.    93.     885.   319.   682.    374.    744. 
    ];
assert_checkequal(bitxor(A,B), C);


// Tests 6 :
// =============================================================================
computed = zeros(10, 1);
x12mat =  [
86     19
90     31
32     48
4     22
41     36
55     71
77     77
37     57
100      8
99     76
];
expected =  [
69
69
16
18
13
112
0
28
108
47
];

for k = 1 : size(x12mat, "r")
    i = x12mat(k, 1);
    j = x12mat(k, 2);
    computed(k) = bitxor(i, j);
end
assert_checkequal(computed, expected);

//
// Check that it is correctly vectorized.
computed = bitxor(x12mat(:, 1), x12mat(:, 2));
assert_checkequal(computed, expected);

