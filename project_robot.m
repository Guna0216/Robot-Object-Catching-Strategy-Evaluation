% main function which calculates the expected value of robot catching the object
%   Inputs: 
%       pom -  probability of object moving towards left or right
%       s - number of the strategy to used to calculating the expected value
%   Output:
%       n - Expected value of robot catching the object
function [n] = project2_srigunak_dyamarth(pom,s)                   
    % assinging expected value to be zero initially
    n = 0;  
    
    % to follow strategy-1
    if s == 1
        for i = 5:19 
            n = n + (1/15)*expected_value_k_s1(pom,i); % multiplying the probability of distance (uniform) with expected value at that distance
        end
    % to follow strategy-2
    elseif s == 2
        for i = 5:19
            n = n + (1/15)*expected_value_k_s2(pom,i); % multiplying the probability of distance (uniform) with expected value at that distance
        end
    elseif s == 3
        for i = 5:19
            n = n + (1/15)*expected_value_k_s3(pom,i); % multiplying the probability of distance (uniform) with expected value at that distance
        end
    end
end

% function with calculates the E[T/D = d] using strategy-1
%   Inputs: 
%       pom -  probability of object moving towards left or right
%       d - distance between the robot and the object
%   Output:
%       n - the value of E[T/D = d]
function [n] = expected_value_k_s1(pom, d)
    if d == 1 % if the distance between robot and object is 1 unit
        n = 1/(1-pom);
    elseif d == 2 % if the distance between robot and object is 2 units
        n = (((1-2*pom)/(1-pom))*expected_value_k_s1(pom,1)) + (1/(1-pom));
    else
        % recusive formula for calculating the value at k units (k>2)
        n = (1/(1-pom)) + (((1-2*pom)/(1-pom))*expected_value_k_s1(pom,d-1)) + (((pom)/(1-pom))*expected_value_k_s1(pom,d-2));
    end
end

% function with calculates the E[T/D = d] using strategy-2
%   Inputs: 
%       pom -  probability of object moving towards left or right
%       d - distance between the robot and the object
%   Output:
%       n - the value of E[T/D = d]
function [n] = expected_value_k_s2(pom, d)
    if d == 1 || d == 2 % if the distance between robot and object is 1 or 2 unit(s)
        n = 1/(pom);
    else
        % recusive formula for calculating the value at k units (k>2)
        n = (1/(pom)) + expected_value_k_s1(pom,d-2);
    end
end

% function with calculates the E[T/D = d] using strategy-3
%   Inputs: 
%       pom -  probability of object moving towards left or right
%       d - distance between the robot and the object
%   Output:
%       n - the value of E[T/D = d]
function [n] = expected_value_k_s3(pom,d)
    % probability of movement of robot as stated in the problem
    pomr = 1.5*pom;
    if d > 15
        n = 0;
    elseif d == 1 % if the distance between robot and object is 1 unit
        n = (pom*(1-pomr)/(pomr+(2*pom)-(3*pom*pomr)))*expected_value_k_s3(pom,2) + (1/(pomr+(2*pom)-(3*pom*pomr)));
    elseif d == 2 % if the distance between robot and object is 2 units
        n = (pom*(1-pomr)/(pomr+(2*pom)-(3*pom*pomr)))*expected_value_k_s3(pom,3) + ((pomr+pom-(3*pomr*pom))/(pomr+(2*pom)-(3*pom*pomr)))*expected_value_k_s3(pom,1)+ (1/(pomr+(2*pom)-(3*pom*pomr)));
    else % recusive formula for calculating the value at k units (k>2)
        n = (pom*(1-pomr)/(pomr+(2*pom)-(3*pom*pomr)))*expected_value_k_s3(pom,d+1) + ((pomr+pom-(3*pomr*pom))/(pomr+(2*pom)-(3*pom*pomr)))*expected_value_k_s3(pom,d-1) + (pomr*pom/(pomr+(2*pom)-(3*pom*pomr)))*expected_value_k_s3(pom,d-2)+(1/(pomr+(2*pom)-(3*pom*pomr)));
    end
end
