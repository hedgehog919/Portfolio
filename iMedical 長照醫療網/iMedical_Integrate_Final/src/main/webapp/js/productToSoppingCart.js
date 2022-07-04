let storage = localStorage;
function doFirst(){
    if(storage['addItemList'] == null){
        storage['addItemList'] = '';    //storage.setItem('addItemList','')  
    }

    // 幫每個 Add Cart 建立事件聆聽
    let list = document.querySelectorAll('.addButton');   // list 是陣列//即class = btn btn-primary addButton
	console.log(list.length)
    for(let i = 0; i < list.length; i++){
        list[i].addEventListener('click',function(e){
            // alert(e.target.id)  // alert(this.id)
            let teddyInfo = document.querySelector(`#${e.target.id} input`).value
			//querySelector不能用數字當頭
            // alert(teddyInfo)
            addItem(e.target.id,teddyInfo)
        });
    }
}

// let items = 0;
// let subtotal = 0;

function addItem(itemId, itemValue){

    let price = document.createElement('span');

    // 存入 storage
    if(storage[itemId]){
        alert(`You have checked.`)
    }else{
        storage['addItemList'] += `${itemId}, `;
        console.log(itemValue.concat(`|1|${price}`))
        // 自己加上數量總金額
        newItemValue = itemValue.concat(`|1|${itemValue.split('|')[2]}`)
        storage.setItem(itemId, newItemValue)
        alert(`加入購物車`);
    }
}
window.addEventListener('load', doFirst);
