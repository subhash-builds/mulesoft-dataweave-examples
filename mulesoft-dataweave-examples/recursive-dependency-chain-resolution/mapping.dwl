%dw 2.0
output application/json 
fun getDepends(id)= ((payload.items filter ($.id == id))[0].depends)  default []
fun flatArray(arr) = arr flatMap (if($ is Array) flatArray($) else [$]) distinctBy ($) orderBy ($)
fun prepObjTree(id)= {
        (getDepends(id) map ( {
        ($): prepObjTree($)  default {}
    }))
    }
---
do {
    var tar= payload.target
    ---
    {
    "target": tar,
    "allDependencies": flatArray(getDepends(tar) map ([$] + getDepends($) )),
    "dependencyTree": {
            (tar): prepObjTree(tar)
    }
}
}