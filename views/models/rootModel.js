import $ from 'jquery';

export default class RootModel{
    constructor(){}

    sendPost(url, data){
        $.ajax({
            type: 'POST',
            url: url,
            data: data,
            success: (response) => {
                console.log(response);
            },
            dataType: 'json'
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
