//
//  OnboardingLocalization.swift
//  Phone Number Tracker
//

struct OnboardingLocalization {
    let detailsTitle: String
    let detailsSubtitle: String
    let searchTitle: String
    let searchSubtitle: String
    let locationTitle: String
    let locationSubtitle: String
    let historyTitle: String
    let historySubtitle: String
    let next: String
    let start: String

    static func copy(for language: String) -> OnboardingLocalization {
        localizations[language] ?? localizations["English"]!
    }

    private static let localizations: [String: OnboardingLocalization] = [
        "English": .init(
            detailsTitle: "Discover Phone\nNumber Details",
            detailsSubtitle: "Find country, operator, and\nbasic location info for any\nphone number.",
            searchTitle: "Fast & Easy Search -\nWorks Worldwide",
            searchSubtitle: "Enter a phone number and\ninstantly get location and\noperator info.",
            locationTitle: "Live Location & Call\nInfo",
            locationSubtitle: "Identify caller location on map,\ncountry code, and network.",
            historyTitle: "Save Number Lookup\nHistory",
            historySubtitle: "Quickly access previously\nsearched phone numbers\nanytime, in one place.",
            next: "Next",
            start: "Start"
        ),
        "Chinese": .init(
            detailsTitle: "发现电话号码\n详细信息",
            detailsSubtitle: "查找任意电话号码的国家、\n运营商和基本位置信息。",
            searchTitle: "快速轻松搜索 -\n全球可用",
            searchSubtitle: "输入电话号码，即可获取\n位置和运营商信息。",
            locationTitle: "实时位置和来电\n信息",
            locationSubtitle: "识别来电位置、国家代码\n和网络信息。",
            historyTitle: "保存号码查询\n历史",
            historySubtitle: "随时快速访问之前搜索过的\n电话号码。",
            next: "下一步",
            start: "开始"
        ),
        "Spanish": .init(
            detailsTitle: "Descubre detalles del\nnúmero telefónico",
            detailsSubtitle: "Encuentra país, operador e\ninformación básica de ubicación\npara cualquier número.",
            searchTitle: "Búsqueda rápida y fácil -\nFunciona mundialmente",
            searchSubtitle: "Ingresa un número y obtén al\ninstante ubicación y operador.",
            locationTitle: "Ubicación en vivo e\ninfo de llamada",
            locationSubtitle: "Identifica ubicación, código de\npaís y red del llamante.",
            historyTitle: "Guarda historial de\nbúsquedas",
            historySubtitle: "Accede rápidamente a números\nbuscados anteriormente.",
            next: "Siguiente",
            start: "Iniciar"
        ),
        "French": .init(
            detailsTitle: "Découvrez les détails du\nnuméro de téléphone",
            detailsSubtitle: "Trouvez le pays, l'opérateur et\nles infos de localisation de base.",
            searchTitle: "Recherche rapide et simple -\nPartout dans le monde",
            searchSubtitle: "Entrez un numéro et obtenez\nla localisation et l'opérateur.",
            locationTitle: "Localisation en direct et\ninfos d'appel",
            locationSubtitle: "Identifiez la localisation, le code\npays et le réseau.",
            historyTitle: "Enregistrer l'historique\nde recherche",
            historySubtitle: "Accédez vite aux numéros\nrecherchés précédemment.",
            next: "Suivant",
            start: "Démarrer"
        ),
        "Russian": .init(
            detailsTitle: "Узнайте данные\nномера телефона",
            detailsSubtitle: "Найдите страну, оператора и\nбазовую информацию о месте.",
            searchTitle: "Быстрый поиск -\nработает по всему миру",
            searchSubtitle: "Введите номер и сразу получите\nместо и оператора.",
            locationTitle: "Живая геолокация и\nинформация о звонке",
            locationSubtitle: "Определяйте место, код страны\nи сеть абонента.",
            historyTitle: "Сохраняйте историю\nпоиска номеров",
            historySubtitle: "Быстро открывайте ранее\nнайденные номера.",
            next: "Далее",
            start: "Старт"
        ),
        "Hindi": .init(
            detailsTitle: "फोन नंबर की\nजानकारी देखें",
            detailsSubtitle: "किसी भी नंबर का देश, ऑपरेटर\nऔर बेसिक लोकेशन जानें।",
            searchTitle: "तेज और आसान खोज -\nदुनिया भर में काम करे",
            searchSubtitle: "नंबर डालें और तुरंत लोकेशन\nऔर ऑपरेटर जानकारी पाएं।",
            locationTitle: "लाइव लोकेशन और\nकॉल जानकारी",
            locationSubtitle: "कॉलर की लोकेशन, देश कोड\nऔर नेटवर्क पहचानें।",
            historyTitle: "नंबर खोज इतिहास\nसेव करें",
            historySubtitle: "पहले खोजे गए नंबर कभी भी\nजल्दी देखें।",
            next: "आगे",
            start: "शुरू"
        ),
        "Urdu": .init(
            detailsTitle: "فون نمبر کی\nتفصیلات دیکھیں",
            detailsSubtitle: "کسی بھی نمبر کا ملک، آپریٹر\nاور بنیادی مقام معلوم کریں۔",
            searchTitle: "تیز اور آسان تلاش -\nدنیا بھر میں کام کرے",
            searchSubtitle: "نمبر درج کریں اور فوری مقام\nاور آپریٹر معلومات حاصل کریں۔",
            locationTitle: "لائیو لوکیشن اور\nکال معلومات",
            locationSubtitle: "کالر کا مقام، ملک کوڈ اور\nنیٹ ورک پہچانیں۔",
            historyTitle: "نمبر تلاش کی تاریخ\nمحفوظ کریں",
            historySubtitle: "پہلے تلاش کیے گئے نمبر جلدی\nدوبارہ دیکھیں۔",
            next: "اگلا",
            start: "شروع"
        ),
        "Portuguese (Brazil)": .init(
            detailsTitle: "Descubra detalhes do\nnúmero de telefone",
            detailsSubtitle: "Veja país, operadora e\ninformações básicas de localização.",
            searchTitle: "Busca rápida e fácil -\nFunciona no mundo todo",
            searchSubtitle: "Digite um número e receba\nlocalização e operadora.",
            locationTitle: "Localização ao vivo e\ninfo da chamada",
            locationSubtitle: "Identifique localização, código\ndo país e rede.",
            historyTitle: "Salve histórico de\nconsultas",
            historySubtitle: "Acesse rapidamente números\npesquisados anteriormente.",
            next: "Próximo",
            start: "Começar"
        ),
        "German": .init(
            detailsTitle: "Telefonnummern-\nDetails entdecken",
            detailsSubtitle: "Finde Land, Anbieter und\ngrundlegende Standortinfos.",
            searchTitle: "Schnelle einfache Suche -\nweltweit nutzbar",
            searchSubtitle: "Nummer eingeben und sofort\nStandort und Anbieter sehen.",
            locationTitle: "Live-Standort und\nAnrufinfo",
            locationSubtitle: "Erkenne Standort, Ländercode\nund Netzwerk.",
            historyTitle: "Suchverlauf für\nNummern speichern",
            historySubtitle: "Greife schnell auf zuvor\ngesuchte Nummern zu.",
            next: "Weiter",
            start: "Start"
        ),
        "Japanese": .init(
            detailsTitle: "電話番号の詳細を\n確認",
            detailsSubtitle: "国、通信事業者、基本的な\n位置情報を確認できます。",
            searchTitle: "高速で簡単な検索 -\n世界中で利用可能",
            searchSubtitle: "番号を入力して位置と通信\n事業者情報をすぐ取得。",
            locationTitle: "ライブ位置情報と\n通話情報",
            locationSubtitle: "発信者の位置、国番号、\nネットワークを識別。",
            historyTitle: "番号検索履歴を\n保存",
            historySubtitle: "以前検索した番号に\nすばやくアクセス。",
            next: "次へ",
            start: "開始"
        ),
        "Turkish": .init(
            detailsTitle: "Telefon numarası\nayrıntılarını keşfet",
            detailsSubtitle: "Her numara için ülke, operatör\nve temel konum bilgisini bul.",
            searchTitle: "Hızlı ve kolay arama -\nDünya çapında çalışır",
            searchSubtitle: "Numarayı gir, konum ve operatör\nbilgisini hemen al.",
            locationTitle: "Canlı konum ve\narama bilgisi",
            locationSubtitle: "Arayanın konumunu, ülke kodunu\nve ağını belirle.",
            historyTitle: "Numara arama\ngeçmişini kaydet",
            historySubtitle: "Daha önce aranan numaralara\nhızlıca eriş.",
            next: "İleri",
            start: "Başla"
        ),
        "Vietnamese": .init(
            detailsTitle: "Khám phá chi tiết\nsố điện thoại",
            detailsSubtitle: "Tìm quốc gia, nhà mạng và\nthông tin vị trí cơ bản.",
            searchTitle: "Tìm kiếm nhanh dễ dàng -\nHoạt động toàn cầu",
            searchSubtitle: "Nhập số điện thoại để nhận\nvị trí và nhà mạng.",
            locationTitle: "Vị trí trực tiếp và\nthông tin cuộc gọi",
            locationSubtitle: "Nhận diện vị trí, mã quốc gia\nvà mạng của người gọi.",
            historyTitle: "Lưu lịch sử tra cứu\nsố điện thoại",
            historySubtitle: "Truy cập nhanh các số đã\ntìm kiếm trước đây.",
            next: "Tiếp",
            start: "Bắt đầu"
        ),
        "Czech": .init(
            detailsTitle: "Objevte detaily\ntelefonního čísla",
            detailsSubtitle: "Najděte zemi, operátora a\nzákladní informace o poloze.",
            searchTitle: "Rychlé a snadné hledání -\nFunguje celosvětově",
            searchSubtitle: "Zadejte číslo a ihned získejte\npolohu a operátora.",
            locationTitle: "Živá poloha a\ninformace o hovoru",
            locationSubtitle: "Určete polohu volajícího, kód\nzemě a síť.",
            historyTitle: "Uložte historii\nvyhledávání",
            historySubtitle: "Rychle otevřete dříve\nvyhledaná čísla.",
            next: "Další",
            start: "Start"
        )
    ]
}
