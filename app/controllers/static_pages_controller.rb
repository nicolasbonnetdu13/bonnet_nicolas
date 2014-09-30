class StaticPagesController < ApplicationController
  def myProjects
  end

  def about
  end

  def aboutMe
  end
  
  def download_cv
    redirect_to "https://s3-eu-west-1.amazonaws.com/bonnetnicolas-assets/public/CV_low_quality.pdf"
  end
  
  def download_high_cv
    redirect_to "https://s3-eu-west-1.amazonaws.com/bonnetnicolas-assets/public/CV.pdf"
  end

end
