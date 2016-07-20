module UsersHelper
  def author(user)
    if snake_case(user.full_name) == @username then 'You' else user.full_name end
  end
end
