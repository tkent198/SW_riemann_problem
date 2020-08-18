function root = rootfinder(hl,hr,ul,ur,func,funcprime)

%Newton Raphson method

h=hl; %set starting value
nmax=25; %set max number of iterations
eps=1; %initialise error bound eps
hvals=h; %initialise array of iterates
n=0; %initialise n (counts iterations)

while eps>=1e-10 & n<=nmax                      
    hh=h-func(h)/funcprime(h); %compute next iterate
    hvals=[hvals;hh]; %write next iterate in array
    eps=abs(hh-h); %compute error
    h=hh;n=n+1; %update h and n
end  

root=h;