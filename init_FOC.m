%% =========================================================
%  FOC DRIVE INITIALIZATION
%  PMSM + Torque Control Parameters
%  =========================================================

clearvars

%% Motor electrical parameters

Rs = 0.50;              % Stator phase resistance [Ohm]
Ld = 0.001;             % d-axis inductance [H]
Lq = 0.0012;            % q-axis inductance [H]
L0 = 0.001;             % Zero-sequence inductance [H]

%% Motor mechanical parameters

J = 1e-4;               % Rotor inertia [kg.m^2]
B = 1e-4;               % Viscous friction coefficient [N.m.s]

%% Motor configuration

p = 6;                  % Number of pole pairs
psi_f = 0.03;           % Permanent-magnet flux linkage [Wb]

%% Electrical limits

Vdc = 100;               % DC bus voltage [V]
Iq_max = 15;            % Maximum q-axis current [A]

%% Initial conditions

id0 = 0;                % Initial d-axis current [A]
iq0 = 0;                % Initial q-axis current [A]
omega_m0 = 0;           % Initial mechanical speed [rad/s]
theta_m0 = 0;           % Initial mechanical position [rad]

%% Current-control plant gains

Gain_q = 1/Lq;
Gain_d = 1/Ld;

%% Torque-control parameters

% Torque-to-q-axis-current gain
K_t2iq = 2/(3*p*psi_f);
% Sample Time
Ts = 1e-6;

%% Current Controller Tuning

fc_current = 1000;                 % Current loop bandwidth [Hz]
wc_current = 2*pi*fc_current;     % Angular bandwidth [rad/s]

Kp_d = Ld * wc_current;
Ki_d = Rs * wc_current;

Kp_q = Lq * wc_current;
Ki_q = Rs * wc_current;

%% Display parameters

disp('======================================')
disp('FOC DRIVE PARAMETERS LOADED')
disp('======================================')

fprintf('Rs       = %.4f Ohm\n', Rs);
fprintf('Ld       = %.6f H\n', Ld);
fprintf('Lq       = %.6f H\n', Lq);
fprintf('p        = %d\n', p);
fprintf('psi_f    = %.4f Wb\n', psi_f);
fprintf('Vdc      = %.2f V\n', Vdc);
fprintf('Iq_max   = %.2f A\n', Iq_max);
fprintf('K_t2iq   = %.4f A/Nm\n', K_t2iq);
fprintf('Current bandwidth = %.2f Hz\n', fc_current);
fprintf('Angular bandwidth = %.2f rad/s\n', wc_current);

fprintf('\nPI_d Controller:\n');
fprintf('Kp_d = %.6f\n', Kp_d);
fprintf('Ki_d = %.6f\n', Ki_d);

fprintf('\nPI_q Controller:\n');
fprintf('Kp_q = %.6f\n', Kp_q);
fprintf('Ki_q = %.6f\n', Ki_q);

disp('======================================')