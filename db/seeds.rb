Admin.create_with(name: 'Administrador', password: '123456', user_type: 'A')
     .find_or_create_by!(email: 'admin@admin.com')
