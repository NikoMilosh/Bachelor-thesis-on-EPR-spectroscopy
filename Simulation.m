

%Gadolinium System
close all
clear all

if 0

    
    Sys.S = 7/2;  %Spin system
    Sys.g = [2 2 2];
    %Sys = nucspinadd(Sys,'152Gd',[50 500]);
    %Sys.D = [mt2mhz(78),mt2mhz(78)/3];    %Zerofield splitting contribution to D parameters 120Mhz
    
   % A = [20 30];
    
    
 
    %Sys = nucspinadd(Sys,'14N',A);
    %Sys.lwpp = 0.5;
    Sys.lw = 20;
    
     %DStrain;

    %Exp.CenterSweep = [0 600]; % in mT
    Exp.nPoints=5001;
    Exp.Range = [100 600];      % in mT
    Exp.mwFreq = 9.4;        %Micowave frequency
    Exp.Temperature = 80; %Temperature in Kelvin
    Exp.Harmonic = 1; % first harmonic (default)
    %Exp.ModAmp = 0.9
    Exp.CrystalOrientation=[0 pi/2 0];
    
    Opt.Method = 'matrix';
    [x,spec] = pepper(Sys,Exp,Opt);
    %Opt.Method = 'perturb2';
    %[x,y2] = pepper(Sys,Exp);
    figure()
    plot(x,spec/max(spec),'b');
    xlabel('Magnetic field in Tesla','FontSize',20)
    ylabel('Intensity','FontSize',20)
    ax.FontSize = 20
    
    %hold on
end

if 0
    mySystem = struct('S',7/2,'g',[2 2 2])%,'D', [mt2mhz(28), mt2mhz(28)/3])%mt2mhz(28)/3]);
    Ori = [pi/4 pi/2]; FieldRange = [0 600]; Freq = 9.4;CrystalOrientation=[0 pi/2 0];
    
    %Ori = [pi/4 pi/2]
    mySystem2 = struct('S',7/2,'g',[2 2 2],'D', [800,0]);
    Ori = [0 0]; FieldRange = [8 600]; Freq = 9.4;
    figure()
    hold on
    levelsplot(mySystem,Ori,FieldRange,Freq);
    Ori=[pi/2 pi/2];
    
     xlabel('Magnetic field in Tesla','FontSize',20)
     ylabel('Intensity','FontSize',20)
     ax.FontSize = 20
    %levelsplot(mySystem,Ori,FieldRange,Freq);
    %hold on
    %levelsplot(mySystem2,Ori,FieldRange,Freq);
end

if 0
    figure()
    hold on
    Exp.CrystalOrientation=[0 0 0];
    [x,spec] = pepper(Sys,Exp,Opt);
    plot(x,spec)
    Exp.CrystalOrientation=[0 0 0];
    [x,spec] = pepper(Sys,Exp,Opt);
    %plot(x,spec);
    
end

%nu = mt2mhz(B)   %Calculates from mT to MHz
%28mT=784.6986MHz
%78mT=2.1859e+03MHz

if 0
    clear all
    
    for i=0:3
        for j=0:3
             mySystem = struct('S',7/2,'g',[2 2 2],'D', [mt2mhz(28), mt2mhz(28)/3])%mt2mhz(28)/3]);
             Ori = [(i/10)*pi/4 (j/10)*pi/2]; FieldRange = [0 600]; Freq = 9.4;CrystalOrientation=[(i/10)*pi/4 (j/10)*pi/2 pi/2];
             %figure()
            %hold on
            levelsplot(mySystem,CrystalOrientation,FieldRange,Freq);
        end
    end
end


