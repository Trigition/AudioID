function tests2vect()

tc1 = transpose( csvread('../Tests/Classical_01.txt'));
tc2 = transpose( csvread('../Tests/Classical_02.txt'));
tc3 = transpose( csvread('../Tests/Classical_03.txt'));
tc4 = transpose( csvread('../Tests/Classical_04.txt'));
tc5 = transpose( csvread('../Tests/Classical_05.txt'));
tc6 = transpose( csvread('../Tests/Classical_06.txt'));
td1 = transpose( csvread('../Tests/Dubstepper_01.txt'));
td2 = transpose( csvread('../Tests/Dubstepper_02.txt'));
td3 = transpose( csvread('../Tests/Dubstepper_03.txt'));
td4 = transpose( csvread('../Tests/Dubstepper_04.txt'));
td5 = transpose( csvread('../Tests/Dubstepper_05.txt'));
td6 = transpose( csvread('../Tests/Dubstepper_06.txt'));
tr1 = transpose( csvread('../Tests/Reggae_01.txt'));
tr2 = transpose( csvread('../Tests/Reggae_02.txt'));
tr3 = transpose( csvread('../Tests/Reggae_03.txt'));
tr4 = transpose( csvread('../Tests/Reggae_04.txt'));
tr5 = transpose( csvread('../Tests/Reggae_05.txt'));
tr6 = transpose( csvread('../Tests/Reggae_06.txt'));



    save('tc1', 'tc1');
    save('tc2', 'tc2');    
    save('tc3', 'tc3');
    save('tc4', 'tc4');
    save('tc5', 'tc5');
    save('tc6', 'tc6');
    save('td1', 'td1');
    save('td2', 'td2');    
    save('td3', 'td3');
    save('td4', 'td4');
    save('td5', 'td5');
    save('td6', 'td6');
    save('tr1', 'tr1');
    save('tr2', 'tr2');    
    save('tr3', 'tr3');
    save('tr4', 'tr4');
    save('tr5', 'tr5');
    save('tr6', 'tr6');



end