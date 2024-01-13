require 'rails_helper'

RSpec.describe 'Images' do
  it 'returns an image' do
    create(:image)
    get image_path(Image.last)

    expect(response).to be_successful
    expect(response.content_type).to eq('image/jpeg')

    headers = response.headers
    expect(headers['Content-Disposition']).to include('inline')

    image_name = "image_#{Image.last.id}.jpeg"
    expect(headers['Content-Disposition']).to include(image_name)
  end
end
