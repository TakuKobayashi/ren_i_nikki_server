# coding: utf-8
module Api::ErrorHandling
  class BadRequest < Exception; end
  class AuthenticationError < Exception; end
  class PaymentRequired < Exception; end
  class PreconditionFailed < Exception; end
  class Conflict < Exception; end
  class UpgradeRequired < Exception; end

  extend ActiveSupport::Concern

  included do
    # サーバー側が想定していない動作が発生した場合に返すエラー
    rescue_from StandardError do |e|
      render_json(status: 500, exception: e)
    end

    # 必要なパラメーターが足りない時に送信
    rescue_from BadRequest do |e|
      render_json(status: 400, exception: e)
    end

    # find_by! 系のエラーを全てキャッチ
    rescue_from ActiveRecord::RecordNotFound do |e|
      render_json(status: 400, exception: e)
    end

    #認証エラー
    rescue_from AuthenticationError do |e|
      render_json(status: 401, exception: e)
    end

    # 通貨の料金不足の時に返す
    rescue_from PaymentRequired do |e|
      render_json(status: 402, exception: e)
    end

    # クライアント側の指示に対してサーバー側の状態が一致しない場合に返すエラー ※レベルが足りない・時間切れ等
    rescue_from Conflict do |e|
      render_json(status: 409, exception: e)
    end

    # クライアントのバージョンがサーバーと一致しない場合に返すエラー
    rescue_from PreconditionFailed do |e|
      render_json(status: 412, exception: e)
    end

    #楽観ロック失敗時に返すエラー。クライアント側はリクエストが再送するべき。
    rescue_from ActiveRecord::StaleObjectError do |e|
      render_json(status: 423, exception: e)
    end

    # クライアントのバージョンを更新する必要がある時に返すエラー
    rescue_from UpgradeRequired do |e|
      render_json(status: 426, exception: e)
    end
  end

  private def render_json(status:, exception:)
    logger.error exception.class.name
    logger.error exception.to_s if exception.to_s

    if Rails.env.test? && ENV["DEBUG"].present?
      raise exception
    end

    if Rails.env.development? || Rails.env.test?
      trace = exception.backtrace.select{ |t| t =~ /^#{Rails.root}/ } # 自分か作った部分が悪い
      trace = exception.backtrace if trace.empty?                     # Gemが悪い
      trace = trace.map {|t| t.gsub(/^#{Rails.root}/, '') }
      trace_string = trace.join("\n")

      logger.error trace_string
      render status: status, json: {
        error: {
          url: request.url,
          parameters: request.request_parameters.to_s,
          message: exception.to_s,
          trace: trace_string,
        }
      }.to_json
    else
      logger.error exception.backtrace.join("\n")
      render status: status, nothing: true
    end
  end
end
