clear
clc
%% a)
img = imread("Tobey.jpg");

% matrix items
% dark background
disp(img(1,1,1));
disp(img(1,1,2));
disp(img(1,1,3));
% Tobey face
disp(img(230,340,1)); 
disp(img(230,340,2)); 
disp(img(230,340,3)); 

%% b)
imgdouble = im2double(img);
% Tobey face
disp(imgdouble(230,340,1)); 
disp(imgdouble(230,340,2)); 
disp(imgdouble(230,340,3)); 
% this numbers are a share of 255.

%% c)
r = 5;
[Ur, Sr, Vr] = svd(imgdouble(:,:,1));
[Ug, Sg, Vg] = svd(imgdouble(:,:,2));
[Ub, Sb, Vb] = svd(imgdouble(:,:,3));

Ar = approx(Ur, Sr, Vr, r);
Ag = approx(Ug, Sg, Vg, r);
Ab = approx(Ub, Sb, Vb, r);

A5(:,:,1) = Ar;
A5(:,:,2) = Ag;
A5(:,:,3) = Ab;

% error
e = mean(mean(mean(abs(imgdouble - A5))));
%% d)

imshow(A5)

%% e)
tol1 = 0.02;
AR1r = approx(Ur, Sr, Vr, maxsingvalue(Sr, Sg, Sb, tol1));
AR1g = approx(Ug, Sg, Vg, maxsingvalue(Sr, Sg, Sb, tol1));
AR1b = approx(Ub, Sb, Vb, maxsingvalue(Sr, Sg, Sb, tol1));

AR1(:,:,1) = AR1r;
AR1(:,:,2) = AR1g;
AR1(:,:,3) = AR1b;

tol2 = 0.001;
AR2r = approx(Ur, Sr, Vr, maxsingvalue(Sr, Sg, Sb, tol2));
AR2g = approx(Ug, Sg, Vg, maxsingvalue(Sr, Sg, Sb, tol2));
AR2b = approx(Ub, Sb, Vb, maxsingvalue(Sr, Sg, Sb, tol2));

AR2(:,:,1) = AR2r;
AR2(:,:,2) = AR2g;
AR2(:,:,3) = AR2b;

%%
subplot(1,2,1)
imshow(AR1)
subplot(1,2,2)
imshow(AR2)

%% f) ...

%% g) saving jpgs
imwrite(AR2,'Tobey_approx.jpg');


%% functions
function app = approx(U, S, V, r)
app = zeros(size(U,1), size(V,1));
for i = 1:r
    app = app + S(i,i)*U(:,i)*V(:,i)';
end
end

function R = maxsingvalue(Sr, Sg, Sb, tol)
Rr = 0;
Rg = 0;
Rb = 0;
for i=2:size(Sb,1)
    if Sr(i,i) > tol*Sr(1,1)
        Rr = Rr + 1;
    end
    if Sg(i,i) > tol*Sg(1,1)
        Rg = Rg + 1;
    end
    if Sb(i,i) > tol*Sb(1,1)
        Rb = Rb + 1;
    end
end
R = max([Rr,Rg,Rb]);
end
