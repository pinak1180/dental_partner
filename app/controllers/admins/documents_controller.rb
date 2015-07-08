class Admins::DocumentsController < AdminBaseController
  add_breadcrumb 'Forums', :admins_documents_path

  def index
    @documents = Document.all
  end

  def new
  end

  def create
    count = 0
    params[:document].each do |document|
      d = Document.new(title: document[:title], file: document[:file])
      count += 1 if d.save
    end
    redirect_to admins_documents_path, notice: "#{count} Documents uploaded"
  end
end
