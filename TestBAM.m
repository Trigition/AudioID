function out = TestBAM( input_args )
    %Construct File Paths
    DogFilePath = 'proj2out/i/dog';
    ElepFilePath = 'proj2out/i/elep';
    GirFilePath = 'proj2out/i/girf';
    
    BiplaneFilePath = 'proj2out/ii/biplanes';
    JetFilePath = 'proj2out/ii/jetfighters';
    AirbusFilePath = 'proj2out/ii/passengers';
    
    ShipFilePath = 'proj2out/iii/ships';
    SubFilePath = 'proj2out/iii/subs';
    WhaleFilePath = 'proj2out/iii/whales';
    %Define Class Vectors
    DogClass = [1 -1 -1 1 1 -1];
    BiplaneClass = DogClass'
    ShipClass = DogClass;
    ElepClass = [1 1 -1 -1 -1 -1];
    JetClass = ElepClass;
    SubClass = ElepClass;
    GirClass = [1 1 1 -1 1 1];
    AirbusClass = GirClass;
    WhaleClass = GirClass;
    
    %Define Centroid Matrices
    DogCentroid = Weight(DogFilePath);
    ElepCentroid = Weight(ElepFilePath);
    GirCentroid = Weight(GirFilePath);
    
    BiplaneCentroid = Weight(BiplaneFilePath);
    JetCentroid = Weight(JetFilePath);
    AirbusCentroid = Weight(AirbusFilePath);
    
    ShipCentroid = Weight(ShipFilePath);
    SubCentroid = Weight(SubFilePath);
    WhaleCentroid = Weight(WhaleFilePath);
    
    %Get File names
    DogImages = dir('proj2out/i/dog/*jpg');
    ElepImages = dir('proj2out/i/elep/*jpg');
    GirImages = dir('proj2out/i/girf/*jpg');
    
    BiplaneImages = dir('proj2out/ii/biplanes/*jpg');
    JetImages = dir('proj2out/ii/jetfighters/*jpg');
    AirbusImages = dir('proj2out/ii/passengers/*jpg');
    
    ShipImages = dir('proj2out/iii/ships/*jpg');
    SubImages = dir('proj2out/iii/subs/*jpg');
    WhaleImages = dir('proj2out/iii/whales/*jpg');
    
    %Test Dog Images
    AnimalCentroid = centroidMatrix(DogCentroid, ElepCentroid, GirCentroid);
    AnimalClass = classMatrix(DogClass, ElepClass, GirClass);
    Dogs_Dog = 0;
    Elephants_Dog = 0;
    Giraffes_Dog = 0;
    for i=1:length(DogImages)
       DogFile = getfield(DogImages(i), 'name');
       TestVector = Weight(strcat(DogFilePath,'/',DogFile));
       ResultVector = bam(TestVector, AnimalCentroid, AnimalClass);
       if (isequal(ResultVector, DogClass))
          Dogs_Dog = Dogs_Dog + 1;
       elseif (isequal(ResultVector, ElepClass))
           Elephants_Dog = Elephants_Dog + 1;
       elseif (isequal(ResultVector, GirClass))
           Giraffes_Dog = Giraffes_Dog + 1;
    end
    %Test Elephant Images
    Dogs_Elephant = 0;
    Elephants_Elephant = 0;
    Giraffes_Elephant = 0;
    for i=1:length(ElepImages)
       ElepFile = getfield(ElepImages(i), 'name');
       TestVector = Weight(strcat(ElepFilePath,'/',ElepFile));
       ResultVector = bam(TestVector, AnimalCentroid, AnimalClass);
       if (isequal(ResultVector, DogClass))
          Dogs_Elephant = Dogs_Elephant + 1;
       elseif (isequal(ResultVector, ElepClass))
          Elephants_Elephant = Elephants_Elephant + 1;
       elseif (isequal(ResultVector, GirClass))
           Giraffes_Elephant = Giraffes_Elephant + 1;
       end
    end
    %Test Giraffe Images
    Dogs_Giraffe = 0;
    Elephants_Giraffe = 0;
    Giraffes_Giraffe = 0;
    for i=1:length(GirImages)
       GirFile = getfield(GirImages(i), 'name');
       TestVector = Weight(strcat(GirFilePath,'/',GirFile));
       ResultVector = bam(TestVector, AnimalCentroid, AnimalClass);
       if (isequal(ResultVector, DogClass))
          Dogs_Giraffe = Dogs_Giraffe + 1;
       elseif (isequal(ResultVector, ElepClass))
           Elephants_Giraffe = Elephants_Giraffe + 1;
       elseif (isequal(ResultVector, GirClass))
           Giraffes_Giraffe = Giraffes_Giraffe + 1;
       end
    end
    
    %Test Biplane Images
    PlaneCentroid = centroidMatrix(BiplaneCentroid, JetCentroid, AirbusCentroid);
    PlaneClass = classMatrix(DogClass, ElepClass, GirClass);
    Biplanes_Biplane = 0;
    Jets_Biplane = 0;
    Airbuses_Biplane = 0;
    for i=1:length(BiplaneImages)
       BiplaneFile = getfield(BiplaneImages(i), 'name');
       TestVector = Weight(strcat(BiplaneFilePath,'/',BiplaneFile));
       ResultVector = bam(TestVector, PlaneCentroid, PlaneClass);
       if (isequal(ResultVector, BiplaneClass))
          Biplanes_Biplane = Biplanes_Biplane + 1;
       elseif (isequal(ResultVector, JetClass))
          Jets_Biplane = Jets_Biplane + 1;
       elseif (isequal(ResultVector, AirbusClass))
          Airbuses_Biplane = Airbuses_Biplane + 1;
       end
    end
    %Test Jet Images
    Biplanes_Jet = 0;
    Jets_Jet = 0;
    Airbuses_Jet = 0;
    for i=1:length(JetImages)
       JetFile = getfield(JetImages(i), 'name');
       TestVector = Weight(strcat(JetFilePath,'/',JetFile));
       ResultVector = bam(TestVector, PlaneCentroid, PlaneClass);
       if (isequal(ResultVector, BiplaneClass))
          Biplanes_Jet = Biplanes_Jet + 1;
       elseif (isequal(ResultVector, JetClass))
          Jets_Jet = Jets_Jet + 1;
       elseif (isequal(ResultVector, AirbusClass))
          Airbuses_Jet = Airbuses_Jet + 1;
       end
    end
    %Test Airbus Images
    Biplanes_Airbus = 0;
    Jets_Airbus = 0;
    Airbuses_Airbus = 0;
    for i=1:length(AirbusImages)
       AirbusFile = getfield(AirbusImages(i), 'name');
       TestVector = Weight(strcat(AirbusFilePath,'/',AirbusFile));
       ResultVector = bam(TestVector, PlaneCentroid, PlaneClass);
       if (isequal(ResultVector, BiplaneClass))
          Biplanes_Airbus = Biplanes_Airbus + 1;
       elseif (isequal(ResultVector, JetClass))
          Jets_Airbus = Jets_Airbus + 1;
       elseif (isequal(ResultVector, AirbusClass))
          Airbuses_Airbus = Airbuses_Airbus + 1;
       end
    end
    
    MarineCentroid = centroidMatrix(ShipCentroid, SubCentroid, WhaleCentroid);
    MarineClass = classMatrix(ShipClass, SubClass, WhaleClass);
    Ships_Ship = 0;
    Subs_Ship = 0;
    Whales_Ship = 0;
    for i=1:length(ShipImages)
       ShipFile = getfield(ShipImages(i), 'name');
       TestVector = Weight(strcat(ShipFilePath,'/',ShipFile));
       ResultVector = bam(TestVector, MarineCentroid, MarineClass);
       if (isequal(ResultVector, ShipClass))
          Ships_Ship = Ships_Ship + 1;
       elseif (isequal(ResultVector, SubClass))
          Subs_Ship = Subs_Ship + 1;
       elseif (isequal(ResultVector, WhaleClass))
          Whales_Ship = Whales_Ship + 1;
       end
    end
    Ships_Sub = 0;
    Subs_Sub = 0;
    Whales_Sub = 0;;
    for i=1:length(SubImages)
       SubFile = getfield(SubImages(i), 'name');
       TestVector = Weight(strcat(SubFilePath,'/',SubFile));
       ResultVector = bam(TestVector, MarineCentroid, MarineClass);
       if (isequal(ResultVector, ShipClass))
          Ships_Sub = Ships_Sub + 1;
       elseif (isequal(ResultVector, SubClass))
          Subs_Sub = Subs_Sub + 1;
       elseif (isequal(ResultVector, WhaleClass))
          Whales_Sub = Whales_Sub + 1;
       end
    end
    
    Ships_Whale = 0;
    Subs_Whale = 0;
    Whales_Whale = 0;
    for i=1:length(WhaleImages)
       WhaleFile = getfield(WhaleImages(i), 'name');
       TestVector = Weight(strcat(WhaleFilePath,'/',WhaleFile));
       ResultVector = bam(TestVector, MarineCentroid, MarineClass);
       if (isequal(ResultVector, ShipClass))
          Ships_Whale = Ships_Whale + 1;
       elseif (isequal(ResultVector, SubClass))
          Subs_Whale = Subs_Whale + 1;
       elseif (isequal(ResultVector, WhaleClass))
          Whales_Whale = Whales_Whale + 1;
       end
    end

    fprintf('ANIMAL RESULTS:\n');
    fprintf('\tDog results: \n');
    fprintf('\t\tAs Dogs:      %d\n', Dogs_Dog);
    fprintf('\t\tAs Elephants: %d\n', Elephants_Dog);
    fprintf('\t\tAs Giraffes:  %d\n', Giraffes_Dog);
    fprintf('\tElephant results: \n');
    fprintf('\t\tAs Dogs:      %d\n', Dogs_Elephant);
    fprintf('\t\tAs Elephants: %d\n', Elephants_Elephant);
    fprintf('\t\tAs Giraffes:  %d\n', Giraffes_Elephant);
    fprintf('\tGiraffe results: \n');
    fprintf('\t\tAs Dogs:      %d\n', Dogs_Giraffe);
    fprintf('\t\tAs Elephants: %d\n', Elephants_Giraffe);
    fprintf('\t\tAs Giraffes:  %d\n', Giraffes_Giraffe);
    fprintf('PLANE RESULTS:\n');
    fprintf('\tBiplane Results:\n');
    fprintf('\t\tAs Biplanes:  %d\n', Biplanes_Biplane);
    fprintf('\t\tAs Jets:      %d\n', Jets_Biplane);
    fprintf('\t\tAs Airbuses:  %d\n', Airbuses_Biplane);
    fprintf('\tJet Results:\n');
    fprintf('\t\tAs Biplanes:  %d\n', Biplanes_Jet);
    fprintf('\t\tAs Jets:      %d\n', Jets_Jet);
    fprintf('\t\tAs Airbuses:  %d\n', Airbuses_Jet);
    fprintf('\tAirbus Results:\n');
    fprintf('\t\tAs Biplanes:  %d\n', Biplanes_Airbus);
    fprintf('\t\tAs Jets:      %d\n', Jets_Airbus);
    fprintf('\t\tAs Airbuses:  %d\n', Airbuses_Airbus);
    fprintf('MARINE RESULTS\n');
    fprintf('\tShip Results:\n');
    fprintf('\t\tAs Ships:      %d\n', Ships_Ship);
    fprintf('\t\tAs Submarines: %d\n', Subs_Ship);
    fprintf('\t\tAs Whales:     %d\n', Whales_Ship);
    fprintf('\tSubmarine Results:\n');
    fprintf('\t\tAs Ships:      %d\n', Ships_Sub);
    fprintf('\t\tAs Submarines: %d\n', Subs_Sub);
    fprintf('\t\tAs Whales:     %d\n', Whales_Sub);
    fprintf('\tWhale Results:\n');
    fprintf('\t\tAs Ships:      %d\n', Ships_Whale);
    fprintf('\t\tAs Submarines: %d\n', Subs_Whale);
    fprintf('\t\tAs Whales:     %d\n', Whales_Whale);    
    out = 0;
end

