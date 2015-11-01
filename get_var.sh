MAINDIR=$PWD
FILE=save_var.m
rm $FILE
SAVE=variables.txt
rm $SAVE

cat>>$FILE <<EOF
clear all
close all
clc
VECTOR=[];
EOF



for levels in 8
do
for j in 1 7
do
for k in 0 #1.25 2.5 3.75 5 6.25 7.5 8.75
do
for ub in 1. 10.
do
for mu in 0.1 1 10 #1 10
do
for rho in 0.1 1 10
do
for sig in 0.1 1 10 #0.1 1 10
do
for jj in 1 5 10
do

DIR=ratios4-$levels-$j$k-$ub-$rho-$mu-$sig

cat>>$FILE <<EOF
copyfile('./VELO/VELO-$DIR/velo-$DIR-$jj.000.dat', 'tt')
t1=load('tt');

f=t1;
[mm,index]=max(f(:,3));     %rmax
[mm2,index2]=min(f(:,2));   %rmin
[mm3,index3]=max(f(:,2));   %zmax
dmax=f(index,2);            %dmax
rmax=f(index,3);            %rmax
rmin=f(index2,3);           %rmin
zmax=f(index3,2);           %zmax

kk2=0;
computeKmax=[];
indexK=[];

nn=length(f(:,2));
for ii=1:nn
    if (f(ii,3)>rmin+(rmax-rmin)/3 && f(ii,3) < rmax)
        kk2=kk2+1;
        computeKmax(kk2)=abs(f(ii,16));        
        indexK(kk2)=ii;
    end    
end
[rc,iRc]=max(computeKmax);
Rc=1/rc;
deltaRc=f(iRc,2);
rRc=f(iRc,3);
t=$jj;
sig=$sig;
mul=$mu;
rhol=$rho;
ub=$ub;
theta=$j$k;

VECTOR=[VECTOR; theta ub rhol mul sig t dmax rmax rmin rRc Rc deltaRc zmax];
disp(VECTOR')
EOF

done
done
done
done
done
done
done
done

cat >> $FILE <<EOF
save $SAVE 'VECTOR' -ascii
EOF
