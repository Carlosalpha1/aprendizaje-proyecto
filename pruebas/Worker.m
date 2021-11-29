classdef Worker<Person
    properties
        profession = "nada"
    end
    methods
        function obj = Worker(name, age, profession)
            obj.name = name;
            obj.age = age;
            obj.profession = profession;
        end
        function sayHello(obj)
            fprintf("Hi, my name is %s\n", obj.name);
            fprintf("I am %d years old\n", obj.age);
            fprintf("and I'm %s\n", obj.profession);
        end
        function doThings(obj)
            fprintf("Working\n");
        end
    end
end