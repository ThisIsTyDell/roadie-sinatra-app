module Slugifiable
  module InstanceMethods
    def slug
      self.username.gsub(" ","-").downcase
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find{|x| x.slug == slug}
    end
  end
end