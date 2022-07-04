let storage = localStorage;
function doFirst(){
	let itemString = storage.getItem('addItemList');
    let items = itemString.substr(0,itemString.length - 2).split(', ');
    // console.log(items);   //['A1001', 'A1005', 'A1006', 'A1002']

    newDiv = document.createElement('div');
    newTable = document.createElement('table');

    // 將 table 放進 div，再將 div 放進 cartList 裡
    newDiv.appendChild(newTable)
    cartList.appendChild(newDiv)

    total = 0;
    // 每購買一個品項就呼叫 createCartList 函數新增一個 <tr>
    for(let i = 0; i < items.length; i++){
        let itemInfo = storage.getItem(items[i])
        createCartList(items[i],itemInfo)

        let itemTotalPrice = parseInt(itemInfo.split('|')[4]);
        total += itemTotalPrice
    }
    document.getElementById('total').innerText = total;
}
function createCartList(itemId, itemValue){
    // alert(`${itemId}: ${itemValue}`)
    let itemTitle = itemValue.split('|')[0];
    let itemImage = 'img/' + itemValue.split('|')[1]+`.jpg`;
    let itemPrice = parseInt(itemValue.split('|')[2]);
    let itemNum = parseInt(itemValue.split('|')[3]);
    let itemTotal = parseInt(itemValue.split('|')[4]);

    // 建立每個品項的清單區域 -- tr 
    let trItemList = document.createElement('tr');
    trItemList.className = 'item'

    newTable.appendChild(trItemList)

    // 建立商品圖片 -- 第一個 td 
    let tdImage = document.createElement('td');
    tdImage.style.width = '200px';

    let image = document.createElement('img');
    image.src = itemImage
    image.width = 150

    tdImage.appendChild(image)   
    trItemList.appendChild(tdImage)

    // 建立商品名稱和刪除按鈕 -- 第二個 td 
    let tdTitle = document.createElement('td');
    tdTitle.style.width = '280px';
    tdTitle.id = itemId

    let pTitle = document.createElement('p');
    pTitle.innerText = itemTitle

    let delButton = document.createElement('button');
    delButton.innerText = 'Delete'
    delButton.addEventListener('click',deleteItem)

    tdTitle.appendChild(pTitle)
    tdTitle.appendChild(delButton)

    trItemList.appendChild(tdTitle)

    // 建立商品價格 -- 第三個 td 
    let tdPrice = document.createElement('td');
    tdPrice.style.width = '170px';

    let pPrice = document.createElement('p');
    pPrice.innerText = itemPrice

    tdPrice.appendChild(pPrice)
    trItemList.appendChild(tdPrice)

    // 建立商品數量 -- 第四個 td 
    let tdItemCount = document.createElement('td');
    tdItemCount.style.width = '60px';

    let inputItemCount = document.createElement('input');
    inputItemCount.type = 'number'
    inputItemCount.value = itemNum
    inputItemCount.min = 1
    inputItemCount.addEventListener('input',changeItemCount)

    tdItemCount.appendChild(inputItemCount)
    trItemList.appendChild(tdItemCount)

    // 建立商品總額 -- 第五個 td(自己建的)
    let tdTotalPrice = document.createElement('td');
    tdTotalPrice.style.width = '170px';

    let pTotalPrice = document.createElement('p');
    pTotalPrice.innerText = itemTotal

    tdTotalPrice.appendChild(pTotalPrice)
    trItemList.appendChild(tdTotalPrice)
}
function deleteItem(e){
    // alert(e.target.parentNode.id);   // alert(this.parentNode.id)
    let itemId = e.target.parentNode.id;

    // 1. 先扣除金額，若要完成作業，此處也需要修正
    let itemTotalPrice = parseInt(document.getElementById(itemId).parentNode
    .childNodes[4].innerText)
    console.log(`此商品總金額: ` + itemTotalPrice)
    let total = parseInt(document.getElementById('total').innerText)
    console.log(`刪除前總金額: `+total)
    // let itemValue = storage.getItem(itemId);
    total -= itemTotalPrice;

    document.getElementById('total').innerText = total;
    console.log(`刪除後總金額: `+total)
    // 2. 清除 storage
    storage.removeItem(itemId)
    storage['addItemList'] = storage['addItemList'].replace(`${itemId}, `,``)


    // 3. 刪除該筆 <tr>
    // e.target.parentNode.parentNode.parentNode.removeChild(e.target.parentNode.parentNode)
    newTable.removeChild(e.target.parentNode.parentNode)

}
function changeItemCount(e){
    //取得Item(數量)的值
    let thisValue = e.target.value

    // e.target.parentNode == td
    // e.target.parentNode.parentNode == tr
    // e.target.parentNode.parentNode.childNodes == 包含照片, 名稱等的Table 
    // 找購物車裡以選的商品ID
    let thisId = e.target.parentNode.parentNode
    .childNodes[1].id
    // 找出storage裡的原始商品資料
    let itemInfo = storage.getItem(thisId)
    let itemPrice = parseInt(itemInfo.split('|')[2]);
    // 此商品總金額 = 商品原始金額*選擇數量
    let thisTotalPrice = itemPrice * thisValue
    // 把此商品的總金額反映到螢幕上
    e.target.parentNode.parentNode
    .childNodes[4].innerText
    = thisTotalPrice
    // storage 裡的所有商品ID
    let itemString = storage.getItem('addItemList');
    let items = itemString.substr(0,itemString.length - 2).split(', ');
    // 商品總金額
    let total = 0
    // 用迴圈取得總金額
    for(let i = 0; i < items.length; i++){
        // 取得商品
        let itemId = document.getElementById(items[i])
        // 取得此商品的金額, 先取得金額的innerText再轉成數字
        let totalPrice = parseInt(itemId.parentNode
            .childNodes[4].innerText)

        total += totalPrice
    }
    // 輸出總金額
    document.getElementById('total').innerText = total;

    // 將總金額存入Storage
    // 取得商品Storage
    oldStorageId = storage.getItem(thisId)
    // 用舊的(固定的)品名|照片|單項金額加上新的總數量|總金額
    let oldStorageArr = oldStorageId.split(`|`)
    newStorageArr = oldStorageArr[0].concat(`|${oldStorageArr[1]}`,`|${oldStorageArr[2]}`,`|${thisValue}`,`|${thisTotalPrice}`)
    storage.setItem(thisId, newStorageArr)
    
}
function goCheckout(){

    let itemString = storage.getItem('addItemList');
    let items = itemString.substr(0,itemString.length - 2).split(', ');
    // console.log(items);   //['A1001', 'A1005', 'A1006', 'A1002']

    // 設定cookie
    // 訂單ID
    document.cookie = `SessionID|ShoppingCartList=${storage.getItem('addItemList')}`;
    // 訂單詳細資料
    // 品名|圖名|單品金額|數量|總金額
    for (let i = 0; i < items.length; i++) {
        document.cookie = `SessionID|${items[i]}=${storage.getItem(items[i])}`;
    }

    // 取得現在時間
    // 2022-05-24 06:32:36
    // let date = new Date();
    // console.log(`${date.toISOString().split(`T`)[0]} ${date.toISOString().split(`T`)[1].split(`.`)[0]}`);
    
}
window.addEventListener('load', doFirst);