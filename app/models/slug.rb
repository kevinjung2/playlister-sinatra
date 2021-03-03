module Slug
  module InstanceMethods
    def slug
      self.name.downcase.gsub(" ", "-")
    end
  end
  module ClassMethods
    def find_by_slug(slug)
      self.find_by(name: slug.split("-").map do |name|
        if name == "the" || name == "with" || name == "and" || name == "a"
          name
        else
          name.capitalize
        end
      end.join(" "))
    end
  end
end
