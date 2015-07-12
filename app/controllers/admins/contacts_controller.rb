class Admins::ContactsController < AdminBaseController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :set_form_details, only: [:new, :edit]
  add_breadcrumb 'Contacts', :admins_contacts_path

  def index
    @contacts = Contact.all
  end

  def show
    add_breadcrumb "Contact", admins_contact_path(@contact.id)
  end

  def new
    @contact = Contact.new
    add_breadcrumb 'New Contacts', new_admins_contact_path
  end

  def edit
    add_breadcrumb "Edit Contact", edit_admins_contact_path(@contact.id)
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to admins_contact_path(@contact.id), notice: 'Contact was successfully created.'
    else
      render :new
    end
  end

  def update
    if @contact.update(contact_params)
      redirect_to admins_contact_path(@contact.id), notice: 'Contact was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to admins_contacts_path, notice: 'Contact was successfully destroyed.'
  end

  def import
    if params[:csv_file].present?
      Contact.import_contact(params[:csv_file].path)
      redirect_to admins_contacts_path, notice: 'Contacts are being Imported, you will receive status soon by email'
    else
      redirect_to admins_contacts_path, alert: 'CSV missing'
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone, position_ids: [], access_level_ids: [], department_ids: [], practise_code_ids: [], direct_report_ids: [])
    end
end
