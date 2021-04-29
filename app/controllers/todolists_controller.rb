class TodolistsController < ApplicationController
  def new
    @list = List.new
    #  Viewへ渡すためのインスタンス変数に空のモデルオブジェクトを生成する。
  end
  def create
    list = List.new(list_params)
    #listインスタンスでは、Listのメソッドでnew(新規投稿)が呼び出され、引数でlist_paramsが呼び出されています。
    # 空のモデルオブジェクトを生成し、ストロングパラメータから精査されたデータだけをインスタンスに格納
    list.save
    redirect_to '/top'
  end
    # reateアクション内の変数（list）に@がないことを不思議に感じるかもしれませんね。
    # @のついたインスタンス変数とローカル変数の違いについて、@のついているインスタンス変数はビューファイルへ受け渡すことができます。
    # 一方でローカル変数は、ビューファイルに受け渡しができません。アクション内でしか利用できません。
    # 今回はビューファイルへの受け渡しが必要ではないため、ローカル変数を利用しています。



  private
  def list_params
    params.require(:list).permit(:title, :body)
  end
end
