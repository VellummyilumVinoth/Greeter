import ballerina/io;

int[] salaries = [100, 300, 400];

const LENGTH = 3;
// Constants can be defined without the type. Then, the type is inferred from the right-hand side.
const MAX_VALUE = 1000;

const URL = "https://ballerina.io";

// The value for variable `msg` can only be assigned once.
final string msg = loadMessage();

// A variable of type `any` can hold any value except an `error` value.
any x = 1;

type Person record {
    int id;
    string fname;
    string lname;
};

type Coord record {
    float x;
    float y;
};

type StructuredName record {
    string firstName;
    string lastName;
};

// A `Name` type value can be either a `StructuredName` or a `string`.
type Name StructuredName|string;

// Defines a type named `MapArray`.
type MapArray map<string>[];

// `var` says that the type of the variable is from the type of expression, which is used to initialize it.
var y = "str";

function printLines(string[] sv) {
    // Type inference with a `foreach` statement.
    foreach var s in sv {
        io:println(s);
    }
}

// This function definition has two parameters of type `int`.
// The `returns` clause specifies the type of the return value.
function add(int x, int y) returns int {
    int sum = x + y;
    // The `return` statement returns a value.
    return sum;
}

// The function parameters can have default values.
function calculateWeight(decimal mass, decimal gForce = 9.8) returns decimal {
    return mass * gForce;
}

// The function returns `nil`.
function print(anydata data) {
    io:println(data);
}

