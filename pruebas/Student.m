classdef Student<Person
    methods
        function obj = Student(name, age)
            obj.name = name;
            obj.age = age;
        end
        function sayHello(obj)
            fprintf("Hi, my name is %s\n", obj.name);
            fprintf("I am %d years old\n", obj.age);
            fprintf("and I'm student\n");
        end
        function doThings(obj)
            fprintf("Studing\n");
        end
    end
end