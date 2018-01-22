function [FilteredResidual] = SlidingWindow(DATA, WindowSize, NumFaultySamp)
% 'DATA' is a binary residual signal {0,1}. 
% 'NumFaultySamp' is # of faulty samples (residuals) in a given window.


if ~exist('WindowSize','var')
  WindowSize = 20;
end

if ~exist('NumFaultySamp','var')
  NumFaultySamp = 15;
end

%--------------------------------------------------------------------------

SignalLength = length(DATA);   

%% ===================================================================== %%

  
index = bsxfun(@plus, (1:WindowSize)', ...
                1+(0:(fix(SignalLength/WindowSize)-1))*WindowSize)-1;

% Loop over sliding windows
for i=1:size(index,2)

    MovingWindow = DATA( index(:,i) );

    % Checking the number of non-zeros (ones) in the flag
    if nnz(MovingWindow) >= NumFaultySamp
        DATA(index(:,i)) = ones(1,WindowSize);
    else
        DATA(index(:,i)) = zeros(1,WindowSize);
    end     

end


%% ===================================================================== %%



FilteredResidual = DATA;

