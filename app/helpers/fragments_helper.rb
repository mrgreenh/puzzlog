# coding: utf-8
module FragmentsHelper
  def getFragmentTypes(fragments)
    fragment_types = Hash.new()
    fragments.each do |frag|
      fragment_types[frag.fragment_type.id] = FragmentType.find(frag.fragment_type.id)
    end
    return fragment_types
  end
end
