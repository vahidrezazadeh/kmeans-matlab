function z=Kmeans2(list,k)
    
    N=numel(list);
    
    %% entekhabe K andis baraye markaze khooshe ha
    nums=randperm(N-1,k);
    nums=nums+1;
    
    %% daryafte maghadere marakez ba tavajoh be andis ha
    nums=list(nums);
    
    %% yek sakhtar baraye maghadire khorooji misazim
    emp.sol=[];
     z=repmat(emp,k,1);
     %% yek sakhtare komaki
    help=repmat(emp,k,1);
    for i=1:N
        %% mohasebe fasele har meghdar ba markaz ha
        h=[];
        for j=1:k
            h=[h abs(nums(j)-list(i))];
        end
        %%entekhabe kamtarin meghdar va afzoodan meghdar be an markaz
        [~,index]=min(h);
         z(index).sol=[z(index).sol list(i)];
    end
    %%tekrare marahele ghabl ta emteme algorithm
    while(true)
        for i=1:k
            nums(i)=mean(z(i).sol);
        end
        
        for i=1:N
            h=[];
            for j=1:k
                h=[h abs(nums(j)-list(i))];
            end
            [~,index]=min(h);
            help(index).sol=[help(index).sol list(i)];

        end
        %% moghayese khooshe haye jadid ba ghabli 
        %% agar mosavi boodand barname tamam ast
        
        if (CompareMat(help,z)==true)
            break;
        end
        z=help;
        help=repmat(emp,k,1);
     end

end
%% in function 2 sakhtar ra ba ham moghayese mikonad
function z=CompareMat(mat1,mat2)
    
    N=numel(mat2);
    sumn=0;
    for i=1:N
        if isequal(mat1(i).sol,mat2(i).sol)
           sumn=sumn+1;
        end
    end
    if sumn==N
        z=true;
    else
        z=false;
    end
    
end