function [ Ndata, MIN, MAX ] = normalization( data, Lower_Limits, Higher_Limits )

% This code automatically detects whether the data should be normalized
% between [0,1] or [-1,1].

% Dimension = # of Columns
% Samples = # of Rows

% Finding the Dimension of the data
Dimension = length(data(1,:));  

% -------------------------------------------------------------------------
% If Lower and Higher limits are not given, they will be taken to be the
% minimum and the maximum of the provided data.
if ~exist('Lower_Limits','var')
    Lower_Limits = min(data);
end

if ~exist('Higher_Limits','var')
    Higher_Limits = max(data);
end

% -------------------------------------------------------------------------
% if the Lower and Higher limits are given as a single number, they will be
% converted to a vector in order to match the dimension of the data.
if length(Lower_Limits) == 1
    Lower_Limits = Lower_Limits * ones(Dimension,1);
end

if length(Higher_Limits) == 1
    Higher_Limits = Higher_Limits * ones(Dimension,1);
end

%% ------------------------------------------------------------------------
% Checking whether the normalization should be between [0,1] or [-1,1]

NegativeElement = find(Lower_Limits < 0);

if isempty(find(Lower_Limits<0))  % if TRUE(empty) all elements are nonnegative
    
    % Normalization in the range of [0,1]    
    for i=1:Dimension
        Ndata(:,i) = (data(:,i) - Lower_Limits(i)) ./ (Higher_Limits(i) - Lower_Limits(i));   
    end
    
else  
    
    % Normalization in the range of [-1,1]
    % Caluculating parameters needed for scaling
    for i=1:Dimension
        middle_point(i) = (Lower_Limits(i) + Higher_Limits(i)) / 2;
        half_range(i) = (Higher_Limits(i) - Lower_Limits(i)) / 2;
    end

    % Normalization
    for i=1:Dimension
        Ndata(:,i) = (data(:,i) - middle_point(i)) ./ half_range(i);   
    end
end

MAX = Higher_Limits;
MIN = Lower_Limits;



end

