function findDuplicates(arr){
    let view = new Set();
    let duplicates = new Set();
    for(let num of arr){
        if(view.has(num)){
            duplicates.add(num);
        }
        view.add(num);
    }
    return Array.from(duplicates);
}

//Test

console.log(findDuplicates([1, 2, 3, 4, 2, 5, 6, 3])); // Output: [2, 3]
console.log(findDuplicates([7, 8, 9, 10])); // Output: []
console.log(findDuplicates([1, 1, 1, 2, 2, 3])); // Output: [1, 2]