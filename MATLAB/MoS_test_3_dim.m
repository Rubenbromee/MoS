delta_x = 0.1; % Spatial sampling step
v = 343; % Wave velocity for sound in room temperature air
m = 101; % Room length
n = 101; % Room width
o = 101; % Room height
origo_m = ceil(m/2); % Length midpoint
origo_n = ceil(n/2); % Width midpoint
origo_o = ceil(o/2); % Room height
f = 500; % Sound frequency
n_t = 1001; % Number of time steps
delta_t = 0.0001; % Time step
c = v * (delta_t / delta_x); % Sound constant
P = zeros(n_t, m, n, o); % Room visualization matrix
period = 1 / f; % Wave time period
period_n_t = round(period / delta_t); % Wave time period expressed in amount of time steps

% Placement of sound source. Orgio of room as default.
% origo_m = 100;
% origo_n = 200;

% Starting conditions, impulse source, cube.
% Middle layer:
P(1, origo_m, origo_n, origo_o) = 1;
P(1, origo_m + 1, origo_n + 1, origo_o) = 1;
P(1, origo_m - 1, origo_n + 1, origo_o) = 1;
P(1, origo_m - 1, origo_n - 1, origo_o) = 1;
P(1, origo_m + 1, origo_n - 1, origo_o) = 1;
P(1, origo_m + 1, origo_n, origo_o) = 1; 
P(1, origo_m - 1, origo_n, origo_o) = 1;
P(1, origo_m, origo_n + 1, origo_o) = 1;
P(1, origo_m, origo_n - 1, origo_o) = 1;
% Top layer:
P(1, origo_m, origo_n, origo_o + 1) = 1;
P(1, origo_m + 1, origo_n + 1, origo_o + 1) = 1;
P(1, origo_m - 1, origo_n + 1, origo_o + 1) = 1;
P(1, origo_m - 1, origo_n - 1, origo_o + 1) = 1;
P(1, origo_m + 1, origo_n - 1, origo_o + 1) = 1;
P(1, origo_m + 1, origo_n, origo_o + 1) = 1; 
P(1, origo_m - 1, origo_n, origo_o + 1) = 1;
P(1, origo_m, origo_n + 1, origo_o + 1) = 1;
P(1, origo_m, origo_n - 1, origo_o + 1) = 1;
% Bottom layer:
P(1, origo_m, origo_n, origo_o - 1) = 1;
P(1, origo_m + 1, origo_n + 1, origo_o - 1) = 1;
P(1, origo_m - 1, origo_n + 1, origo_o - 1) = 1;
P(1, origo_m - 1, origo_n - 1, origo_o - 1) = 1;
P(1, origo_m + 1, origo_n - 1, origo_o - 1) = 1;
P(1, origo_m + 1, origo_n, origo_o - 1) = 1; 
P(1, origo_m - 1, origo_n, origo_o - 1) = 1;
P(1, origo_m, origo_n + 1, origo_o - 1) = 1;
P(1, origo_m, origo_n - 1, origo_o - 1) = 1;

% Accoustic wave equation implemented numerically
for j = 2:n_t-1 % Iteration over time
    % Create new impulse cube according to frequency
    if mod(j, period_n_t) == 0
       % Middle layer:
       P(j, origo_m, origo_n, origo_o) = 1;
       P(j, origo_m + 1, origo_n + 1, origo_o) = 1;
       P(j, origo_m - 1, origo_n + 1, origo_o) = 1;
       P(j, origo_m - 1, origo_n - 1, origo_o) = 1;
       P(j, origo_m + 1, origo_n - 1, origo_o) = 1;
       P(j, origo_m + 1, origo_n, origo_o) = 1; 
       P(j, origo_m - 1, origo_n, origo_o) = 1;
       P(j, origo_m, origo_n + 1, origo_o) = 1;
       P(j, origo_m, origo_n - 1, origo_o) = 1;
       % Top layer:
       P(j, origo_m, origo_n, origo_o + 1) = 1;
       P(j, origo_m + 1, origo_n + 1, origo_o + 1) = 1;
       P(j, origo_m - 1, origo_n + 1, origo_o + 1) = 1;
       P(j, origo_m - 1, origo_n - 1, origo_o + 1) = 1;
       P(j, origo_m + 1, origo_n - 1, origo_o + 1) = 1;
       P(j, origo_m + 1, origo_n, origo_o + 1) = 1; 
       P(j, origo_m - 1, origo_n, origo_o + 1) = 1;
       P(j, origo_m, origo_n + 1, origo_o + 1) = 1;
       P(j, origo_m, origo_n - 1, origo_o + 1) = 1;
       % Bottom layer:
       P(j, origo_m, origo_n, origo_o - 1) = 1;
       P(j, origo_m + 1, origo_n + 1, origo_o - 1) = 1;
       P(j, origo_m - 1, origo_n + 1, origo_o - 1) = 1;
       P(j, origo_m - 1, origo_n - 1, origo_o - 1) = 1;
       P(j, origo_m + 1, origo_n - 1, origo_o - 1) = 1;
       P(j, origo_m + 1, origo_n, origo_o - 1) = 1; 
       P(j, origo_m - 1, origo_n, origo_o - 1) = 1;
       P(j, origo_m, origo_n + 1, origo_o - 1) = 1;
       P(j, origo_m, origo_n - 1, origo_o - 1) = 1;
   end
    for k = 2:m-1 % Iteration over length
        for l = 2:n-1 % Iteration over width
            for q = 2:o-1 % Iteration over height
                P(j+1, k, l, q) = c^2 * ... 
                (P(j, k + 1, l, q) + P(j, k, l + 1, q) + P(j, k, l, q + 1)... 
                + P(j, k, l - 1, q) + P(j, k - 1, l, q) + P(j, k, l, q - 1)... 
                - 6 * P(j, k, l, q)) + ...
                2 * P(j, k, l, q) - P(j - 1, k, l, q);
            end
        end
    end
end

% Animation and video write loop
% movie_obj = VideoWriter('wave_prop_impulse_flashing_3D.avi');
% open(movie_obj);
fig = figure(1);
for i = 1:n_t
    i_p(:, :, :) = P(i , :, :, :);
    s = abs(i_p(:, :, :));
    imshow3D(s(:, :, :), 'InitialMagnification', 600, 'Interpolation', 'bilinear');
    colormap default;
    drawnow;
%     F = getframe(fig);
%     writeVideo(movie_obj, F);
end
% close(movie_obj);