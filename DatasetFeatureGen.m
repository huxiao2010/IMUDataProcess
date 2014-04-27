%%
%
function do()
    [train,trainy,test,testy] = read(1,20);
    trainfeatures = featuregen(train);
    testfeatures  = featuregen(test);
    save('trainfeatures.mat','trainfeatures');
    save('testfeatures.mat','testfeatures');
end

function [features] = featuregen(data)
    [m,n] = size(data);
    features = [];
    for i = 1:m
        line = data(i,:);
        item = zeros(6,96);
        for j = 1:6
            idx = 1;
            for k = 1:96
                item(j,idx) = line(1,(k-1)*6+j);
                idx = idx + 1;
            end
        end
        [feature] =  SingleFeatureGen(item);
        features(end+1,:) = feature;
    end
end
function [train,trainy,test,testy]=read(tstart,tend)
    train = [];
    trainy= [];
    test  = [];
    testy = [];
    path = 'D:\΢������\357812021\WorkSpace\TsinghuaLab\data\6dmg\';
    load(strcat(path,'train96.mat'),'train_data','train_y');
    load(strcat(path,'test96.mat'),'test_data','test_y');
    
    startp = 0;
    for i = 1:length(train_y)
        if train_y(i,1) == tstart
            startp = i;
            break;
        end
    end
    for endp = startp: length(train_y)
        if train_y(endp,1) == tend + 1
            endp = endp - 1;
            break;
        end
    end
    
    train = train_data(startp:endp,:);
    trainy= train_y(startp:endp,:);
    clear train_data train_y;
    
    startp = 0;
    for i = 1: length(test_y)
        if test_y(i,1) == tstart
            startp = i;
            break
        end
    end
    for endp = startp : length(test_y)
        if test_y(endp,1) == tend + 1
            endp = endp - 1;
            break;
        end;
    end
    test = test_data(startp:endp,:);
    testy= test_y(startp:endp,:);
    clear test_data test_y; %release mem
end