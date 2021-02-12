c = 343; % Speed of sound in room temperature
delta_x = 0.001; % Spatial sampling step
% delta_y = 0.01; % Spatial sampling step
m = 71; % Room length
n = 71; % Room width
%x(:,1) = (0:m - 1) * delta_x; %Spatial visualization vector
%y(:,1) = (0:n - 1) * delta_y; %Spatial visualization vector
origo_m = ceil(m/2); % Length midpoint
origo_n = ceil(n/2); % Width midpoint
f = 100; % Sound frequency
n_t = 501; % Number of time steps
delta_t = 0.001; % Time step
t(:, 1) = (0:n_t-1) * delta_t; % Temporal visualization vector
P = zeros(n_t, m, n); % Room visualization matrix

% Initial conditions, sound wave emitting from the middle of the room
for i = 1:2
    P((1:n_t), origo_m + i, origo_n + i) = sin(2*pi*f.*(1:n_t)); 
    P((1:n_t), origo_m - i, origo_n + i) = sin(2*pi*f.*(1:n_t));
    P((1:n_t), origo_m - i, origo_n - i) = sin(2*pi*f.*(1:n_t));
    P((1:n_t), origo_m + i, origo_n - i) = sin(2*pi*f.*(1:n_t));
    P((1:n_t), origo_m + i, origo_n) = sin(2*pi*f.*(1:n_t)); 
    P((1:n_t), origo_m - i, origo_n) = sin(2*pi*f.*(1:n_t));
    P((1:n_t), origo_m, origo_n + i) = sin(2*pi*f.*(1:n_t));
    P((1:n_t), origo_m, origo_n - i) = sin(2*pi*f.*(1:n_t));
end

% % Accoustic wave equation implemented numerically
% for j = 3:n_t % Iteration over time
%     for k = 2:m-1 % Iteration over length
%         for l = 2:n-1 % Iteration over width
%             P(j+1, k, l) = (delta_t^2 / delta_x^2) * ... % c^2 should be here
%             (P(j, k + 1, l) - 4 * P(j, k, l) + P(j, k - 1, l ) + ... 
%             P(j, k, l + 1) + P(j, k - 1, l - 1)) + ...
%             2 * P(j, k, l) - P(j - 1, k, l);
%         end
%     end
% end

% Accoustic wave equation implemented numerically
for j = 3:n_t % Iteration over time
    for k = 2:(m-2)/2 % Iteration over length
        for l = 2:(n-2)/2 % Iteration over width
            P(j+1, origo_m + k, origo_n + l) = (delta_t^2 / delta_x^2) * ... % c^2 should be here
            (P(j, origo_m + k + 1, origo_n + l) - 4 * P(j, origo_m + k, origo_n + l) + P(j, origo_m + k - 1, origo_n + l ) + ... 
            P(j, origo_m + k, origo_n + l + 1) + P(j, origo_m + k - 1, origo_n + l - 1)) + ...
            2 * P(j, origo_m + k, origo_n + l) - P(j - 1, origo_m + k, origo_n + l);
        end
    end
end

for i = 1:n_t
    i_p(:, :) = P(i , :, :);
    if max(i_p(:, :)) == 0
        imshow(i_p, 'InitialMagnification', 600);
        drawnow;
    else
        s = i_p(:,:)./max(i_p(:, :));
        imshow(s(:, :), 'InitialMagnification', 600);
        drawnow;
    end
end

% % Wave propagation animation
% movie_obj = VideoWriter('wave_prop.avi');
% open(movie_obj);
% fig = figure(1);
% for i = 1:n_t
%     i_p(:, :) = P(i, :, :); % Capture the sound pressure in each frame
%     surf(x,y,i_p','EdgeColor','none','LineStyle','none');
%     view(2);
%     axis([min(x) max(x) min(y) max(y) -100 100]);
%     F = getframe(fig);
%     writeVideo(movie_obj, F);
% end
% close(movie_obj);