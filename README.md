# Technical Test Mobile Developer PT. Serasi Autoraya
Candidate: Nicholas Stancio Saka
Email: work.nicholasstancio@gmail.com
Phone: 08119898601

Start Date: 28 Nov 2023
Expected End Date: 1 Dec 2023 (3 days)

## Notes
- Few images and icons may appear different from the design since the design is in pdf, not in Figma
- If there are an unknown error, there might be a problem with the api (https://fakestoreapi.com/).
    - Known issue occurance: 29 Nov 16.00 - 21.30
- User can logout (locally) by pressing the profile icon in the home screen.
- Buggy API saat delete cart. harusnya return array kosong, tapi ada isi

## Additional features:
Firebase Crashlytics --> Error handling on productions

## API Usage
'https://fakestoreapi.com/users' -> Create Account
'https://fakestoreapi.com/auth/login' -> Login
'https://fakestoreapi.com/users/$id' -> Get User (Combine with login)

## Potential Improvements
- Centralized product remote data access
- Caching to reduce network usage

### Auth
- Implement Real Auth (Login & Register). Saat ini API gabisa. Tapi code & stuktur udah siap kalau bisa pindah
- Reset password gaada apinya
- Api Login kasih user ID juga, kalo ga sediain cara buat either
    - Dapet User (Lengkap) dari post token
    - Dapet User dari username
    - Kalo ga atleast kasih ID biar bisa hit API get user
- Additional handling kalau API lagi down

### Product List
- Implement Lazy Load
- Mungkin category bisa dibuat swipe pake PageView atau yng mirip. Depends on the requirement maunya gimana
- Image placeholder kalau fail
- Implement Stream. Stop previous action when a new action is called (Change Category)

### Product Search
- There is no search API. so fetch all products and manually search
- If the products never changes, bisa store local storage to improve performance
- Bisa dikasih placeholder kalo empty / on init

###