public function main() {

     // Declare an int array of length 3.
    int[3] numbers = [1, 2, 3];
    io:println(numbers);
 
    // Use a constant reference as the array length.
    string[LENGTH] animals = ["cat", "dog", "mouse"];
    io:println(animals);
 
    // Declare a variable-length array.
    int[] indexes = [1, 2];
    indexes = [1, 2, 3, 4];
    io:println(indexes);
 
    // Length of the array can be inferred using `*`. The example below will declare an array of length 3.
    string[*] colors = ["red", "green", "blue"];
    io:println(colors);
 
    // Elements of an array can be accessed using member access expression.
    string firstColor = colors[0];
    io:println(firstColor);
 
    // Members of an array can be updated using member access expression in the LHS of an assignment.
    colors[0] = "pink";
    io:println(colors);
 
    string[] names = ["Mike", "Amy", "Korina"];
    // New members can be pushed to an open array by using the `array:push()` method.
    names.push("Peter");
    io:println(names);
 
    int length = names.length();
    // The `array:length()` method can be used to get the length of an array.
    io:println(length);
 
    // An element can be removed using the `array:remove(n)` method by passing the index.
    string secondPerson = names.remove(1);
    io:println(secondPerson);
    io:println(names.length());
 
    string[] fullNames = [];
    // Array can be iterated using a foreach statement.
    // There are other ways like query expressions for the same purpose.
    // This will iterate over the `names` array and create a new array by adding the surnames to each name.
    foreach string name in names {
        fullNames.push(string `${name} Johnson`);
    }

    io:println(fullNames);

    // Infer anonymous function.
    // The type of `x` is inferred from the function signature in the expected type.
    function (int) returns int increment = x => x + 1;
    io:println(increment(1));

    // The type of `x` and `y` are inferred from the function signature in the expected type.
    function (int, int) returns int add = (x, y) => x + y;
    io:println(add(1, 2));

    // The explicit anonymous function.
    // The type of the `x` parameter is explicitly defined in the function signature.
    var incrementByTwo = function(int x) returns int => x + 2;
    io:println(incrementByTwo(1));

    // The type of the `x` and `y` parameters are explicitly defined in the function signature.
    var subtract = function(int x, int y) returns int {
        return x - y;
    };
    io:println(subtract(2, 1));

     boolean flag = true;
    io:println(flag);

    int x1 = 3;
    int x2 = 2;

    // The example below will output `false`.
    io:println(x1 < x2);

    string name;
    int age;

    // The following example uses a list binding pattern to destructure the  
    // returned list and assign it to the two variables, `name` and `age`.
    // However, other binding patterns can also be used similarly.
    [name, age] = getDetails();

    io:println(name);
    io:println(age);

    // Can cast `any` to specific type.
    int n = <int>x;
    
    io:println(n);

    // The `lang.value` lang library contains functions that apply to multiple basic types.
    // `x.toString()` converts `x` to a `string`.
    string s = x.toString();

    io:println(s == "1");

    // Can test its type with the `is` operator.
    float f = x is int|float ? <float>x : 0.0;

    io:println(f);

     // List constructors are used to construct list values.
    // Arrays are lists with a uniform member type.
    string[] list = ["foo", "bar"];

    // Mapping constructors are used to construct mapping values.
    // Maps are mappings with a uniform member type.
    map<int> mapping = {x: 1, y: 2};

    // Indexing is used with lists and mappings to access members.
    // Index type of lists is `int`.
    string listMember = list[0];
    io:println(listMember);

    // Index type of mappings is `string`.
    int? mapIndex = mapping["x"];
    io:println(mapIndex);

    // A tuple type can be used to define per-index member types in a list.
    [int, string, boolean] tuple = [1, "John", true];

    int firstTupleMember = tuple[0];
    string secondTupleMember = tuple[1];
    boolean thirdTupleMember = tuple[2];

    io:println(`Tuple [${firstTupleMember}, ${secondTupleMember}, ${thirdTupleMember}]`);

    // Declares a tuple type as an open type.
    // Tuple type with zero or more boolean values after the first two members.
    [int, string, boolean...] openList = [1, "John"];
    io:println(openList);

    [int, string, boolean...] openList2 = [1, "John", true, false];
    io:println(openList2);

    // Declares a record type as an open type.
    // Record type with zero or more boolean fileds after the first two fields.
    record {|
        int id;
        string name;
        boolean...;
    |} openRecord = {id: 1, name: "John"};
    io:println(openRecord);

    record {|
        int id;
        string name;
        boolean...;
    |} openRecord2 = {id: 1, name: "John", "checked": true};
    io:println(openRecord2);

     foreach int i in 0...9 {
        // Loop breaks when the condition is satisfied.
        if (i > 5) {
            break;
        }

        io:println(i);
    }

    int i = 0;
    while true {
        // Loop breaks when the condition is satisfied.
        if i > 5 {
            break;
        }

        io:println(i);
        i = i + 1;
    }

        json j = {x: 1.0, y: 2.0};
    
    // Here, the inherent type of `j` is not a subtype of `Coord`. 
    // Therefore, `j` cannot be directly converted to `Coord`.
    // Use `cloneReadOnly()` to create a read-only copy of the mutable value `j`.
    // Then, the resulting immutable value can be casted successfully.
    json k = j.cloneReadOnly();
    Coord c = <Coord> k;
    
    io:println(c.x);
    io:println(c.y);

    int|error res = intFromBytes([104, 101, 108, 108, 111]);
    io:println(res);

        // Creates a `MapArray` value.
    // `arr` has elements which are of `map<string>` type.
    MapArray arr = [
        {"x": "foo"},
        {"y": "bar"}
    ];

    io:println(arr[0]);

    int count = getCount();

    string[] countries = getCountryList();

    io:println(count);
    io:println(countries);

    Person person = {id: 123, fname: "Jhon", lname: "Doe"};

    table<Employee> key(id) _ = table [
        {id: 1, firstName: "John", lastName: "Smith", salary: 100},
        {id: 2, firstName: "Fred", lastName: "Bloggs", salary: 200}
    ];

    Person {id: personId, fname: personFname, lname: personLname} = person;

    Person {id, fname, lname} = person;

    // Invoke the function `add` by passing the arguments.
    int sum = add(5, 11);
    // A function with no return type does not need a variable assignment.
    print(sum);

    // Invoke the `calculateWeight` function with the default arguments.
    print(calculateWeight(5));

    // The return value of the function can be ignored by assigning it to `_`.
    _ = calculateWeight(mass = 5, gForce = 10);

    EvenNumberGenerator evenGen = new ();

    // Creates a `stream` passing an `EvenNumberGenerator` object to the `stream` constructor.
    stream<int, error?> evenNumberStream = new (evenGen);

    var evenNumber = evenNumberStream.next();

    if (evenNumber !is error?) {
        io:println("Retrieved even number: ", evenNumber.value);
    }

     int[] nums = [1, 2, 3, 4];
 
    // The `from` clause works similar to a `foreach` statement.
    int[] numsTimes10 = from var num in nums
                        // The `select` clause is evaluated for each iteration.
                        select num * 10;
    io:println(numsTimes10);
 
    // A `where` clause can be used to filter iterable values.
    // It can occur multiple times anywhere between a `from` and `select` clause.
    // This will pass the frame to the `select` clause only if `i % 2 == 0` is true.
    int[] evenNums = from int num in nums
                     where num % 2 == 0
                     select num;
    io:println(evenNums);
 
    // The `order by` clause can be used to sort the result in 
    // `ascending` or `descending` order.
    int[] numsReversed = from int num in nums
                         order by num descending
                         select i;
    io:println(numsReversed);
 
    // Iterating a string value using the query expression.
    string languageName = "Ballerina";
    string newName = from var char in languageName
                     select char + char;
 
    io:println(newName);

    // `name1` is a `StructuredName`.
    Name name1 = {
        firstName: "Rowan",
        lastName: "Atkinson"
    };
    // `name2` is a `string`.
    Name name2 = "Leslie Banks";

    io:println(nameToString(name1));
    io:println(nameToString(name2));

    string[] s1 = [y, y];
    printLines(s1);

      // Apply the `new` operator with a `class` to get an `object` value.
    Engineer engineer = new Engineer("Alice");

    // Call the `getName` method using the `obj.method(args)` syntax.
    string engineerName = engineer.getName();
    io:println(engineerName);

    // Accessing the `name`  field using the `obj.field` syntax.
    engineerName = engineer.name;
    io:println(engineerName);
}

