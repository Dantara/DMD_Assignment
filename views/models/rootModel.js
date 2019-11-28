import $ from 'jquery';

export default class RootModel{
    constructor(){}

    sendPost(url, data){
        let json_data = JSON.stringify(data);

        $.ajax({
            type: 'POST',
            url: url,
            data: json_data,
            success: (response) => {
                console.log(response);
            },
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
        });
    }

    sendGet(url){
        $.ajax({
            type: 'GET',
            url: url,
            success: (response) => {
                console.log(response);
            }
        });
    }
}
