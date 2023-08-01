# Social Network Project
Social Network Project


![3891940_Mesa de trabajo 1 1@1x](https://user-images.githubusercontent.com/28200789/221748586-8fbcdd87-19a4-42b5-b733-049089b704ef.png)


Architecture: The project is based on the Model-View-ViewModel (MVVM) architecture

Архитектура: Проект создан на архитектуре Model-View-ViewModel (MVVM)


The project consists of:

1) Registration and authentication of the user via a mobile phone number
2) Profile Page
3) News page
4) A friend's page
5) Favorite posts page


Проект состоит из:

1) Регистрация и аутентификация пользователя через номер мобильного телефона
2) Страница профиля
3) Страница новостей
4) Страница друга
5) Страница любимых постов


1) Registration and authentication of the user via a mobile phone number

Login Options:

Number: +7 5555555555

Password: 123123


1) Регистрация и аутентификация пользователя через номер мобильного телефона

Параметры для входа:

Номер: +7 5555555555

Пароль: 123123


When the application is launched, the user opens a screen for choosing registration or logging in to the application via a phone number

При запуска приложения пользователю открывается экран выбора регистрации или входа в приложение через номер телефона


<img width="426" alt="Снимок экрана 2023-02-28 в 11 42 25" src="https://user-images.githubusercontent.com/28200789/221764724-e68f2ce8-3fde-4f26-82d8-cec3464f0e00.png">

a) When choosing registration, the application requires you to enter a number

а) При выборе регистрации приложение требует ввести номер
<img width="429" alt="Снимок экрана 2023-02-28 в 11 45 36" src="https://user-images.githubusercontent.com/28200789/221765771-a85e1100-f223-4470-8c28-45a7748e342d.png">

After entering the number, an SMS with a code will be sent to the mobile phone, which you will need to enter in the field

После ввода номера, на мобильный телефон придет смс с кодом, который надо будет ввести в поле

<img width="427" alt="Снимок экрана 2023-02-28 в 11 48 54" src="https://user-images.githubusercontent.com/28200789/221765906-d2c83b8e-2515-4cfd-8069-1175326c1ffe.png">

After successful registration, the user's phone number is saved in Firebase and the application goes to the profile page.

После успешной регистрации, номер телефона пользователя сохраняется в Firebase и приложение переходит на профиль страницу.

<img width="432" alt="Снимок экрана 2023-03-02 в 23 41 10" src="https://user-images.githubusercontent.com/28200789/222508749-759a6a28-0cc3-445a-8974-ea78a81e4e54.png">

b) When you select "Already have an account", a user profile login page will appear

б) При выборе "Уже есть аккаунт" появиться страница входа в профиль пользователя

<img width="429" alt="Снимок экрана 2023-02-28 в 12 01 31" src="https://user-images.githubusercontent.com/28200789/221767763-74517390-a999-4719-ae13-4fa5c12af652.png">

It is necessary to enter the user's phone number, and if the number has not been registered, a message will appear that "The user with this number is not registered".

Необходимо ввести номер телефона пользователя, и если номер не был зарегестрирован, то выйдет сообщение, что "Пользователь с таким номером не зарегистрирован".

<img width="425" alt="Снимок экрана 2023-02-28 в 12 05 25" src="https://user-images.githubusercontent.com/28200789/221769198-1345624e-c76b-48df-a5f0-99580db34e60.png">

2) On the profile page, the user can view their posts, photos and data.

2) На странице профиля пользователь может посмотреть свои посты, фотографии и данные.

<img width="432" alt="Снимок экрана 2023-03-02 в 23 41 10" src="https://user-images.githubusercontent.com/28200789/222509497-98cde6dc-61f9-4346-964f-91b23c2af90e.png">

<img width="439" alt="Снимок экрана 2023-03-02 в 23 41 24" src="https://user-images.githubusercontent.com/28200789/222509578-1eb09775-f18c-4457-b739-e756389bf11c.png">

<img width="430" alt="Снимок экрана 2023-03-02 в 23 43 47" src="https://user-images.githubusercontent.com/28200789/222509601-281edefd-45e1-4fce-8c81-538684d478ce.png">

If necessary, the user can change their data.

При необходимости, пользователь может изменить свои данные. 


<img width="433" alt="Снимок экрана 2023-02-28 в 12 25 15" src="https://user-images.githubusercontent.com/28200789/221771592-429d6690-55ac-402e-abc1-d903f07bc97e.png">

3) On the news page, you can view your friends' stories and posts. On the "for you" page there are posts that are interesting to the user.

3) На странице новостей можно посмотреть истории своих друзей и посты. На странице "для вас" выходят посты, которые интересны пользователю.


<img width="438" alt="Снимок экрана 2023-03-02 в 23 34 41" src="https://user-images.githubusercontent.com/28200789/222507351-20bbe303-37f5-4a3a-87b6-af39f4138fe5.png">



<img width="439" alt="Снимок экрана 2023-02-28 в 12 29 23" src="https://user-images.githubusercontent.com/28200789/221772300-42ac111a-7e5c-43e7-97d8-bb3ae80f4492.png">


<img width="438" alt="Снимок экрана 2023-03-02 в 23 35 24" src="https://user-images.githubusercontent.com/28200789/222507374-52d08bb7-73fb-4427-b870-f9e116bfc643.png">


4) When you click on a friend's avatar, the application goes to a page where the user will find posts, photos and information about a friend.

4) При нажатии на аватар друга, приложение переходит на страницу, где пользователь найдет посты, фотограции и информацию о друге.


<img width="435" alt="Снимок экрана 2023-03-02 в 23 33 39" src="https://user-images.githubusercontent.com/28200789/222506961-a4c79296-175a-40ff-93de-552106e3fc44.png">

When you click on the image of the post, it goes to the information about the post.

При нажатии на картинку поста, переходит на информацию о посте.


<img width="431" alt="Снимок экрана 2023-03-02 в 22 28 50" src="https://user-images.githubusercontent.com/28200789/222505952-242c4f2e-7dc2-46ca-9aca-25a7f49f199a.png">


5) Favorite posts page

The page contains information about posts that the user liked when clicking the "heart" image under the post.


5) Страница любимых постов

На странице собрана информация о постах, которые лайкнул пользователь при нажатии картинки "сердечка" под постом.



<img width="436" alt="Снимок экрана 2023-03-02 в 23 31 36" src="https://user-images.githubusercontent.com/28200789/222506705-83cc2984-8031-4804-80df-76b7f35768de.png">

Additionally, the application has a translation in 3 languages:
1) Kazakh
2) Russian
3) English


Дополнительно в приложении присутствует перевод на 3 языках:
1) Казахский
2) Русский
3) Английский
