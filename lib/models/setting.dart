class Setting {
 final String appLanguage;
 final String appVersion;
 final bool isFirstLaunched;

 Setting({required this.appLanguage, required this.isFirstLaunched, required this.appVersion});

 factory Setting.fromJson(Map<String, dynamic> json) {
   return Setting(
     appLanguage: json['appLanguage'],
     appVersion: json['appVersion'],
     isFirstLaunched: json['isFirstLaunched']
   );
 }

 Map<String, dynamic> toJson() {
   return {
     'appLanguage': appLanguage,
     'appVersion': appVersion,
     'isFirstLaunched': isFirstLaunched,
   };
 }
}