function nameToString(Name nm) returns string {
    // Checks whether `nm` belongs to `string` type.
    if nm is string {
        return nm;
    } else {
        return nm.firstName + " " + nm.lastName;
    }

}

class Engineer {
    string name;

    function init(string name) {
        self.name = name;
    }

    function getName() returns string {
        return self.name;
    }
}

// Defines a class called `EvenNumberGenerator`, which implements the `next()` method.
// This will be invoked when the `next()` method of the stream gets invoked.
class EvenNumberGenerator {
    int i = 0;
    public isolated function next() returns record {|int value;|}|error? {
        self.i += 2;
        return {value: self.i};
    }
}

// Convert `bytes` to a `string` value and then to an `int` value.
function intFromBytes(byte[] bytes) returns int|error {

    // Use `check` with an expression that may return `error`.
    // If `string:fromBytes(bytes)` returns an `error` value, `check`
    // makes the function return the `error` value here.
    // If not, the returned `string` value is used as the value of the `str` variable.
    string str = check string:fromBytes(bytes);

    return int:fromString(str);
}


function loadMessage() returns string {
    return "Hello World";
}

type PersonArray Person[];

type Building record {|
    readonly string buildingCode;
    string city;
    string state;
    string country;
    string postalCode;

    Workspace[] workspaces;
|};

type Workspace record {|
    readonly string workspaceId;
    string workspaceType;
    Building location;
    Employee employee;
|};

type Employee record {|
    readonly int id;
    string firstName;
    string lastName;
    int salary;
|};

function getDetails() returns [string, int] {
    return ["John", 30];
}

function getCountryList() returns string[] {
    string personName = "John Smith";
    io:println(personName);
    return ["SriLanka", "India", "New Zealand"];
}

function sum(float[] v) returns float {
    float r = 0.0;
    foreach int i in 0 ..< v.length() {
        r += v[i];
    }
    return r;
}

function getCount() returns int {
    int i = 0;
    if i > 1 {
        return 1;
    } else {
        return 0;
    }
}
