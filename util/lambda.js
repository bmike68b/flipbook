
exports.handler = (event, context, callback) => {
    const request = event.Records[0].cf.request;
    const headers = request.headers
    
    const response = {
        status: '200',
        statusDescription: 'OK',
        headers: {
            'content-type': [{key:'Content-Type', value: 'text/html; charset=utf-8'}],
            'content-encoding' : [{key:'Content-Encoding', value: 'utf-8'}]
        },
        bodyEncoding:'utf-8'
    };
    
    let m = request.uri.split('/')
    if(m.length==1){
        response.body = getData('../output/flipbook')
    }
    // uri like: /countryID/location
    if(m.length==3){
        response.body = getData('../output/flipbook/${m[1]}')
    }
    callback(null, response);
}

    function callback( request ){
        let m = request.uri.split('/')
        //options are:
        //1) redirect to text file
        //2) return data 
        if(m.length==1){
            response.body = getData('../output/flipbook')
        }
        // uri like: /countryID/location
        if(m.length==3){
            response.body = getData('../output/flipbook/${m[1]}')
        }
    }
    
    // exports.handler = (event, context, callback) => {
    //     if(event.string=='/'){
    //     }
    //     const response = {
    //         status: '302',
    //         statusDescription: 'Found',
    //         headers: {
    //             location: [{
    //                 key: 'Location',
    //                 value: 'http://docs.aws.amazon.com/lambda/latest/dg/lambda-edge.html',
    //             }],
    //         },
    //     };
    //     callback(null, response);
    // };

//getData('../output/flipbook')

function getData(dir) {

    var fs = require('fs'),
        path = require('path'),
        files = fs.readdirSync(dir),
        data = [];

    files.forEach(f => {
        let curr = dir +'/'+ f,
            p = path.resolve( curr )
        if ( !fs.statSync( p ).isDirectory() || !/[A-Z][A-Z]/.test(f) ) return;

        data.unshift({countryID:f, locs:[]})
        var locs = fs.readdirSync(curr + '/');

        locs.forEach(loc => {
            let locPath = curr +'/'+ loc
            if (fs.statSync(locPath).isDirectory()){
                if(loc.indexOf('.')==0) return;
                if( !fs.existsSync(locPath + '/data.js')){
                    console.log("No data file found for "+ loc)
                    return
                }
                let data = fs.readFileSync(locPath + '/data.js', {encoding:'utf-8'})
                data = eval(data)
                data[0].locs.push({loc:loc, data:data})
            }
        })
    })
    data = JSON.stringify(data)
    return data;
}