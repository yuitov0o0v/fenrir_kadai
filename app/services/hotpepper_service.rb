class HotpepperService
  BASE_URL = 'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/'

  def initialize
    @api_key = ENV['HOTPEPPER_API_KEY']
  end

  def search_restaurants(lat, lng, range, genre, page = 1)
    page = page.to_i
    response = HTTParty.get(BASE_URL, query: {
      key: @api_key,
      lat: lat,
      lng: lng,
      range: range,
      genre: genre,
      count: 10,     # 1ページあたり10件
      start: (page - 1) * 10 + 1,
      format: 'json'
    })
    result = JSON.parse(response.body)['results']
    {
      shops: result['shop'] || [],           # 店舗リスト（空の場合は空配列）
      total_count: result['results_available'].to_i # 総件数
    }
  end

  def get_restaurant(id)
    response = HTTParty.get(BASE_URL, query: {
      key: @api_key,
      id: id,
      format: 'json'
    })
    JSON.parse(response.body)['results']['shop'].first
  end
end