%creating txt files with random foci for FSN
%has the following input arguments
    % varppn: average amount of participants
    % nns: number of null studies
    % nrs: number of real studies
    %template: that was used
    %e.g. template='Grey10'
    %realns: vector of sample sizes of the amount of true studies 
    %e.g.: realns=randi([12 26],1,3)
    %realnr: vector of nr of peaks per  true study
    %e.g. realnr=randi(3,1,3)
    %include rng(seed) to set seed where needed

function sample_nullfoci(varppn,nrs,nns,maxpeaksr,maxpeaksn,template,seed)
    % Define variables
        nfocilist = [repmat(2,1,454),repmat(3,1,341),repmat(4,1,285),repmat(5,1,192),repmat(6,1,207),repmat(7,1,132),repmat(8,1,108),repmat(9,1,119),repmat(10,1,92),repmat(11,1,69),repmat(12,1,54),repmat(13,1,55),repmat(14,1,55),repmat(15,1,41),repmat(16,1,31),repmat(17,1,30),repmat(18,1,30),repmat(19,1,25),repmat(20,1,14),repmat(21,1,18),repmat(22,1,11),repmat(23,1,11),repmat(24,1,13),repmat(25,1,5),repmat(26,1,9),repmat(27,1,7),repmat(28,1,6),repmat(29,1,10),repmat(30,1,5),repmat(31,1,7),repmat(32,1,6),repmat(33,1,11),repmat(34,1,5),repmat(35,1,4),repmat(36,1,3),repmat(37,1,4),repmat(38,1,5),repmat(39,1,1),repmat(40,1,5),repmat(41,1,3),repmat(42,1,6),repmat(43,1,5),repmat(44,1,2),repmat(48,1,1),repmat(50,1,2),repmat(51,1,1),repmat(52,1,3),repmat(55,1,1),repmat(56,1,6),repmat(57,1,1),repmat(62,1,1),repmat(64,1,1),repmat(65,1,2),repmat(67,1,1),repmat(69,1,1),repmat(75,1,1)];
        real = [46 -66 -6];    %real:coordinate of true activation in MNI
        sigma = 1;
        rng(seed);
        ns = round(normrnd(varppn,sigma,[1,nns]));
        rng(seed);
        realns = round(normrnd(varppn,sigma,[1,nrs]));
        rng(seed);
%         nr = repmat(maxpeaksn,1,nns)
%         realnr = repmat(maxpeaksr,1,nrs)
        if maxpeaksn == 1
            rng(seed);
            nr = round(randi(maxpeaksn,1,nns)); % nr of peaks per study (length k)
        else
            rng(seed);
            nr = datasample(nfocilist,nns);
        end
        
        if maxpeaksr == 1
            rng(seed);
            realnr = round(randi(maxpeaksr,1,nrs)); % nr of peaks per study (length k)
        else
            rng(seed);
            realnr = datasample(nfocilist,nrs)
        end
        


    try; TEMPLATE = spm_vol(fullfile(pwd,'MaskenEtc',strcat(template,'.nii')));
    catch; error('Could not find template');
    end;
    load(fullfile(pwd,'MaskenEtc',strcat('permSpace',template,'.mat')));

    %all coordinates in the mask are in allXYZ, we first transform to MNI
    %because some templates are mirrored!
        allXYZmm=TEMPLATE.mat*[allXYZ; ones(1,size(allXYZ,2))];
        %no go zone: X>origin, Y<origin
        go=~((allXYZmm(1,:)>=0)&(allXYZmm(2,:)<=0)); %indices we can sample from
        coordgo=allXYZmm(:,go); % coordinates we can sample from

    %initiating textfile 3+100-1_10.txt
        savefile=strcat(num2str(nrs),'+',num2str(nns),'stud-',num2str(seed),'_',num2str(varppn),'.txt');
        folder = strcat(pwd,'/simstudies')
        fullFileName = fullfile(folder, savefile);
        fid=fopen(fullFileName,'w');
        header1='//Reference=MNI';

    %adding the true activation manually in script
        for it=1:length(realns)
            %creating study specific headers
            header2=strcat('//truestudy_',num2str(it));
            header3=strcat('//Subjects=',num2str(realns(it)));
            rng(seed*10000 +it)
            rpeak=randn(realnr(it),3);
            tpeaksMNI=round(rpeak+repmat(real,realnr(it),1));
            fprintf(fid, [ header1 ' \n' header2 '\n' header3 '\n']);
            fprintf(fid, '%d  %d  %d \n', tpeaksMNI');
            fprintf(fid,'\n');
            clear rpeak;
        end

    %adding a loop with vector of sample sizes.
        for i=1:length(ns)
            %creating study specific headers
            header2=strcat('//nullstudy_',num2str(i));
            header3=strcat('//Subjects=',num2str(ns(i)));
            rng(seed*10000 +i)
            r=randi([1 size(coordgo,2)],1,nr(i));
            peaksMNI=coordgo(1:3,r);
            fprintf(fid, [ header1 ' \n' header2 '\n' header3 '\n']);
            fprintf(fid, '%d  %d  %d \n', peaksMNI);
            fprintf(fid,'\n');
        end

fclose(fid);
end







