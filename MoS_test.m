delta_x = 0.1; % Spatial sampling step
v = 343; % Wave velocity for sound in room temperature air
m = 101; % Room length
n = 101; % Room width
origo_m = ceil(m/2); % Length midpoint
origo_n = ceil(n/2); % Width midpoint
f = 100; % Sound frequency
n_t = 501; % Number of time steps
delta_t = 0.0001; % Time step
c = v * (delta_t / delta_x); % Sound constant
P = zeros(n_t, m, n); % Room visualization matrix

% Placement of sound source.
% origo_m = 100;
% origo_n = 200;

% Starting conditions, impulse source.
P(1, origo_m, origo_n) = 1;
P(1, origo_m + 1, origo_n + 1) = 1;
P(1, origo_m - 1, origo_n + 1) = 1;
P(1, origo_m - 1, origo_n - 1) = 1;
P(1, origo_m + 1, origo_n - 1) = 1;
P(1, origo_m + 1, origo_n) = 1; 
P(1, origo_m - 1, origo_n) = 1;
P(1, origo_m, origo_n + 1) = 1;
P(1, origo_m, origo_n - 1) = 1;

% Accoustic wave equation implemented numerically
for j = 2:n_t-1 % Iteration over time
    for k = 2:m-1 % Iteration over length
        for l = 2:n-1 % Iteration over width
            P(j+1, k, l) = c^2 * ... 
            (P(j, k + 1, l) - 4 * P(j, k, l) + P(j, k - 1, l ) + ... 
            P(j, k, l + 1) + P(j, k, l - 1)) + ...
            2 * P(j, k, l) - P(j - 1, k, l);
        end
    end
end

% Animation and video write loop
movie_obj = VideoWriter('wave_prop.mj2');
open(movie_obj);
fig = figure(1);
for i = 1:n_t
    i_p(:, :) = P(i , :, :);
    s = abs(i_p(:,:));
    imshow(s(:, :), 'InitialMagnification', 600);
    drawnow;
    F = getframe(fig);
    writeVideo(movie_obj, F);
end
close(movie_obj);

json_info = jsonencode(P(:,:,:));
json_file = fopen('jason.json', 'w');
fwrite(json_file, json_info, 'char');
fclose(json_file);