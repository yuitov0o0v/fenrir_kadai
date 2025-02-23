class RestaurantsController < ApplicationController
  GENRES = [
    { name: '指定なし', code: '' },
    { name: '居酒屋', code: 'G001' },
    { name: 'ダイニングバー・バル', code: 'G002' },
    { name: '創作料理', code: 'G003' },
    { name: '和食', code: 'G004' },
    { name: '洋食', code: 'G005' },
    { name: 'イタリアン・フレンチ', code: 'G006' },
    { name: '中華', code: 'G007' },
    { name: '焼肉・ホルモン', code: 'G008' },
    { name: '韓国料理', code: 'G017' },
    { name: 'エスニック', code: 'G009' },
    { name: '各国料理', code: 'G010' },
    { name: 'カラオケ・パーティ', code: 'G011' },
    { name: 'バー・カクテル', code: 'G012' },
    { name: 'お好み焼き・モンジャ', code: 'G016' },
    { name: 'ラーメン', code: 'G013' },
    { name: 'カフェ・スイーツ', code: 'G014' },
    { name: 'その他グルメ', code: 'G015' }
  ]

  RANGES = [
    { name: '300m', code: '1' },
    { name: '500m', code: '2' },
    { name: '1km', code: '3' },
    { name: '2km', code: '4' },
    { name: '3km', code: '5' }
  ]

  def search
    @genres = GENRES
    @ranges = RANGES
  end

  def index
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    range = params[:range]
    genre = params[:genre]
    page = (params[:page] || 1).to_i

    service = HotpepperService.new
    result = service.search_restaurants(lat, lng, range, genre, page)
    @total_count = result[:total_count]
    @restaurants = Kaminari.paginate_array(result[:shops], total_count: @total_count).page(page).per(10)
  end

  def show
    service = HotpepperService.new
    @restaurant = service.get_restaurant(params[:id])
  end
end