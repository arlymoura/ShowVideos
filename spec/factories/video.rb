FactoryGirl.define do
  factory :video, class: Video do
    titulo {  Faker::Movie.quote }
    url 'https://content.jwplatform.com/manifests/yp34SRmf.m3u8'
    user
  end
end