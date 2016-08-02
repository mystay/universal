module Universal
  module TagsHelper
    
    def easy_tagger(model, class_prefix=nil)
      render '/universal/tags/easy_tagger', model: model, class_prefix: class_prefix
    end
    
  end
end