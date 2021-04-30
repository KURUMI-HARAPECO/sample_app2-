class TodolistsController < ApplicationController
  def new
    @list = List.new
    #  [List.new」と記述すると、空のモデルが生成され、インスタンス変数@listに代入されてViewで利用できるようになります。
    # 投稿を新規作成するには、「空のモデル」をform_withの引数に渡す必要があります。
  end
  def create
    list = List.new(list_params)
    #listインスタンスでは、Listのメソッドでnew(新規投稿)が呼び出され、引数でlist_paramsが呼び出されています。
    list.save
    redirect_to todolist_path(list.id)
  end
    # reateアクション内の変数（list）に@がないことを不思議に感じるかもしれませんね。
    # @のついたインスタンス変数とローカル変数の違いについて、@のついているインスタンス変数はビューファイルへ受け渡すことができます。
    # 一方でローカル変数は、ビューファイルに受け渡しができません。アクション内でしか利用できません。
    # 今回はビューファイルへの受け渡しが必要ではないため、ローカル変数を利用しています。
    def index
      @lists = List.all
      # インスタンス変数には今まで↑で新規登録した、すべてのデータが取り出されて格納されるため、インスタンス変数名を複数形にしています。
    end
    def show
      @list = List.find(params[:id])
      # 詳細画面で呼び出される投稿データは、URLの/todolists/:id内の:idで判別します。
      # この:idは、アクション内にparams[:id]と記述することで取得できます。
      # たとえば、URLが/todolists/1の場合、params[:id] と記述すると、id=1を取り出せます。
      # id=1のデータをfindメソッドを利用してデータベースから取得し、@listへ格納します。
      # 今回はレコード1件を取得するので、インスタンス変数名は単数形の「@list」にします。
    end
    def edit
      @list = List.find(params[:id])
    end
    def update
      list = List.find(params[:id])
      list.update(list_params)
      redirect_to todolist_path(list.id)
    end
    def destroy
      list = List.find(params[:id])  # データ（レコード）を1件取得
      list.destroy  # データ（レコード）を削除
      redirect_to todolists_path  # 投稿一覧画面へリダイレクト
    end



  private
  def list_params
    params.require(:list).permit(:title, :body, :image)
    # paramsはRailsで送られてきた値を受け取るためのメソッドです。
    # requireでデータのオブジェクト名(ここでは:list)を指定し、permitでキー（:title,:body）を指定しています。
    # これにより、list_paramsの中にフォームで入力されたデータが格納されます。
  end
end
