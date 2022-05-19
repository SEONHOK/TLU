clear all;
clc



for d=50:50:1000
       AM1=[];
       AM2=[];
       AM3=[];
       AM4=[];
       AR1=[];
       AR2=[];
       AR3=[];
       AR4=[];
       ARitr1=[];
        fnameAM1 = ['PhaseTran'  'd' num2str(d) 'freq' '.mat'];
       
       
     
    for n=200:200:5000
                fname_AM1 = ['PhaseTran'  'd' num2str(d) 'n' num2str(n) '.mat'];     
             
                tmp=cell2mat(struct2cell(load(fname_AM1)));
                
                AM1=[AM1; sum(tmp<10^-5)/length(tmp)];            


                
    end
    save(fnameAM1,'AM1');

end