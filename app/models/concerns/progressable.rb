module Progressable
  def attributes_with_progress
    attributes.merge('progress' => progress.attributes)
  end
end
