class HomeController < ApplicationController
  def index
  end

  def about
  end

  def projects
  end

  def contact
  end

  def surprise
  end

  def download_resume
    # Path to your resume file in the public directory
    resume_path = Rails.root.join('public', 'resume.pdf')
    
    if File.exist?(resume_path)
      send_file(
        resume_path,
        filename: "Deepan_Kumar_Resume.pdf",
        type: "application/pdf",
        disposition: 'attachment'
      )
    else
      redirect_to about_path, alert: "Resume file not found. Please try again later."
    end
  end
end
