function [U, V] = dftuv(M, N)
    u = 0:(M - 1);
    v = 0:(N - 1);

    % Compute the indices for use in meshgrid.
    idx = find(u > M/2);
    u(idx) = u(idx) - M;
    idy = find(v > N/2);
    v(idy) = v(idy) - N;

    % Compute the meshgrid arrays.
    [V, U] = meshgrid(v, u);
end