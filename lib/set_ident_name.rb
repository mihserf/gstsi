
module SetIdentName
  def self.included(base)
    base.class_eval do
      after_create :update_ident_name
      before_update :set_ident_name
      
      def set_ident_name
        self.ident_name = self.id if self.ident_name.nil? || self.ident_name==""
      end

      def update_ident_name
        update_attribute :ident_name, "#{id}"  if self.ident_name.nil? || self.ident_name==""
      end
    end
  end
end
