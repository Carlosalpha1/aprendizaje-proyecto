clear all; close all; clc;

person1 = Worker("Juan", 30, "teacher");
person1.sayHello();
person1.doThings();

fprintf("\n");

person2 = Student("Cristina",  14);
person2.sayHello();
person2.doThings();

fprintf("\nUsing foo function\n");
foo(person1)
foo(person2)

function foo (person)
    person.sayHello();
end