//
//  FeedViewModel.swift
//  Social_Network_Project
//
//  Created by Developer on 09.02.2023.
//

import UIKit


class FeedViewModel: NSObject {
    
    
    var feeds: [Feed] = [Feed(avatarImage: UIImage(named: "ivan"), authorFullName: "Сергей Маслеников", job: "музыкант", text: "Собираюсь приехать в Алматы в эти выходные и устроить концерт. Приглашаю всех на концерт по адресу г. Алматы, бар Almaty Nights.", image: UIImage(named: "almaty"), likes: 250),
    Feed(avatarImage: UIImage(named: "dimash"), authorFullName: "Димаш Кудайберген", job: "певец", text: "Концерт в Москве.", image: UIImage(named: "concert"), likes: 300),
                         Feed(avatarImage: UIImage(named: "aliya"), authorFullName: "Алия Берикова", job: "рхитектор", text: "В свете тенденций вполне логично обратить пристальное внимание на архитектуру минимализма, здесь речь идет об отказе от излишеств, вычурности, чрезмерной нагромождения элементов. Интересно, что направление активно развивалось еще в 50-60-х годах прошлого века, но пика достиг, кажется, сейчас. В 2020-2021 годах он получил новый виток популярности благодаря своим особенностям — стремлению к функциональности и гармонии всех элементов.", image: UIImage(named: "architect"), likes: 568),
                         Feed(avatarImage: UIImage(named: "sasha"), authorFullName: "Саша Евлеева", job: "трэвел блогер", text: "На территории Швейцарии различимы три природных района: горный массив Юра на северо-западе, Швейцарское плато (плоскогорье) в центре и Альпы на юго-востоке. Горы Юра разделяют Швейцарию и Францию, простираются от Женевы до Базеля и Шаффхаузена. Швейцарское плато образовалось на месте прогиба между Юрой и Альпами.", image: UIImage(named: "switz"), likes: 760),
                         Feed(avatarImage: UIImage(named: "chingiz"), authorFullName: "Шынгыс Ермек", job: "Стендап-комик", text: "Собираюсь провести стэндап в Астане на этих выходных. Буду рад всех увидеть, так как я приготовил классные шутки. :)", image: UIImage(named: "standup"), likes: 867)]
    
}
