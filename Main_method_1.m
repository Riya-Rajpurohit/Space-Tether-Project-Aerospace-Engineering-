
function [list_frac_blocking, list_blocking_area] = Main_method_1(Vo,Rcg, i_links, dl, dw, Ro, Tib)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
warning('off','all')
list_frac_blocking = zeros(1,i_links);
list_blocking_area = zeros(1,i_links);
links_list = []; %contains a list of all the link objects 


T_iw = wind_coordinates(Vo, Rcg(1,:)+ Ro');
for I = (1: i_links)
    R_i = Rcg(I,:)'+Ro; %transpose Rcg 
    Rw = T_iw* R_i; %converting the position of the center of gravity oe each link into wind coordinates
    %disp(Rw)
    Tib_I = Tib(:,:,I);
    [Y_i, Z_i, X_i] = y_and_z(Rw, dw, dl, Tib_I, T_iw); % Y_i and Z_i are the y and z coordinates of the link (in wind coordinates)
    %plot3(Y_i, Z_i, X_i);
    %hold on
    %Rw = R_i * T_iw; 
    %[Y_i, Z_i] = y_and_z(Rw, dl,dw);
    linkI = link(I, dl, dw, Y_i, Z_i, Rw, X_i);
    %disp(Vo);
    links_list = [links_list, linkI];
end
% sorts the list according to the x_wind coordinate (determines which links are
% in the front) 
[~, ind] = sort([links_list.wind_x]);
links_list_sorted = links_list(ind);

% extracts all the links in the front of a given link (all the links that
% block it)
for I = (1: i_links)
    linki = links_list(I);
    i_num = linki.num;
    %disp("_____")
    %disp(i_num);
  %  index = 0;
   % for J = (1: i_links)
   %     if links_list_sorted(J).num == i_num
   %         index = J;
   %     end
   % end
    %disp("****");
    %disp(J);
    %disp(i_links);
    %if index ~= 0
    %    if J == i_links
    %        required_list = links_list_sorted(J);
    %    else
    %        required_list = links_list_sorted(J,i_links);
    %    end
    %else
    %    required_list = [];
    %end
    required_list = [linki];
    for j = (1: i_links)
        link_j = links_list(j);
        if link_j.num ~= linki.num
            %disp(link_j.R_cm);
            if link_j.R_cm(1) > linki.R_cm(1)
                required_list = [required_list, link_j];
            end
        end
    end
    %disp(length(required_list));
    %if i == 10
    %    for a = (1: length(required_list))
    %        %disp(required_list(a).Y);
    %        %disp(required_list(a).Z);
    %        plot(required_list(a).poly);
    %        hold on;
    %    end
    %end
    [areaI, fracI] = Blocking(required_list,linki,length(required_list));
    list_frac_blocking(I) = fracI;
    list_blocking_area(I) = areaI;
end
%for k = (1: i_links)
%    plot(links_list(k).poly);
%    hold on;
%end
%hold on 
%plot(-Vo);
            

function [blocking_area, blocking_fraction] = Blocking(links_list,link_i,i_links)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%blocking_area = 0;
%disp("******");
%disp(link_i.num);
link_i_area = area(link_i.poly);
covered = link_i_area;
%disp(link_i_area);
other_links_poly = []; % an array of all the links other than the link being considered
for i = (1 : i_links)
    if links_list(i).num ~= link_i.num
        other_links_poly = [other_links_poly, links_list(i).poly];
    end
end
if length(other_links_poly)>1
    union_poly = union(other_links_poly);
    %plot(union_poly);
    blocked = intersect(link_i.poly, union_poly);
    blocking_area = area(blocked);
    elseif length(other_links_poly) ==1 
        blocked = intersect(link_i.poly, other_links_poly(1));
        blocking_area = area(blocked);
    else
        blocking_area = 0.0;
end
if blocking_area == 0.0
    blocking_fraction = 0.0;
else
    blocking_fraction = blocking_area / link_i_area;
end
%disp("-----");
end

function [T_iw] = wind_coordinates(V_orbit,R_I)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
x_w_hat_t  = -V_orbit/ norm(V_orbit);
x_w_hat = x_w_hat_t.';
%V_orb_t = V_orbit.'; % new addition
y_w = cross(-V_orbit, R_I);
%if norm(y_w) == 0
%    y_w_hat = y_w;
%else
y_w_hat = y_w / norm(y_w);
%end
z_w_hat = cross(x_w_hat, y_w_hat);
T_wi = [x_w_hat; y_w_hat; z_w_hat];
T_iw = T_wi.';
%r_w = r_i* T_iw;

end
function [X,Y, Z] = y_and_z(R, dw, dl, Tib, Tiw) 
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
R_y = R(2);
R_z = R(3);
R_x = R(1);
X = [0, 0, 0 ,0];
Y = [0, 0, 0, 0];
Z = [0, 0, 0, 0];
Yb = [(0 - dw/2), (0 + dw/2), (0 + dw/2), (0 - dw/2)];
Xb = [(0 - dl/2), (0 - dl/2), (0 + dl/2), (0 + dl/2)];
Zb = [0,0,0, 0];
%Rw = Tiw * R;
for a = 1:4
    coord = [Xb(a); Yb(a); Zb(a)];
    Riw = Tiw * ((Tib'* coord)+ R);
    X(a) = Riw(1);
    Y(a) = Riw(2);
    Z(a) = Riw(3);
end
end
end




