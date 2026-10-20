KURULUM
1) supabase.com'da ücretsiz proje açın. SQL Editor'a supabase.sql içeriğini yapıştırıp çalıştırın.
2) Authentication > Providers > Email: "Allow new users to sign up" seçeneğini KAPATIN (güvenlik için şart).
   Authentication > Users > Add user ile kendi e-posta ve şifrenizi oluşturun (Auto Confirm işaretli).
3) Oluşturduğunuz kullanıcıya yalnızca yönetici rolü verin. SQL Editor'da e-posta adresinizi değiştirerek şu sorguyu çalıştırın:
   update auth.users set raw_app_meta_data = coalesce(raw_app_meta_data, '{}'::jsonb) || '{"role":"admin"}'::jsonb where email = 'sizin@e-posta.adresiniz';
   Ardından yönetim panelinde oturumu kapatıp yeniden açın; rol yeni oturum belirtecine bu şekilde yansır.
4) Project Settings > API: Project URL ve anon/publishable key değerlerini config.js içine yazın. Bu anahtarın tarayıcıda görünmesi normaldir; service_role anahtarını kesinlikle kullanmayın.
5) Tüm dosyaları hosting'in kök dizinine yükleyin (haktasmuhasebe.com). Yönetim: haktasmuhasebe.com/admin.html
6) Hosting'de HTTPS'i zorunlu yapın ve mümkünse _headers dosyasındaki güvenlik başlıklarını etkinleştirin.
7) Google: search.google.com/search-console'a siteyi ekleyip sitemap.xml gönderin. business.google.com'da işletme profilinizi açıp web sitesi olarak haktasmuhasebe.com girin.
8) Paylaşım görseli için 1200x630 og.jpg dosyasını kök dizine koyun (varsa hazır gelen og.jpg'yi değiştirin).
