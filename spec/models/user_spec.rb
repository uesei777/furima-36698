require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nicknameとwrite_last_name、write_first_name、read_last_name、read_first_name、birth_date、email、passwordとpassword_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end

      it "write_last_nameが空では登録できない" do
        @user.write_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Write last name can't be blank"
      end

      it "write_last_nameは、全角（漢字・ひらがな・カタカナ）でないと登録できない" do
        @user.write_last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include "Write last name is invalid. Input full-width characters"
      end

      it "write_first_nameが空では登録できない" do
        @user.write_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Write first name can't be blank"
      end

      it "write_first_nameは、全角（漢字・ひらがな・カタカナ）でないと登録できない" do
        @user.write_first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include "Write first name is invalid. Input full-width characters"
      end

      it "read_last_nameが空では登録できない" do
        @user.read_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Read last name can't be blank"
      end

      it "read_last_nameは、全角（カタカナ）でないと登録できない" do
        @user.read_last_name = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Read last name is invalid. Input full-width katakana characters"
      end

      it "read_first_nameが空では登録できない" do
        @user.read_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Read first name can't be blank"
      end

      it "read_first_nameは、全角（カタカナ）でないと登録できない" do
        @user.read_first_name = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include "Read first name is invalid. Input full-width katakana characters"
      end

      it "birth_dateが空では登録できない" do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth date can't be blank"
      end

      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it "メールアドレスに@を含まない場合は登録できない" do
        @user.email = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Email has already been taken"
      end
      
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '000aa'
        @user.password_confirmation = '000aa'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end

      it 'passwordが英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end

      it 'passwordが全角全角文字を含むと登録できない' do
        @user.password = '000aaあ'
        @user.password_confirmation = '000aaあ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end
    end
  end
end