require 'rails_helper'

RSpec.describe OrderInformation, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_information = FactoryBot.build(:order_information, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '購入情報登録' do
    context '購入情報が登録できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_information).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_information.building = ''
        expect(@order_information).to be_valid
      end
    end

    context '購入情報が登録できない場合' do
      it 'postal_codeが空だと保存できないこと' do
        @order_information.postal_code = ''
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_information.postal_code = '1234567'
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefectureが初期値では保存できないこと' do
        @order_information.prefecture_id = 1
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @order_information.city = ''
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        @order_information.address = ''
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_information.phone_number = ''
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが半角数値以外だと保存できないこと' do
        @order_information.phone_number = 'aaaaaaaaaa'
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Phone number is not a number")
      end
      it 'phone_numberが9桁以下だと保存できないこと' do
        @order_information.phone_number = '123456789'
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Phone number is too short (minimum is 10 characters)")
      end
      it 'phone_numberが12桁以上だと保存できないこと' do
        @order_information.phone_number = '012345678912'
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_information.user_id = nil
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_information.item_id = nil
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Item can't be blank")
      end
      it "tokenが空では登録できないこと" do
        @order_information.token = nil
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
