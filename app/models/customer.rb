class Customer < ApplicationRecord
    has_many :buildings
    belongs_to :address, optional: true
    belongs_to :user, optional: true
    after_create :verify_email
    
     
    def verify_email
        Lead.all.each do |l|
        if l.email == company_email
            client = DropboxApi::Client.new("pvtx8etxk9p1qlk")
            binary = l.file.download
            name = "/#{l.full_name}"
            begin
                client.create_folder(name)
            rescue DropboxApi::Errors::FolderConflictError => exception
                puts "This Folder name already exists, Go to the next"
            end
            client.upload("/#{l.full_name}/#{l.file.blob.filename}", binary, :autorename => true)
            l.file.destroy
            l.file.blob.destroy
            end
        end
    end
end