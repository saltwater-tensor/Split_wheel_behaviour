%Updated on October 4th 2016

%% Preparing initial model
clc
clear all
close all
load model_init
load Feet_position_allframes
model_init_front = model_init;
model_init_front.mu0 = [Front(1,1);Front(1,2)];
model_init_hind = model_init;
model_init_hind.mu0 = [Hind(1,1);Hind(1,2)];

%% Kalman Data Preparation

load Feet_position_allframes

Hind = Hind';
Front = Front';
Hind_x = Hind(1,:);
Hind_y = Hind(2,:);
Front_x = Front(1,:);
Front_y = Front(2,:);

% Hind_new = [Hind_x(Hind_x~=0); Hind_y(Hind_y~=0)];
% Front_new = [Front_x(Front_x~=0); Front_y(Front_y~=0)];
Front_new = Front;
Hind_new = Hind;

%% Running Kalman parameter initialisation
%% Running Kalman smoother
[model_smooth_hind_allframes,llh] = ldsEm(Hind_new,model_init);
[model_smooth_front_allframes,llh] = ldsEm(Front_new,model_init);

[nu_hind_allframes u_hind_allframes Ezz Ezy llh] = ...
    kalmanSmoother(Hind_new,model_smooth_hind_allframes);

[nu_front_allframes u_front_allframes Ezz Ezy llh] = ...
    kalmanSmoother(Front_new,model_smooth_front_allframes);