if 0
    clear all
    allspec=0
    for i=0:3
        for j=0:3
            Exp.nPoints=5001;
            Exp.Range = [100 600];      % in mT
            Exp.mwFreq = [9.4];        %Micowave frequency
            Exp.Temperature = 80; %Temperature in Kelvin
            Exp.Harmonic = 1; % first harmonic (default)
            %Exp.ModAmp = 0.9
            Opt.Method = 'matrix';
            Exp.CrystalOrientation=[(i/10)*pi/2 (j/10)*pi/2  pi/2];
            Exp.FieldRange = [0 600]; 
            %Exp.Freq = 9.4;
            %Sys.lwpp = 10; 
            Sys = struct('S',7/2,'g',[2 2 2],'lwpp',  20,'D', [mt2mhz(28), mt2mhz(28)/3])%mt2mhz(28)/3]);
            
            %figure()
            %hold on
            
            %for k=1:10
            [x,spec] = pepper(Sys,Exp,Opt);
      
            %plot(x,spec/max(spec),'b','LineWidth',8);
            
            xlabel('Magnetic field in Tesla','FontSize',30)
            ylabel('Intensity','FontSize',30)
            ax.FontSize = 20
                allspec=allspec+spec;
                %all_spec=[all_spec,spec];
                
          %  end
            
            
                
                
        end
            
       end
        figure()
             
            plot(x,allspec,'b','LineWidth',2);
            ax = gca;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
            xlabel('Magnetic field in Tesla','FontSize',30)
            ylabel('Intensity','FontSize',30)
    end

if 1
    clear all
    
    for i=0:0
        for j=0:0
            
            Exp.nPoints=5001;
            %Exp.Range = [100 600];      % in mT
            Exp.mwFreq = 9.4;        %Micowave frequency
            Exp.Temperature = 80; %Temperature in Kelvin
            Exp.Harmonic = 1; % first harmonic (default)
            %Exp.ModAmp = 0.9
            Opt.Method = 'matrix';
            %Exp.CrystalOrientation=[(i/10)*pi/2 (j/10)*pi/2  pi/2];
            %Exp.FieldRange = [0 600]; 
            %Exp.Freq = 9.4;
            %Sys.lwpp = 10; 
            Sys = struct('S',7/2,'g',[2 2 2],'lwpp',  20)%,'D', [mt2mhz(28), mt2mhz(28)/3])%mt2mhz(28)/3]);
            Ori= [(i/10)*pi/4 (j/10)*pi/2]
            FieldRange=[0 600]
            Freq=9.4
            %figure()
            hold on
            
            %[x,spec] = pepper(Sys,Exp,Opt);
            levelsplot(Sys,Ori,FieldRange,Freq);
            ax.XAxis.FontSize = 15;
            ax.YAxis.FontSize = 15;
            %levelsplot(Sys,FieldRange,Freq);
            xlabel('Magnetic field in Tesla','FontSize',30)
            ylabel('Intensity','FontSize',30)
            ax.FontSize = 20
            
            %for k=0:length(spec)
             %   spec{k}=spec{k}+spec{k-1}
             %   return [spec]
              %  plot(x,spec/max(spec)
           % end
            
       end
        
    end
end


if 0
    clear all
    
    
            Exp.nPoints=5001;
            %Exp.Range = [100 600];      % in mT
            Exp.mwFreq = 90.4;        %Micowave frequency
            Exp.Temperature = 80; %Temperature in Kelvin
            Exp.Harmonic = 1; % first harmonic (default)
            %Exp.ModAmp = 0.9
            Opt.Method = 'matrix';
            %Exp.CrystalOrientation=[(i/10)*pi/2 (j/10)*pi/2  pi/2];
            %Exp.FieldRange = [0 600]; 
            %Exp.Freq = 9.4;
            %Sys.lwpp = 10; 
            Sys = struct('S',7/2,'g',[2 2 2],'lwpp',  20)%,'D', [mt2mhz(28), mt2mhz(28)/3])%mt2mhz(28)/3]);
            %Ori= [(i/10)*pi/4 (j/10)*pi/2]
            FieldRange=[0 1000]
            Freq=90.4
            %figure()
            hold on
            
            %[x,spec] = pepper(Sys,Exp,Opt);
            levelsplot(Sys,FieldRange,Freq);
            %levelsplot(Sys,Ori,FieldRange,Freq);
            
            %for k=0:length(spec)
             %   spec{k}=spec{k}+spec{k-1}
             %   return [spec]
              %  plot(x,spec/max(spec)
           % end
            
       end
        
  