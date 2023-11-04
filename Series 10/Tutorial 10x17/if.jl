# conditions

x, y = 1, 2

x, y = y, x

x = y

# tasks

task_1() = println("$x > $y")

task_2() = println("$x < $y")

task_3() = println("$x == $y")

# if expression

if x > y
    task_1()
elseif x < y
    task_2()
else
    task_3()
end
