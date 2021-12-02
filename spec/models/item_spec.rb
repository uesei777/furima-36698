require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品情報登録' do
    context '商品情報が登録できる場合' do
      it 'productとexplanation,category_id,status_id,delivery_fee_id,prefecture_id,days_id,priceが存在していれば保存できる' do
        expect(@item).to be_valid
      end
    end

    context '商品情報が登録できない場合' do
      it 'productが空では保存できない' do
        @item.product = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product can't be blank")
      end

      it 'explanationが空では保存できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end

      it 'categoryが初期値では保存できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'statusが初期値では保存できない' do
        @item.status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it 'delivery_feeが初期値では保存できない' do
        @item.delivery_fee_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee can't be blank")
      end

      it 'prefectureが初期値では保存できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'daysが初期値では保存できない' do
        @item.days_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Days can't be blank")
      end

      it 'priceが空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが半角数値以外では保存できない' do
        @item.price = 'aaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが300未満では保存できない' do
        @item.price = '100'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it 'priceが9999999より大きいと保存できない' do
        @item.price = '99999999'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

      it 'imageが空だと保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end
