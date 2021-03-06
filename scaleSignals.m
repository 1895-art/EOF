function[scaSignals] = scaleSignals(signals, eigVals)
%% Scales signals to the standard deviation of the standardized data.
%
% [scaSignals] = scaleSignals(signals, eigVals)
%
% ----- Inputs -----
%
% signals: a set of signals from an EOF analysis. Each column is one signal
%
% eigVals: A matrix containing the associated eigenvalues for each signal.
%
%
% ----- Outputs -----
%
% scaSignals: The set of scaled signals. These signals may be plotted
%   directly against the standardized dataset.
%
%
% ----- Written By -----
% 
% Jonathan King, 2017, University of Arizona (jonking93@email.arizona.edu)


errCheck(signals, eigVals);

% Make the eigenvalues a row
if ~isrow(eigVals)
    eigVals = eigVals';
end

% Replicate the eigenvalue vector into a matrix
eigVals = repmat(eigVals, size(signals,1), 1);

% Scale each signal by the corresponding eigenvalue
scaSignals = signals ./ sqrt(eigVals);
end

%%%%% Helper Functions %%%%%
function[nsignals] = errCheck(signals, eigVals)

% Ensure signals is a matrix
if ~ismatrix(signals)
    error('signals must be a matrix');
end

% Ensure eigVals is a vector
if ~isvector(eigVals)
    error('eigVals must be a vector');
end

% Ensure there are no NaNs
if any(isnan(signals(:)))
    error('signals cannot contain NaN');
end
if any(isnan(eigVals(:)))
    error('eigVals cannot contain NaN');
end

% Ensure eigVals are positive
if any( eigVals(:) < 0)
    error('The eigenvalues must all be positive');
end

% Ensure the signals and eigenvalues align properly
[~, nsignals,] = size(signals);
[neig] = length(eigVals);
if nsignals ~= neig
    error('signals and eigVals do not have matching dimensions');
end
end
