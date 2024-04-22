%define convergence movement as movement towards y = 0 r 
%define extension movement as movement away from x=-360

%movement towards y = 0 --> ^ G value
%movement away from x = -360 --> ^ R value

%Load in final cell positions
initial = read_MultiCellDS_xml_old('initial.xml');
final = read_MultiCellDS_xml_old('final.xml');
inipos = initial.discrete_cells.positions;
finpos = final.discrete_cells.positions;


%Load in Cell IDs
ori = readtable('body_cells.csv')

% find desired cells, change name of the cells accordingly accordingly
CT = find(strcmp(ori.Var4,'PSM')); 

% select initial z plane of interest. Change the number according to which
% z plane you are interested in
Zfind = find(ori.Var3 == 0)

%com represents the cells of interest at the representative Z plane
com=intersect(CT,Zfind); 

%% pull out values 
start = [inipos(com,1), inipos(com,2), inipos(com,3)];
stop = [finpos(com,1), finpos(com,2), finpos(com,3)];
change = stop - start;
filter = [start,change];

%% this section of code assigns RGB R values according to whether cells are travelling 
%% in the correct y direction
neg = (filter(:,2) < 0);
neg = filter(neg,:);
pneg = (neg(:,5)>0);
nneg = (pneg==0);
pval = neg(pneg,:);
nval = neg(nneg,:);

for i=1:numel(nval(:,5))
 r=nval(i,5);
% Compute centile
nless = sum(nval(:,5) < r);
nequal = sum(nval(:,5) == r);
centile =(nless + 0.5*nequal) / length(nval(:,5));
nval(i,7)=0.5-(1-centile)/2;
end

for i=1:numel(pval(:,5))
 r=pval(i,5);
% Compute centile
nless = sum(pval(:,5) < r);
nequal = sum(pval(:,5) == r);
centile =(nless + 0.5*nequal) / length(pval(:,5));
pval(i,7)=0.5+centile/2;
end
neg = [pval;nval];


pos = (filter(:,2) >= 0);
pos = filter(pos,:);
ppos = (pos(:,5)>0);
npos = (ppos==0);
pval = pos(ppos,:);
nval = pos(npos,:);

for i=1:numel(pval(:,5))
 r=pval(i,5);
% Compute centile
nless = sum(pval(:,5) > r);
nequal = sum(pval(:,5) == r);
centile =(nless + 0.5*nequal) / length(pval(:,5));
pval(i,7)=0.5-(1-centile)/2;
end

for i=1:numel(nval(:,5))
 r=nval(i,5);
% Compute centile
nless = sum(nval(:,5) > r);
nequal = sum(nval(:,5) == r);
centile =(nless + 0.5*nequal) / length(nval(:,5));
nval(i,7)=0.5+centile/2;
end
pos = [pval;nval];
full= [neg;pos];

%% this section of code assigns RGB G values according to whether cells are travelling 
%% in the correct x direction (towards +ve)

xvec=full(:,4);

for i=1:numel(xvec)
r=xvec(i);
% Compute centile
nless = sum(full(:,4) < r);
nequal = sum(full(:,4) == r);
centile =(nless + 0.5*nequal) / length(full(:,4));
full(i,8)=centile;
end

%%this section of code assigns thickness according to change in Z +ve, bold
thic=full(:,6);
for i=1:numel(thic)
r=thic(i);
% Compute centile
nless = sum(full(:,6) < r);
nequal = sum(full(:,6) == r);
centile =(nless + 0.5*nequal) / length(full(:,4));
full(i,10)=centile*1.5+0.01; 
end

%%plot graph
full(:,9)=0;
col=strings;
col=[strcat(string(full(:,7)),',',string(full(:,8)),',',string(full(:,9)))];

%plot as 2D
for i=1:numel(col)
q = quiver(full(i,2), full(i,1),full(i,5),full(i,4),...
    'Color',[col(i)]);
q.ShowArrowHead = 'on';
q.LineWidth=full(i,10);
q.MaxHeadSize=3;
 hold on
 axis equal;
 xlim([-155,140]);
 ylim([-360,400]);

end


