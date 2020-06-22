

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rosse/data/data.dart';
import 'package:rosse/objects/action.dart';
import 'package:rosse/utils/values_utils.dart';
import 'package:share/share.dart';
import 'package:soundpool/soundpool.dart';

import '../main.dart';


shareApp(){
  Share.share('Hey. So this is helping my business a bunch, and I figured out that you should try it too : https://play.google.com/store/apps/details?id=com.rosseapp.rosse');
}

launchPage(BuildContext context , Widget page){
  Navigator.push(context, MaterialPageRoute(
    builder: (context){
      return page;
    }
  ));
}

removeListCheckedActions(List<RosseAction> actions){
  List<RosseAction> checkedActions = List();

  actions.forEach((item){
    if(item.checked){
      checkedActions.add(item);
    }
  });

  checkedActions.forEach((item){
    actions.remove(item);
  });
  
  return actions;
}

playTick(Soundpool pool) async{
    pool.play(await rootBundle.load(AssetsPath.tick).then((ByteData soundData) {
                  return pool.load(soundData);
                }));
  }


List<RosseAction> getHardCodedActions(Data data){
  return <RosseAction>[
    RosseAction(
      id: 0,
      name: MyApp.isEnglish?'I\'ve followed my bed and wake-up time':'Mi-am respectat timpul de culcare si trezire',

      why: MyApp.isEnglish?'Going to sleep and waking up at the same time ensures that your circadian rhythm(your'
          ' biological clock) regulates according to your sleep schedule and you fall asleep faster. Also between'
          ' 10 pm and 2 am you get the most regenerative sleep so if you still feel fatigued after waking up, it\'s'
          ' a good idea to sleep more in that period':
      'Respectarea timpului de culcare si de trezire asigura ca ritmul circadian(ceasul tau biologic) este regulat'
          'in conformitate cu programul tau de somn si ca o sa adormi mai repede. Inca ceva: intre 22:00 si 2:00'
          'o sa ai cel mai regenerativ somn, asa ca daca te simti slabit dupa ce te trezesti, este o idee buna sa'
          'dormi mai mult in acea perioada',

      howToDoIt: MyApp.isEnglish?'Use a service like sleepcalculator.com to calculate your bed and wake up time.'
          ' And for god\'s sake don\'t look at the clock while in bed (more stress, less sleep).':
      'Foloseste sleepcalculator.com ca sa iti calculezi timpul de culcare si de trezire. Si pentru numele lui'
          'Dumnezeu, nu te uita la ceas in timp ce vrei sa dormi. Vei fii stresat si vei dormii mai putin',

      tldr: MyApp.isEnglish?'Use this and stick to it: sleepcalculator.com':
      'Foloseste sleepcalculator.com',
      effort: 60,
      brainImprovement: 30,
      energyImprovement: 40,
      healthImprovement: 45,
      reset: resetMorning,
      type: type_sleep,
      lastChecked: data.getLastChecked(0),
    ),
    RosseAction(
      id: 1,
      name: MyApp.isEnglish?'I’ve limited blue light the night before':'Am limitat lumina albastra aseara',
      why: MyApp.isEnglish?'Blue light blocks the secretion of melatonin(the sleep hormone), decreasing the quality'
          ' of your sleep and making you fall asleep harder.':
      'Lumina albastra blocheaza secretia de melatonina(hormonul somnului), sacrificand calitatea lui si facandu-te'
          'sa adormi mai greu',

      howToDoIt: MyApp.isEnglish?'The best thing you can do is just to stop using screens at all at least 1 hour '
          'before bed. But if you can\'t do that install a blue light filter and lower visibility to a minimum. '
          'On Pc and Mac, you can download F.lux( justgetflux.com ) and on most mobiles, this feature is '
          'built-in into the settings.':
      "Cea mai buna chestie pe care poti sa o faci, este sa nu vizualizezi ecrane deloc cu o ora inainte sa adormi."
          "Dar daca nu poti, instaleaza un filtru de lumina albastra si micsoreaza visibilitatea la minim."
          "Pe Pc si Mac, poti descarca F.lux ( justgetflux.com ), iar pe majoritatea mobilelor, aceasta "
          "caracteristica poate fii gasita in setari",

      tldr: MyApp.isEnglish?'Just read a book 1 hour before bed':'Doar citeste o carte cu o ora inainte sa adormi',

      effort: 20,
      brainImprovement: 30,
      energyImprovement: 40,
      healthImprovement: 45,
      reset: resetMorning,
      type: type_insomnia,
      lastChecked: data.getLastChecked(1),
    ),
    RosseAction(
      id: 2,
      name: MyApp.isEnglish?'My sleep and wake up time are optimized according to my sleep chronotype':
        'Timpul meu de culcare si trezire este optimizat in conformitate cu \'Chronotype-ul\' meu',

      why: MyApp.isEnglish?'Everybody\'s body works differently. Some people are more likely to have more energy'
          ' in the mornings while some in the evenings. Adjusting your sleep and work according to your peak hours'
          ' makes will make you more efficient.':
      'Toata lumea are corpul configurat diferit. Unele persoane au mai multa energie dimineata, iar altele seara.'
          'Ajustarea perioadei tale de somn in conformitate cu orele tale cele mai productive o sa te faca mai'
          'eficient',

      howToDoIt: MyApp.isEnglish?'Take this quiz to know your sleep chronotype '
          'thepowerofwhenquiz.com/?cn-reloaded=1 and use this with a sleep calculator':
      'Fa quiz-ul acesta gratuit ca sa iti gasesti Chronotype-ul: thepowerofwhenquiz.com/?cn-reloaded=1.'
          'Nu uita sa il folosesti cu un sleep calculator',

      tldr: '',
      effort: 60,
      brainImprovement: 80,
      energyImprovement: 80,
      healthImprovement: 10,
      reset: resetMorning,
      type: type_sleep,
      lastChecked: data.getLastChecked(2),
    ),
    RosseAction(
      id:3,
      name: MyApp.isEnglish?'I’ve slept at least 6 hours':'Am dormit macar 6 ore',

      why: MyApp.isEnglish?'While you sleep, you balance your hormones, you secrete more human growth hormones,'
          ' your brain is reviewing information, analysing it and sorting it and cleaning the waste that built up'
          ' throughout the day. So, by sleeping less you will have: \n •more mental fog \n •less creativity'
          ' \n •less energy(obviously) \n •you will live less':
      'In timp ce dormi, hormonii iti sunt rebalansati, o sa secreti mai mult hormon de crestere, creierul tau'
          'asimileaza informatia, analizand-o si sortand-o si curatand deseurile acumulate de-a lungul zilei. '
          'Deci, dormind mai putin o sa ai: \n •mai putina claritate mentala \n •mai putina creativitate \n •'
          'mai putina energie \n •vei traii mai putin',

      howToDoIt: MyApp.isEnglish?'Make sleep your priority and schedule it':
        'Fa-ti somnul o prioritate si programeaza-l',

      tldr: MyApp.isEnglish?'After 4 days of 5 hours of sleep, you are the equivalent of being too drunk to'
          ' drive. After 14 days of 6 hours of sleep, you are the equivalent of pulling up an all-nighter.':
        'Dupa 4 zile a cate 5 ore de somn, esti la fel ca o persoana prea bauta sa conduca. Dupa 14 zile a cate'
            '6 ore de somn, esti la fel ca o persoana care nu a dormit o noapte intreaga',

      effort: 30,
      brainImprovement: 100,
      energyImprovement: 100,
      healthImprovement: 100,
      reset: resetMorning,
      type: type_sleep,
      lastChecked: data.getLastChecked(3),
    ),
    RosseAction(
      id: 4,
      name: MyApp.isEnglish?'I\'ve got exposed to sunlight and nature today':'Am stat in soare si in natura astazi',

      why: MyApp.isEnglish?'Sunlight in the morning can regulate your circadian rhythm and in any part of'
          ' the day, it gives you vitamin D3, which will give you more energy. Exposing yourself to nature has '
          'been shown to increase productivity and well being.':
        'Razele soarelui dimineata iti vor regula ritmul circadian, iar in orice parte a zilei o sa iti dea vitamina'
            'D3, care iti v-a da mai multa energie. Expunerea la natura arata o inbunatatire in productivitate si'
            'fericire',
      howToDoIt: '',
      tldr: MyApp.isEnglish?'You will sleep better and have more energy just by a 10-minute walk in the morning '
          'and your breaks':
        'O sa dormi mai bine si o sa ai mai multa energie doar print-o plimbare de 10 minute dimineata si in pauze',
      effort: 60,
      brainImprovement: 25,
      energyImprovement: 70,
      healthImprovement: 0,
      reset: resetEveryDay,
      type: type_habits,
      lastChecked: data.getLastChecked(4),
    ),
    RosseAction(
      id: 5,
      name: MyApp.isEnglish?'I\'ve not eaten 3 hours before bed':'Nu am mancat 3 ore inainte de a ma culca',

      why: MyApp.isEnglish?'When insulin(which is secreted when you eat carbs) goes up, melatonin(the hormone'
          ' that helps you fall asleep) goes down and vice versa':
        'Cand insulina ta(care este secretata cand mananci carbohidrati) se ridica, melatonina(hormonul somnului)'
            'se micsoreaza si vice-versa',

      howToDoIt: MyApp.isEnglish?'Plan your meals accordingly':'Planifica-ti mesele',
      tldr: '',
      effort: 35,
      brainImprovement: 35,
      energyImprovement: 55,
      healthImprovement: 40,
      reset: resetEvening,
      type: type_nutrition,
      lastChecked: data.getLastChecked(5),
    ),
    RosseAction(
      id: 6,
      name: MyApp.isEnglish?'No phone/Tv in bed':'Fara telefon si tv in pat',

      why: MyApp.isEnglish?'You need to train your brain to think of the bed as a place to sleep, not a place to'
          ' use your phone/Tv, plus the blue light will keep you awake and decrease your sleep quality.':
        'Trebuie sa iti antrenezi creierul sa gandeaca ca patul este locul somnului, nu locul unde iti folosesti'
            'electronicele, plus lumina albastra care te v-a tine treaz si iti v-a distruge calitatea somnului',

      howToDoIt: MyApp.isEnglish?'Use your bed only for sleep and read a book(especially one that doesn\'t stimulate'
          ' your brain a lot, for example, fiction)':
        'Foloseste-ti patul numai pentru somn, si citeste o carte care nu iti stimuleaza mult mintea',
      tldr: '',
      effort: 35,
      brainImprovement: 60,
      energyImprovement: 60,
      healthImprovement: 60,
      reset: resetMorning,
      type: type_habits,
      lastChecked: data.getLastChecked(6),
    ),
    RosseAction(
      id: 7,
      name: MyApp.isEnglish?'I\'ve loosened up my spine the night before with yoga or a foam roller':
        'Am avut grija de spinarea mea noaptea trecuta cu yoaga sau un foam roller',
      why: MyApp.isEnglish?'Your sleep is split up in 3 stages. In light sleep, you process memories and emotions,'
          ' and your metabolism regulates itself. In Deep-sleep, your body heals. R.E.M sleep is good for emotion'
          ' regulation and memory. You should strive to get as much Deep and R.E.M sleep as possible since light'
          ' sleep usually lasts for 50% or more of the night. You can sleep more in 7 hours than in 10, even though'
          ' it\'s not a good idea to sleep less :)).':
        'Somnul tau este impartit in 3 perioade. In \'light sleep\', procesezi memoriile si emotiile, iar'
            ' metabolismul este reglat. In \'Deep-Sleep\' corpul tau se regenereaza. Somnul de tip \'R.E.M\''
            ' este bun pentru reglarea emotiilor si memorie. Incearca sa obtii cat mai mult somn de tip Deep si '
            'R.E.M deoarece somnul de tip Light dureaza peste 50% din noapte. Daca obtii mai mult Deep si R.E.M,'
            ' poti dormii mai mult in 7 ore decat in 10, chiar daca nu este recomandat',
      howToDoIt: 'https://www.healthline.com/health/stretching-before-bed',
      tldr: '',
      effort: 50,
      brainImprovement: 70,
      energyImprovement: 80,
      healthImprovement: 30,
      reset: resetEvening,
      type: type_habits,
      lastChecked: data.getLastChecked(7),
    ),
    RosseAction(
      id: 8,
      name: MyApp.isEnglish?'I\'ve followed a low inflammation diet':'Am urmat o dieta slab-inflamatorie',
      why: MyApp.isEnglish?'Inflammation is the immune system’s response to an irritant. It can be caused '
          'by something like a wound or eating bad food. It can cause severe brain fog':
        'Inflamatia este raspunsul sistemului tau imunitar la un iritant. Poate fii cauzata de rani, sau'
            'consumarea mancarii nepotrivite. Poate cauza o cadere drastica in claritate mentala',
      howToDoIt: MyApp.isEnglish?'It can be (food-wise) be avoided by not eating the following foods: \n'
          ' •Processed foods especially fast food of any type and those with added sugar \n •Excessive alcohol'
          ' \n •Bad oils(sunflower oil and soybean oil) \n •Refined and/or Processed carbs(rice, bread, white'
          ' pasta, baked goods) \n •Processed snacks and sodas \n •Premade deserts(cookies, ice-cream) \n\n'
          ' Maybe there are a lot of limitations, but it\'s your time to get creative and cook something '
          'delicious with what\'s left':
        'Alimentar, poate fii prevenita prin evitarea urmatoarelor: \n •Mancare procesata in special fast food'
            'de orice tip si zahar adaugat \n •Alcool excesiv \n •Anumite uleiuri(de soia si floarea soarelui)'
            '\n •Carbohidrati rafinati si procesati(orez, paine, paste albe, patiserie) \n •Gustari si Sucuri'
            ' procesate \n •Deserturi(biscuiti, inghetata) \n\n Poate sunt multe limitari, dar acum e timpul tau'
            'sa gatesti ceva delicios cu ce a ramas',

      tldr: MyApp.isEnglish?'Don\'t eat processed foods(especially fast food), Bad oils, Carbs(especially sugar'
          ' and refined carbs)':'Nu consuma mancaruri procesate(in special fast food), Uleiuri nesanatoase, '
          'carbohidrati rafinati, zahar',
      effort: 100,
      brainImprovement: 90,
      energyImprovement: 70,
      healthImprovement: 90,
      reset: resetEvening,
      type: type_nutrition,
      lastChecked: data.getLastChecked(8),
    ),
    RosseAction(
      id: 9,
      name: MyApp.isEnglish?'I\'ve drunk water in the last 3 hours(Will automatically uncheck after 3 hours pass)':
        'Am baut apa in ultimele 3 ore(Se v-a dezactiva automat dupa 3 ore)',

      why: MyApp.isEnglish?'Your body is 60% water so dehydration may cause headaches and tiredness. Make sure'
          ' you’re drinking water at least every 3 hours, it\'s free, almost':
        'Corpul tau contine 60% apa, iar dezhidratarea iti poate cauza dureri de cap si oboseala. Fii atent sa'
            ' bei apa macar la fiecare 3 ore. E gratis, aproape',

      howToDoIt: MyApp.isEnglish?'Get a refillable water bottle and carry it with you wherever you go. Also, '
          'make sure to fill it and put it next to your bed the night before and drink it in the morning':
        'I-ati o sticla portabila si car-o oriunde mergi, Inca ceva, fii atent sa o umplii si sa o pui langa'
            'patul tau noaptea si sa o bei dimineata',
      tldr: '',
      effort: 10,
      brainImprovement: 35,
      energyImprovement: 70,
      healthImprovement: 10,
      reset: resetEveryThreeHours,
      type: type_habits,
      lastChecked: data.getLastChecked(9),
    ),
    RosseAction(
      id: 10,
      name: MyApp.isEnglish?'I\'ve eaten nutritious foods today(Kale, Avocado, Almonds, Eggs, Spinach, etc).':
        'Am consumat alimente puternic nutrionanle(Napi, Avocado, Migdale, Oua, Spanac)',

      why: MyApp.isEnglish?'The lack of some vitamins/minerals may cause fatigue(Vit. C), inflammation(Vit. C),'
          ' a decline of mental function(Vit. E), weakness(Vit. C) and sometimes oxidative stress(Vit C).':
        'Lipsa a unor vitamine poate cauza oboseala(Vit. C), inflamatie(Vit. C), o decadere in functie cog'
            'nitiva(Vit. E), slabiciune(Vit. C) si uneori stres oxidativ(Vit.C)',

      howToDoIt: MyApp.isEnglish?'Do meal prep, make a shake, find a recipe to integrate those ingredients('
          'there are way more foods that are nutritious but these will give the most bang for you buck): '
          '\n •Kale(This thing is one of the most vitamins/minerals rich foods you could ever eat) \n •Almonds '
          '\n •Avocados \n •Spinach \n •Broccoli \n •Tomato \n •Eggs \n •Organ meats':
        "Preparati mancarea in advans, fa-ti un shake, gaseste o reteta pentru a integra aceste ingrediente("
            "exista mult mai multe alimente care sunt nutritionale, dar acestea contin o cantitate aparte): "
            "\n •Napi(Posibil cel mai bogat aliment pe care il poti manca) \n •Migdale \n •Avocado \n •Spanac"
            "\n •Brocoli \n •Rosii \n •Oua \n •Organe(de animale)",
      tldr: '',
      effort: 60,
      brainImprovement: 80,
      energyImprovement: 80,
      healthImprovement: 80,
      reset: resetEveryDay,
      type: type_nutrition,
      lastChecked: data.getLastChecked(10),
    ),
    RosseAction(
      id: 11,
      name: MyApp.isEnglish?'I have not consumed alcohol today':'Nu am consumat alcol astazi',
      why: MyApp.isEnglish?'It\'s been proven that alcohol kills your brain cells and destroys your Deep and'
          ' R.E.M sleep(TAKE THIS SERIOUSLY). Also, you can\'t do good work while you are drunk and alcohol'
          ' dehydrates you without feeling it':
        'Este demonstrat ca alcolul iti omoara neuronii si iti distruge somnul de tip Deep si R.E.M(ia asta'
            'in serios). Sa nu mai spunem ca nu poti sa faci munca calitativa atata timp cat esti baut. Plus,'
            ' alcoolul te dezhidrateaza fara ca tu sa simti',

      howToDoIt: MyApp.isEnglish?'Install a sobriety app (I recommend I am sober ) and see how much money you'
          ' save by not drinking': 'Instaleaza o aplicatie de sobrieitata( Recomand I am sober ) si vezi cati'
          'bani salvezi daca nu consumi alcool.',
      tldr: '',
      effort: 50,
      brainImprovement: 100,
      energyImprovement: 60,
      healthImprovement: 85,
      reset: resetEvening,
      type: type_habits,
      lastChecked: data.getLastChecked(11),
    ),
    RosseAction(
      id: 12,
      name: MyApp.isEnglish?'I\'ve done intermittent fasting':'Am urmat postul intermitent',

      why: MyApp.isEnglish?'Digestion is one of the most energy-expensive processes in our bodies and limiting '
          'it to 1-2 times a day makes you more efficient. Once the glucose in your body is consumed and insulin'
          ' lowers, your body starts tapping into your ketones(fat transformed in the liver used as energy for'
          ' your body), which is more efficient(especially in your brain since it\'s more efficient with oxygen)'
          '. The benefits of intermittent fasting are: \n •Mental clarity(a lot)\n •More BDNF(since lower insulin'
          ')(the hormone that helps you grow brain cells and maintain the ones you have )\n •Slower aging \n •'
          'Longevity(Eating 30% less will make you live 30% more)\n\n \'Hunger games\'':

        'Digestia este una dintre cele mai scumpe in energie procese din organism, iar limitarea ei la o data sau'
            'doua pe zii o sa te faca mai eficient. Odata ce glucoza din organism este consumata si insulina scade'
            ', corpul tau incepe sa iti foloseasca ketosina(grasime procesata in ficat, folosita ca si energie'
            ' pentru corp), care este mai eficienta(in special in creier deoarece este mai eficienta cu oxigenul)'
            '. Beneficiile postului intermitent sunt: \n •Claritate Mentala(o cantitate considerabila) \n •'
            'O cantitate crescuta de BDNF(deoarece insulina a scazut)(hormonul care te ajuta sa creezi si sa'
            'mentii sanatosi neuronii) \n •Inbatranire mai inceata \n •'
            'Longevitate(Deoarece consumi mai putine calorii)',

      howToDoIt: MyApp.isEnglish?'Intermittent fasting is the act of restricting your eating period in 8 or fewer hours. '
          'Don\'t worry, your body will adapt to your new eating period(the first 4 days of I.F. are the hardest)'
          '. And hunger usually comes to a couple of minutes before your eating time and goes again, after a '
          'couple of minutes(maximum 1 hour).':
        'Postul intermitent este actul de restrictionare a perioadei de mancare in 8 sau mai putine ore. Nu te '
            'speria, corpul tau se v-a obijnuii cu noua ta perioada de masa(Primele 4 zile sunt cele mai grele)'
            '. Si de obicei foamea apare cu cateva minute inainte de fosta perioada de masa si dispare dupa alte'
            ' cateva minute',

      tldr: MyApp.isEnglish?'Eat for 8 hours, don\'t eat for 16':'Mananca pentru 8 ore, nu manca pentru 16 ore',
      effort: 90,
      brainImprovement: 100,
      energyImprovement: 100,
      healthImprovement: 100,
      reset: resetEvening,
      type: type_nutrition,
      lastChecked: data.getLastChecked(12),
    ),
    RosseAction(
      id: 13,
      name: MyApp.isEnglish?'I\'ve done a mindfulness exercise today':'Am meditat astazi',

      why: MyApp.isEnglish?'\'More than 80% of the world-class performers I\'ve interviewed have some sort of '
          'daily mindfulness practice\' -Tim Ferris. \n\n The benefits of meditation are the following: '
          '\n •Improved focus and self-awareness drastically(and productivity) \n •Reduces stress \n •Better '
          'control over anxiety \n •Changes the brains default mode, most of the time unfocused and unhappy '
          '\n •More motivation \n •Improved sleep(especially if you do it in bed)(and much more). Meditation '
          'is so powerful that it can even replace the prescriptions for ADHD patients).':
        '\'Peste 80% din interpretii de talie mondiala mediteaza\' - Tim Ferris \n\n Beneficiile meditatiile sunt:'
            '\n •Concentrare si propia-constienta ridicata(si productivitatea) \n •Stress redus \n •Un control mai'
            ' bun asupra anxietatii \n •Schimbarea modului implicit al creierului, de multe ori neconcentrat si'
            ' nefericit. \n •Mai multa motivatie \n •Somn mai bun(in special daca o faci ca sa adormi) \n(Si '
            'mult mai multe). Meditatie este atat de puternica incat poate inlocuii perscriptia pentru pacientii'
            ' de ADHD',

      howToDoIt: MyApp.isEnglish?'Set a timer for 3-10 minutes(or more if you feel lucky) and start focusing '
          'only on your breath. If you find yourself thinking about other things, bring your attention back to'
          ' your breath(and don\'t expect to be perfect in this exercise).':
        'Porneste un cronometru pentru 3-10 minute(Sau mai mult daca te simti norocos) si incepe sa iti pui toata'
            ' atentia pe respiratia ta. Daca te regasesti gandindu-te la alte chestii, adu-ti atentia inapoi la'
            ' respiratie(nu te astepta sa fii perfect din prima)',
      tldr: '',
      effort: 15,
      brainImprovement: 100,
      energyImprovement: 0,
      healthImprovement: 5,
      reset: resetEveryDay,
      type: type_habits,
      lastChecked: data.getLastChecked(13),
    ),
    RosseAction(
      id: 14,
      name: MyApp.isEnglish?'I\'ve done at least 5 minutes of exercise today':'Am facut macar 5 minute de miscare astazi',
      why: MyApp.isEnglish?'"If there were a drug that could do for human health everything that exercise can, it'
          ' would likely be the most valuable pharmaceutical ever developed." - Mark Tarnopolsky. Exercise is '
          'deeply linked with the brain because back then, survival and moving your body were our only objective'
          ' and that was the only reason we needed a brain. Exercise has the following benefits: \n\n •You learn'
          ' faster \n •Less stress \n •Reduced anxiety \n •Better mood \n •More focus \n •More BDNF(The protein '
          'in your brain that creates and maintains brain cells) \n •More energy(a lot) \n •Longevity and you '
          'prevent more diseases including heart ones \n •Better sleep':
        '"Daca ar exista o pastila care sa faca pentru sanatatea omului tot ce face miscarea, cel mai probabil'
            ' ar fii cea mai vanduta pastila facuta vreodata" - Mark Tarnopolsky. Miscarea fizica este foarte'
            ' integrata cu capacitatea cognitiva, deoarece, in trecut, supravietuirea si miscarea corpului erau'
            ' singurele noastre obiective si aceasta era singura functie pentru creierul nostru. Miscarea fizica'
            ' are urmatoarele beneficii: \n •Retii informatia mai usor \n •Stress scazut \n •Anxietate scazuta'
            '\n •Bunastare ridicata \n •Atentie ridicata \n •BDNF ridicat(proteina din creier care favorizeaza '
            'creearea si mentinerea celulelor nervoase) \n •Mult mai multa energie \n •Longevitate si mai putine'
            ' boli si afectiuni, in special cele de inima \n •Calitate a somnului ridicata',

      howToDoIt: MyApp.isEnglish?'Try a 5 minute HIIT workout(It\'s the most bang for your buck).Do Burpees, Jumping Squats '
          'and Jumping Jacks for 5-10 minutes without resting':
        'Incearca un antrenament de 5 minute de tip HIIT(Este cel mai eficient pentru a face rost de beneficiile'
            ' miscarii fizice)',
      tldr: '',
      effort: 30,
      brainImprovement: 100,
      energyImprovement: 100,
      healthImprovement: 100,
      reset: resetEveryDay,
      type: type_habits,
      lastChecked: data.getLastChecked(14),
    ),
    RosseAction(
      id: 15,
      name: MyApp.isEnglish?'I\'ve loosen up my mind before bed':'Mi-am relaxat mintea inainte de somn',
      why: MyApp.isEnglish?'Shutting up your monkey brain before sleep will help you fall asleep faster':
        'Facandu-ti mintea sa taca inainte de somn te v-a ajuta sa adormi mai repede',
      howToDoIt: MyApp.isEnglish?'Just write your thoughts in a journal or do a mindfulness practice while in bed':
        "Pune-ti gandurile intr-un jurnal ori mediteaza",
      tldr: '',
      effort: 30,
      brainImprovement: 40,
      energyImprovement: 20,
      healthImprovement: 20,
      reset: resetEvening,
      type: type_insomnia,
      lastChecked: data.getLastChecked(15),
    ),
    RosseAction(
      id: 16,
      name: MyApp.isEnglish?'I\'ve slept in a cool environment the night before':'Am dormit intr-o camera racoroasa',
      why: MyApp.isEnglish?'Your body lowers its temperature before sleep. So doing it artificially will help'
          ' you fall asleep faster. But don\'t lower it too much':
        'Corpul tau isi coboara temperatura inainte de a adormii. Deci, o camera racoroasa v-a stimula pozitiv'
            ' acest proces si vei adormii mai rapid',
      howToDoIt: MyApp.isEnglish?'Lower your room temperature, or if you are willing to do it, it will help a'
          ' lot, take a cold shower':
        'Coboara-ti temperatura camerei sau fa un dus rece daca poti',
      tldr: '',
      effort: 40,
      brainImprovement: 45,
      energyImprovement: 50,
      healthImprovement: 40,
      reset: resetMorning,
      type: type_sleep,
      lastChecked: data.getLastChecked(16),
    ),
    RosseAction(
      id: 17,
      name: MyApp.isEnglish?'My bedroom is pitch dark and without noises':'Dormitorul meu este silentios si intunecat',
      why: MyApp.isEnglish?'So you will secrete more melatonin': 'Ca sa adormi mai usor',
      howToDoIt: MyApp.isEnglish?'Wear an eye mask and earplugs, or even better, shut off your electronics and buy'
          ' black curtains':'Poarta masca pentru ochii si dopuri de ureche daca este nevoie. Foloseste o perdea neagra ',
      tldr: '',
      effort: 20,
      brainImprovement: 45,
      energyImprovement: 50,
      healthImprovement: 40,
      reset: resetEvening,
      type: type_sleep,
      lastChecked: data.getLastChecked(17),
    ),
    RosseAction(
      id: 18,
      name: MyApp.isEnglish?'I\'ve slept in a good bed':'Am dormit intr-un pat bun',
      why: MyApp.isEnglish?'You spend a 3\'rd of your life sleeping, so sleeping in a good bed will help your'
          ' spine, helping you feel more refreshed and energetic throughout the day':
        'Iti consumi o treime din viata dormind, deci dormind intr-un pat bun o sa iti ajute spinarea, ajutandu-te'
            ' sa te simti mai revigorat si energetic pe parcursul zilei',
      howToDoIt: MyApp.isEnglish?'Buying a good mattress is a 1-time investment and it\'s so worth it':
        'Cumpararea unei saltele bune este o investitie se face o singura data si se merita',
      tldr: '',
      effort: 100,
      brainImprovement: 80,
      energyImprovement: 100,
      healthImprovement: 30,
      reset: resetNever,
      type: type_sleep,
      lastChecked: data.getLastChecked(18),
    ),
    RosseAction(
      id: 19,
      name: MyApp.isEnglish?'Quit addictions':'Lasa-te de dependente',
      why: MyApp.isEnglish?'Once you quit addictions you will have more focus and energy(your brain will be not'
          ' always searching for the \'eazy fix\').':
        'Odata ce te vei lasa de dependente o sa ai mai multa energie si atentie(creierul tau nu v-a mai cauta'
            'modalitatea usoara si scurta de a-si procura dopamina)',
      howToDoIt: MyApp.isEnglish?'Consider quitting these following addictions : \n\n •Quit social media(Now that'
          ' I quit social'
          ' media myself, I regret every moment spend of it, you might too). Social media doesn\'t give you some'
          ' cocaine-like dopamine levels, but it offers them in short bursts for a long period \n •Start Nofap'
          '(Sex is as addictive as cocaine, so it\'s not a good idea to provide it to your brain everytime it'
          ' needs it. Nofap can decrease anxiety, depression, brainfog,and improves concentrations. \n • Quit'
          ' Alcohol, Drugs and Ciggarettes(These will furthermore damage your brain and your performance)\n\n '
          '.Install a sobriety app like I am sober and see how much money, time and energy you save.':
        'Considera sa te lasi de dependentele urmatoare: \n •Social media(acum ca m-am lasat si eu, regret fiecare'
            ' moment pe care l-am consumat acolo, s-ar putea si tu). Social media nu o sa iti dea foate multa do'
            'pamina ca si alte dependente, dar o sa ti-o dea constant si pentru o perioada timp \n •Incearca nofap'
            '\n •Lasa-te de alcool, droguri si tigari(Acestea o sa iti compromita si mai mult creierul si'
            ' performanta) \n\n Instaleaza o aplicatie de sobrieitate ca si I am sober si vezi cati bani si cate'
            ' ore salvezi',
      tldr: '',
      effort: 100,
      brainImprovement: 90,
      energyImprovement: 100,
      healthImprovement: 100,
      reset: resetEvening,
      type: type_habits,
      lastChecked: data.getLastChecked(19),
    ),
    RosseAction(
      id: 20,
      name: MyApp.isEnglish?'I\'ve avoided any sort of illegal substances':'Nu am consumat droguri(#anti-drog)',
      why: MyApp.isEnglish?'1. Your dopamine receptors will be super-stimulated and no activity will be as fun '
          'as it once was, leading you to depression. \n2. Your sleep will be completely messed up. If you are'
          ' taking any sort of drug to fall asleep, please stop because even though you might fall asleep faster,'
          ' your quality of your sleep will be destroyed. \n3. Depending on the drug you are taken, you might '
          'overdose, damage your internal organs and/or your brain':

      '• Receptorii tai de dopamina v-or fii supra-stimulati si nici o activitate v-a fii lafel de distractiva'
          ' cum a forst odata, aducandu-te la depresie. \n •Somnul tau v-a fii compromis. Daca consumi droguri'
          ' ca sa adormi, te rog opreste-te deoarece chiar daca o sa adormi mai repede, calitatea somnului v-a'
          ' fii distrusa. \n •Poti face supradoza, poti sa iti distrugi organele interne si/sau creierul',

      howToDoIt: MyApp.isEnglish?'First admit that you have a problem. There is no shame in that. We are all'
          ' humans and make mistakes. Second, try going to a rehab, or if this is too much for you, at least '
          'install a sobriety app like \"I am sober\". But please take some sort of action. It\'s almost '
          'impossible to overcome this only by yourself':

      'In primul rand recunoaste ca ai o problema. Nu este rusine in asta. Toti suntem oameni si gresim. In al '
          'doilea rand, incearca sa mergi la un rehab, iar daca este prea mult pentru tine, instaleaza o aplicatie'
          ' de sobrieitate ca si I am sober. Dar te rog fa un pas inainte. Este aproape imposibil sa te lasi fara'
          ' nici un ajutor',
      tldr: '',
      effort: 90,
      brainImprovement: 100,
      energyImprovement: 100,
      healthImprovement: 100,
      reset: resetMorning,
      type: type_nutrition,
      lastChecked: data.getLastChecked(20),
    ),
  ];
}



//Specific for this app

// getColorValue(int index) {
//   switch(index){
//     case 1 : return MyColors.color_red;break;
//     case 2 : return MyColors.color_secondary;break;
//     case 3 : return MyColors.color_purple;break;
//     case 4 : return MyColors.color_green;break;
//     case 5 : return MyColors.color_cyan;break;
//     case 6 : return MyColors.color_orange;break;
//     case 7 : return MyApp.isDarkMode?Colors.white:MyColors.color_black;break;
//     default : return MyColors.color_primary;break;
//   }
// }