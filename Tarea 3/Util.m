function u= Util(c, sigma)

            if sigma==1
                u= log( c );
            else
                u= ( c.^(1-sigma) -1)/(1-sigma);
            end
            
end