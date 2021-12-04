classdef Person
    properties
        name=""
        age
    end
    methods (Abstract=true)
        sayHello(obj)
        doThings(obj)
    end
end