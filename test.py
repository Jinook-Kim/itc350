# You need to install bcrypt first for this to work
import bcrypt

password = "1234"
hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
print(hashed_password)