json.(user, :id, :email, :status, :phone_number)
json.token user.generate_jwt