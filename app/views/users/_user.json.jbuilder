json.(user, :id, :email, :status, :phone_number, :avatar_icon)
json.token user.generate_jwt