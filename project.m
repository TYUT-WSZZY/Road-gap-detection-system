function [projectr, projectc] = Project(bw)                                %计算行列投影
projectr = sum(bw, 2);                                                     %行投影
projectc = sum(bw, 1);                                                     %列投影
