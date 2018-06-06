
function sample_nullfoci(nr,template)


try; TEMPLATE = spm_vol(fullfile(pwd,'MaskenEtc',strcat(template,'.nii')));
catch; error('Could not find template');
end;

origin=abs(TEMPLATE.mat(1:3,4)/2); %get the origin
load(fullfile(pwd,'MaskenEtc',strcat('permSpace',template,'.mat')));
%all coordinates in the mask are in allXYZ
%no go zone: X>origin, Y<origin
go=~((allXYZ(1,:)>origin(1))&(allXYZ(2,:)<origin(2))); %indices we can sample from
coordgo=allXYZ(:,go); % coordinates we can sample from
r=randi([1 size(coordgo,2)],1,nr);
peaksvox=coordgo(:,r);
peaksMNI=TEMPLATE.mat(1:3,:)*[peaksvox; ones(1,size(peaksvox,2))];