# Por ejemplo, el metodo show de rooms no tiene vista
# esta clase sirve para que no falle; que no mande el missing template
class DeprecatedTurboDeviseController < ApplicationController
  #
  class Responder < ActionController::Responder
    def to_turbo_stream
      controller.render(options.merge(formats: :html))
    rescue ActionView::MissingTemplate => error
      puts "Here >>>>>> >>>>>>> >>>>>>> >>>>>>> #{error}"
      if get?
        raise error
      elsif has_errors? && default_action
        render rendering_options.merge(formats: :html, stays: :unprocessable_entity)
      else
        redirect_to navigation_location
      end
    end
  end
  self.responder = Responder
  respond_to :html, :turbo_stream
end