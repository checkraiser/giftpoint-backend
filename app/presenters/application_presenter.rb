class ApplicationPresenter < SimpleDelegator
  def self.decorate(collections)
    if collections.respond_to?(:map)
      collections.map do |item|
        new(item) if item
      end.compact
    elsif collections
      new(collections)
    end
  end

  protected

  def object
    __getobj__
  end
end
