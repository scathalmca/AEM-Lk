


[FileMatrix, ResMatrix] = ReadFile("Input Text File.txt");

SimResMatrix = [];
SimQMatrix = [];
SimFiles=[];


Accuracy=0.1;

SimCounter("new");
EndResonators(0, 0, 0, "new");

tic



%%%
%End Matrices
KInductance =[];
EndSimRes =[];
EndSimQ =[];



for i =1:numel(FileMatrix)
    


    Project = SonnetProject(char(FileMatrix(i)));
    str=append("TestResonator_Num",num2str(i), ".son");
    Project.saveAs(str);

    Project = SonnetProject(str);

   

    upper_bound = (str2double(cell2mat(ResMatrix(i)))/1000)+0.5;
    lower_bound = (str2double(cell2mat(ResMatrix(i)))/1000)-0.5;

    while true
        try


            [SimRes, SimQ, Warning] = Auto_Sim(Project, upper_bound, lower_bound);

            break

        catch ME
            warning("Something Broke! Retrying...");

            Project.cleanProject;

            

        end
    end

    old_son_file=str;

    str_son=num2str(SimRes)+"GHz.son";

    str_csv_old=erase(str, ".son")+".csv";

    str_csv_new=num2str(SimRes)+"GHz.csv";

    Project.saveAs(str_son);


    movefile(str_csv_old, str_csv_new);

    delete(old_son_file);

    SimResMatrix = [SimResMatrix  SimRes];

    SimQMatrix = [SimQMatrix    SimQ];
    
    SimFiles = [SimFiles  str_son];

end



for i = 1:numel(FileMatrix)



        Project = SonnetProject(SimFiles(i));


        Measured_Res = (str2double(cell2mat(ResMatrix(i)))/1000);



        [Lk, SimRes, SimQ, Project]=Param_Lk(Project, SimResMatrix(i), SimQMatrix(i), Measured_Res, Accuracy);

        

        EndResonators(SimRes, SimQ, Project.Filename, "add");
        


        KInductance = [KInductance  Lk];

        EndSimRes = [EndSimRes  SimRes];

        EndSimQ = [EndSimQ  SimQ];


  

end




Counter = SimCounter("get"); 
toc;

txtfile=fopen("Kinetic Inductance Data File.txt", "w+");
% Stop timer and calculate elapsed time
elapsedTime = toc;

% Calculate time in hours, minutes, and seconds
hours = num2str(floor(elapsedTime / 3600));
minutes = num2str(floor(mod(elapsedTime, 3600) / 60));
seconds = num2str(mod(elapsedTime, 60));




% Print the value to the file with a "|" separator
% Display runtime in format hours/minutes/seconds
fprintf(txtfile,'%s%s%s%s%s%s%s',"Runtime| ","Hours: ", hours,"  Minutes: ", minutes, "  Seconds: ",seconds);
fprintf(txtfile, "\n");
fprintf(txtfile,"%s%s", "Number of Simulations Performed: ", num2str(Counter));
fprintf(txtfile, "\n");
fprintf(txtfile,"%s%s%s", "Set Accuracy = ", num2str(Accuracy),"pH/sq");
fprintf(txtfile, "\n");
fprintf(txtfile,"%s%s", "Mean Lk =  ", num2str(mean(KInductance)), "pH/sq");
fprintf(txtfile, "\n");
fprintf(txtfile,"%s%s", "STD =  ", num2str(std(KInductance)), "pH/sq");
fprintf(txtfile, "\n");

fprintf(txtfile, "\n");
fprintf(txtfile, '%s%s', "|",repmat('_', 1, 6),"FileName", repmat('_', 1, 6));
fprintf(txtfile, '%s%s', "|",repmat('_', 1, 6),"Measured Resonances(MHz)", repmat('_', 1, 6));
fprintf(txtfile, '%s%s', "|",repmat('_', 1, 6),"Simulated Resonances(MHz)", repmat('_', 1, 6));
fprintf(txtfile, '%s%s', "|",repmat('_', 1, 6),"Kinetic Inductance", repmat('_', 1, 6));
fprintf(txtfile, '%s%s%s%s%s', "|",repmat('_', 1, 6),"Simulated Q-Factor", repmat('_', 1, 6), "|");


%Need to change user_frequencies because frequencies can occur more than
%once, so cant use normal indexing


[all_Resonances, all_QFactors, all_Filenames] = EndResonators(0, 0, 0, "get");

mkdir FinishedSimulations
for i=1:numel(all_Resonances)

    fprintf(txtfile, "\n");
    

    fprintf(txtfile, "%s %30s %36.2f %36.2f %36.2f", all_Filenames(i),char(ResMatrix(i,:)), all_Resonances(i)*1000, KInductance(i),all_QFactors(i));

    movefile(all_Filenames(i),'FinishedSimulations\');

    csv_name = erase(all_Filenames(i), ".son")+".csv";

    movefile(csv_name,'FinishedSimulations\');

    
end


fclose(txtfile);

    




