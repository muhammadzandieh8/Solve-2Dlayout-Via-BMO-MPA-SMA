function  DrawMap(algorithmName,LengthWorkshop,WidthWorkshop,chromosomes,tempval,W,L,LoC,WoC,XoC,YoC)
addpath(genpath('..'))
numShapes = size(chromosomes, 1);
numRows = 1;
numCols = ceil(numShapes / numRows);
figure;
hold on;
title('XXX');
for z = 1:numShapes
    subplot(numRows, numCols, z);
    rectangle('Position', [0, 0, LengthWorkshop, WidthWorkshop], 'EdgeColor', 'k', 'LineWidth', 2);
    for i = 1:size(chromosomes, 2)
        Theta = (pi / 2) * chromosomes(z,i).Orientation;
        new_L = floor(abs(L(i) * cos(Theta)) + abs(sin(Theta) *W(i)));
        new_W = floor(abs(W(i) * cos(Theta)) + abs(sin(Theta) *L(i)));
        %rectangle('Position', [chromosomes(z,i).X - new_L/2,chromosomes(z,i).Y - new_W/2, new_L, new_W], 'EdgeColor', 'y', 'LineWidth', 2);
        rectangle('Position', [chromosomes(z,i).X - new_L/2,chromosomes(z,i).Y - new_W/2, new_L, new_W], 'EdgeColor', 'y', 'FaceColor', 'y', 'LineWidth', 2);

        text(chromosomes(z,i).X, chromosomes(z,i).Y, num2str(i), 'Color', 'b', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontWeight', 'bold');
    end
    for i = 1:size(LoC, 2)
        % rectangle('Position', [Xo(i)-Lo(i)/2, Yo(i)-Wo(i)/2, Lo(i), Wo(i)], 'EdgeColor', 'r', 'LineWidth', 2);
        rectangle('Position', [XoC(i)-LoC(i)/2, YoC(i)-WoC(i)/2, LoC(i), WoC(i)], 'EdgeColor', 'r','FaceColor', 'r' ,'LineWidth', 2);

    end
    OverLapResult = IsOverLapHappend(chromosomes(i,:),size(chromosomes, 2),LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);
%     overlapPercentage = Overlap_Machines(chromosomes(i,:),L,W,Lo,Wo,Xo,Yo);
    resultstrcat = ['Algorithm: ',algorithmName, ' Figure:  ' , num2str(z)  , '           MHC:  ' , num2str(tempval(z)), '    OverLap:',num2str(OverLapResult)];
    
    %resultstrcat = ['Algorithm: ',algorithmName, ' Figure:  ' , num2str(z)  , '           MHC:  ' , num2str(tempval(z)), '    OverLap:',num2str(OverLapResult), '   Overlap: ',num2str(overlapPercentage)];

    title([resultstrcat]);
    xlabel('X Axis');
    ylabel('Y Axis');
    axis('tight');
    axis equal;
    disp(['Shape No:   ' num2str(numShapes), '          MHC: ' , num2str(tempval(z)),'     Overlap: ',num2str(OverLapResult)]);
    strArray=sprintf('%02d, ',chromosomes(z,:).X);
    disp(['X:          ',strArray]);
    strArray=sprintf('%02d, ',chromosomes(z,:).Y);
    disp(['Y:          ',strArray]);
    strArray=sprintf('%02d, ',chromosomes(z,:).Orientation);
    disp(['Orientation:',strArray]);
end
hold off;
end



