import $ from 'jquery';

export default class RootModel{
    constructor(){}

    sendPost(url, data, callback){
        let json_data = JSON.stringify(data);

        $.ajax({
            type: 'POST',
            url: url,
            data: json_data,
            success: (response) => {
                if(callback == null){
                    console.log(response);
                    return null;
                }else{
                    return callback(response);
                }
            },
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
        });
    }

    sendGet(url, callback){
        $.ajax({
            type: 'GET',
            url: url,
            success: (response) => {
                if(callback == null){
                    console.log(response);
                    return null;
                }else{
                    return callback(response);
                }
            }
        });
    }
}
