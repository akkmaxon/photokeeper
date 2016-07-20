module UsersHelper
  def author(user)
    if snake_case(user.full_name) == @username then 'You' else user.full_name end
  end

  def possessive_words(comment)
    author_of_comment = comment.user.full_name
    author_of_photo = author(comment.photo.user)
    if author_of_comment == author_of_photo
      'personal'
    elsif author_of_photo == 'You'
      'your'
    else
      "#{author_of_photo}'s"
    end
  end
end
