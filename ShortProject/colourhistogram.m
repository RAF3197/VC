close all;
clear all
clc;
I = imread('lavender.jpg');
imshow(I),figure
I = im2double(I);
[index,map] = rgb2ind(I);
pixels = prod(size(index));
hsv = rgb2hsv(map);
h = hsv(:,1);
s = hsv(:,2);
v = hsv(:,3);
%Finds location of black and white pixels
darks = find(v < .2)';
lights = find(s < .05 & v > .85)';
h([darks lights]) = -1;
%Gets the number of all pixels for each color bin
black = length(darks)/pixels;
white = length(lights)/pixels;
red = length(find((h > .9167 | h <= .083) & h ~= -1))/pixels;
yellow = length(find(h > .083 & h <= .25))/pixels;
green = length(find(h > .25 & h <= .4167))/pixels;
cyan = length(find(h > .4167 & h <= .5833))/pixels;
blue = length(find(h > .5833 & h <= .75))/pixels;
magenta = length(find(h > .75 & h <= .9167))/pixels;
%Plots histogram
hold on
fill([0 0 1 1],[0 red red 0],'r')
fill([1 1 2 2],[0 yellow yellow 0],'y')
fill([2 2 3 3],[0 green green 0],'g')
fill([3 3 4 4],[0 cyan cyan 0],'c')
fill([4 4 5 5],[0 blue blue 0],'b')
fill([5 5 6 6],[0 magenta magenta 0],'m')
fill([6 6 7 7],[0 white white 0],'w')
fill([7 7 8 8],[0 black black 0],'k')
axis([0 8 0 1])
