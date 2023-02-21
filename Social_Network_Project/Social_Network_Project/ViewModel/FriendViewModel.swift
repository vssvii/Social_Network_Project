//
//  FriendViewModel.swift
//  Social_Network_Project
//
//  Created by Developer on 20.02.2023.
//

import UIKit

class FriendViewModel: NSObject {
    
    
    let friendProfile: [Profile] = [Profile(surname: "Маслеников", name: "Сергей", image: UIImage(named: "sergei"), job: "музыкант", publicationCount: 559, subscriptionCount: 343, subscriberCount: 435),
    Profile(surname: "Берикова", name: "Алия", image: UIImage(named: "aliya"), job: "архитектор", publicationCount: 343, subscriptionCount: 587, subscriberCount: 345),
                                    Profile(surname: "Евлеева", name: "Саша", image: UIImage(named: "sasha"), job: "Трэвел-блогер", publicationCount: 576, subscriptionCount: 345, subscriberCount: 546),
                                    Profile(surname: "Ермек", name: "Шынгыс", image: UIImage(named: "chingiz"), job: "Стендап-комик", publicationCount: 425, subscriptionCount: 254, subscriberCount: 425),
    Profile(surname: "Кудайберген", name: "Димаш", image: UIImage(named: "dimash"), job: "певец", publicationCount: 456, subscriptionCount: 857, subscriberCount: 478)]
    
    let sergeiPosts: [Post] = [Post(date: Date(timeIntervalSince1970: 1674614519), description: "Собираюсь приехать в Алматы в эти выходные и устроить концерт. Приглашаю всех на концерт по адресу г. Алматы, бар Almaty Nights. Алматы – крупнейший мегаполис Казахстана, расположенный в предгорьях Заилийского Алатау. До 1997 года он был столицей государства и до сих пор остается торговым и культурным центром.", image: UIImage(named: "almaty"), likes: 459),
                               Post(date: Date(timeIntervalSince1970: 1674614519), description: "Стильный инструмент с оригинальным дизайном, вырезом и электроникой Fishman на борту. Это один из лучших вариантов для регулярно выступающего музыканта, сочинителя или любого человека, который редко расстается с гитарой. Корпус Auditorium удобен для долгой игры, вырез открывает доступ к верхним позициям, а запоминающийся внешний вид — приятное дополнение к сценическому образу.", image: UIImage(named: "guitar"), likes: 435),
                               Post(date: Date(timeIntervalSince1970: 1674614519), description: "Отличная укулеле. Имеет потрясающий вид. Лучшая цена в соотношении цена-качество. Модели Концерт 24 дюйма - 19990тг. Корпус-махагони. Накладка на гриф-палисандр. Количество ладов-18. Количество струн-4 (нейлон). Бренд-Maverick. Samus. Это интернет-магазин, где можно найти большой ассортимент музыкальных инструментов, наушников BlueTooth, видеоигровой периферии.", image: UIImage(named: "ukulele"), likes: 587),
                               Post(date: Date(timeIntervalSince1970: 1674614519), description: "Фильм идет 3 часа, пролетели они конечно быстро, но я отсидел себе все что можно))), но не жаль потраченного времени. Я не читал, но такое ощущение, что будут еще продолжения и как с Мортал комбатом это затравка. Я забыл музыку к первому фильму, но здесь музыка красивая и эпичная, одна из композиций очень похожа, кстати, на музыку из Трои, а может она и есть))).", image: UIImage(named: "avatarFilm"), likes: 878)]
}
