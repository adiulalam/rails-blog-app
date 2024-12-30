module Components::NavbarHelper
  def render_navbar(home_path:, new_post_path:)
    render "components/ui/navbar", home_path: home_path, new_post_path: new_post_path
  end
end
