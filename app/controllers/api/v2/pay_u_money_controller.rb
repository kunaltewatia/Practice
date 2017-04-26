module Api
  module V2
    # PayUMoney Controller
    class PayUMoneyController < ApiController
      # before_action :authenticate_user!
      before_filter :set_payu

      def index
        @payu[:productinfo] = 'SAU Admission 2014'
        @payu[:firstname] = 'Vikas Kumar'
        @payu[:email] = 'omkar.ghate@weboniselab.com'
        @payu[:hash] = payu_hash
        render json: @payu
      end

      private

      def payu_hash
        fields = [
          :txnid, :amount, :productinfo, :firstname, :email, :udf1, :udf2,
          :udf3, :udf4, :udf5, :udf6, :udf7, :udf8, :udf9, :udf10
        ]
        checksum_payload_items = fields.map { |field| @payu[field] }
        Digest::SHA512.hexdigest([@payu[:key], *checksum_payload_items,
                                  @payu[:salt]].join('|'))
      end

      def set_payu
        @payu = {}
        @payu[:key] = Settings.payu_key
        @payu[:salt] = Settings.payu_salt
        @payu[:surl] = Settings.payu_surl
        @payu[:furl] = Settings.payu_furl
        @payu[:txnid] = 'FROOL-10061-31'
        @payu[:amount] = '30.000'
      end
    end
  end
end
