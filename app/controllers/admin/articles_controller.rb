module Admin
  class ArticlesController < ApplicationController
    layout 'admin'

    def index
      search_params = params.permit(:category, :title, :status, :page, :page_size)
      do_search search_params
    end

    def trash_list
      search_params = params.permit(:category, :title, :page, :page_size)
      search_params['enabled'] = false
      do_search search_params
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new(article_params)
      p @article
      @article.author_id   = current_user['id']
      @article.author_name = current_user['username']
      @article.status = ArticleStatus::EDITING
      @article.handle_save!
      redirect_to admin_articles_path
    end

    def update_status
      if params['id'].present?
        rtn = Article.update_status(params['id'])
      else
        rtn = CommonException.new(ErrorCode::ERR_ARTICLE_PARAMS_ID_CAN_NOT_BE_BLANK).result
      end
      render json: rtn
    end

    def edit
      @article = Article.find_by_id(params[:id])
      render_not_found unless @article
    end

    def update
      article = Article.find_by_id(params[:id])
      render_not_found unless article
      article.handle_update!(article_params)
      redirect_to admin_articles_path
    end

    private
    def do_search search_params
      rtn = Article.search_for_admin(search_params)
      if Util.success? rtn
        @articles = Kaminari.paginate_array(
          rtn['articles'] || [], total_count: rtn['total_count']
        ).page(search_params[:page].to_i).per(DEFAULT_PAGE_SIZE)
      else
        log_error rtn
        @msg = rtn['return_info']
      end
    end

    def article_params
      params.require(:article).permit(
        :source_type, :title, :category_id, :tags, :summary, :content, :source, :source_url, :attachment
      )
    end
  end
end