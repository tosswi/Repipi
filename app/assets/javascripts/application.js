// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.raty
//= require ratyrate
//= require rails-ujs
//= require bxslider
//= require activestorage
//= require bootstrap-sprockets
//= require cocoon
//= require_tree .



$(document).ready(function () {
  $('.bxslider').bxSlider({
    auto: true, // 自動スライド
    speed: 5000, // スライドするスピード
    moveSlides: 1, // 移動するスライド数
    pause: 500, // 自動スライドの待ち時間
    maxSlides: 5, // 一度に表示させる最大数
    slideWidth: 250, // 各スライドの幅
    randomStart: true, // 最初に表示するスライドをランダムに設定
    pager: false,
    auto: true,
    controls: true
  });
});
$(function () {
  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[type=file]')
  //fileが選択された時に発火するイベント
  $('#img-file').change(function () {
    //選択したfileのオブジェクトをpropで取得
    var file = $('input[type="file"]').prop('files')[0];
    //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
    var fileReader = new FileReader();
    //読み込みが完了すると、srcにfileのURLを格納
    fileReader.onloadend = function () {
      var src = fileReader.result
      var html = `<img src="${src}" width="114" height="80">`
      //image_box__container要素の前にhtmlを差し込む
      $('#image-box__container').before(html);
    }
    fileReader.readAsDataURL(file);
  });
});



$(document).on("click", '.item-image__operetion--delete', function () {
  //プレビュー要素を取得
  var target_image = $(this).parent().parent()
  //プレビューを削除
  target_image.remove();
  //inputタグに入ったファイルを削除
  file_field.val("")
})



$(function () {
  //DataTransferオブジェクトで、データを格納する箱を作る
  var dataBox = new DataTransfer();
  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[type=file]')
  //fileが選択された時に発火するイベント
  $('#img-file').change(function () {
    //選択したfileのオブジェクトをpropで取得
    var files = $('input[type="file"]').prop('files')[0];
    $.each(this.files, function (i, file) {
      //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
      var fileReader = new FileReader();

      //DataTransferオブジェクトに対して、fileを追加
      dataBox.items.add(file)
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
      file_field.files = dataBox.files

      var num = $('.item-image').length + 1 + i
      fileReader.readAsDataURL(file);
      //画像が10枚になったら超えたらドロップボックスを削除する
      if (num == 10) {
        $('#image-box__container').css('display', 'none')
      }
      //読み込みが完了すると、srcにfileのURLを格納
      fileReader.onloadend = function () {
        var src = fileReader.result
        var html = `<div class='item-image' data-image="${file.name}">
                    <div class=' item-image__content'>
                      <div class='item-image__content--icon'>
                        <img src=${src} width="114" height="80" >
                      </div>
                    </div>
                    <div class='item-image__operetion'>
                      <div class='item-image__operetion--delete'>削除</div>
                    </div>
                  </div>`
        //image_box__container要素の前にhtmlを差し込む
        $('#image-box__container').before(html);
      };
      //image-box__containerのクラスを変更し、CSSでドロップボックスの大きさを変えてやる。
      $('#image-box__container').attr('class', `item-num-${num}`)
    });
  });
  //削除ボタンをクリックすると発火するイベント
  $(document).on("click", '.item-image__operetion--delete', function () {
    //プレビュー要素を取得
    var target_image = $(this).parent().parent()
    //プレビューを削除
    target_image.remove();
    //inputタグに入ったファイルを削除
    file_field.val("")
  })
});

$(document).on("click", '.item-image__operetion--delete', function () {
  //削除を押されたプレビュー要素を取得
  var target_image = $(this).parent().parent()
  //削除を押されたプレビューimageのfile名を取得
  var target_name = $(target_image).data('image')
  //プレビューがひとつだけの場合、file_fieldをクリア
  if (file_field.files.length == 1) {
    //inputタグに入ったファイルを削除
    $('input[type=file]').val(null)
    dataBox.clearData();
    console.log(dataBox)
  } else {
    //プレビューが複数の場合
    $.each(file_field.files, function (i, input) {
      //削除を押された要素と一致した時、index番号に基づいてdataBoxに格納された要素を削除する
      if (input.name == target_name) {
        dataBox.items.remove(i)
      }
    })
    //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に再度代入
    file_field.files = dataBox.files
  }
  //プレビューを削除
  target_image.remove()
  //image-box__containerクラスをもつdivタグのクラスを削除のたびに変更
  var num = $('.item-image').length
  $('#image-box__container').show()
  $('#image-box__container').attr('class', `item-num-${num}`)
})


var dropArea = document.getElementById("image-box-1");

//loadイベント発生時に発火するイベント
window.onload = function (e) {
  //ドラッグした要素がドロップターゲットの上にある時にイベントが発火
  dropArea.addEventListener("dragover", function (e) {
    e.preventDefault();
    //ドロップエリアに影がつく
    $(this).children('#image-box__container').css({
      'border': '1px solid rgb(204, 204, 204)',
      'box-shadow': '0px 0px 4px'
    })
  }, false);
  //ドラッグした要素がドロップターゲットから離れた時に発火するイベント
  dropArea.addEventListener("dragleave", function (e) {
    e.preventDefault();
    //ドロップエリアの影が消える
    $(this).children('#image-box__container').css({
      'border': '1px dashed rgb(204, 204, 204)',
      'box-shadow': '0px 0px 0px'
    })
  }, false);
  //ドラッグした要素をドロップした時に発火するイベント
  dropArea.addEventListener("drop", function (e) {
    e.preventDefault();
    $(this).children('#image-box__container').css({
      'border': '1px dashed rgb(204, 204, 204)',
      'box-shadow': '0px 0px 0px'
    });
    var files = e.dataTransfer.files;
    //ドラッグアンドドロップで取得したデータについて、プレビューを表示
    $.each(files, function (i, file) {
      //アップロードされた画像を元に新しくfilereaderオブジェクトを生成
      var fileReader = new FileReader();
      //dataTransferオブジェクトに値を追加
      dataBox.items.add(file)
      file_field.files = dataBox.files
      //lengthで要素の数を取得
      var num = $('.item-image').length + i + 1
      //指定されたファイルを読み込む
      fileReader.readAsDataURL(file);
      // 10枚プレビューを出したらドロップボックスが消える
      if (num == 10) {
        $('#image-box__container').css('display', 'none')
      }
      //image fileがロードされた時に発火するイベント
      fileReader.onload = function () {
        //変数srcにresultで取得したfileの内容を代入
        var src = fileReader.result
        var html = `<div class='item-image' data-image="${file.name}">
                    <div class=' item-image__content'>
                      <div class='item-image__content--icon'>
                        <img src=${src} width="114" height="80" >
                      </div>
                    </div>
                    <div class='item-image__operetion'>
                      <div class='item-image__operetion--delete'>削除</div>
                    </div>
                  </div>`
        //image-box__containerの前にhtmlオブジェクトを追加　
        $('#image-box__container').before(html);
      };
      //image-box__containerにitem-num-(変数)という名前のクラスを追加する
      $('#image-box__container').attr('class', `item-num-${num}`)
    })
  })
}