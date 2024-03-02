function chromosome = CreateCar(MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC)
     Res = true;
     while Res
          [chromosome,Result] = CreateCarLocation(MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);
          if Result == false
              Result = IsOverLapHappend(chromosome,MachineNumber,LengthWorkshop,WidthWorkshop,L,W,LoC,WoC,XoC,YoC);
          end
          Res = Result;
          %Overlaps(i) = Overlap_Machines(chromosomes(i,:),L,W,Lo,Wo,Xo,Yo,ylower,yupper,xlower,xupper);   
     end
end
