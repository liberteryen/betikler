echo "flatpak list --columns=application --app > flatpaks.txt" 
echo "yedeklemedene evvel bunu kullan"
sleep 2
#!/bin/bash

USER_BACKUP="flatpak-user.tar.xz"
SYSTEM_BACKUP="flatpak-system.tar.xz"
APP_LIST="flatpaks.txt"

function backup_user() {
    echo "📦 Kullanıcı flatpak verileri yedekleniyor..."
    tar -cJpf "$USER_BACKUP" ~/.local/share/flatpak ~/.var/app
    echo "✅ $USER_BACKUP oluşturuldu."
}

function backup_system() {
    echo "📦 Sistem flatpak verileri yedekleniyor..."
    sudo tar -cJpf "$SYSTEM_BACKUP" /var/lib/flatpak
    echo "✅ $SYSTEM_BACKUP oluşturuldu."
}

function restore_user() {
    if [ ! -f "$USER_BACKUP" ]; then
        echo "❌ $USER_BACKUP bulunamadı!"
        return
    fi
    echo "📂 Kullanıcı flatpak yedeği geri yükleniyor..."
    tar -xJpf "$USER_BACKUP" -C /
    echo "✅ Kullanıcı flatpak geri yüklendi."
}

function restore_system() {
    if [ ! -f "$SYSTEM_BACKUP" ]; then
        echo "❌ $SYSTEM_BACKUP bulunamadı!"
        return
    fi
    echo "📂 Sistem flatpak yedeği geri yükleniyor..."
    sudo tar -xJpf "$SYSTEM_BACKUP" -C /
    echo "✅ Sistem flatpak geri yüklendi."
}

function install_flatpaks_from_list() {
    if [ -f "$APP_LIST" ]; then
        echo "📥 flatpaks.txt içindeki uygulamalar yükleniyor..."
        cat "$APP_LIST" | xargs -r -n1 flatpak install -y
        echo "✅ Uygulama yüklemesi tamamlandı."
    else
        echo "⚠️ $APP_LIST bulunamadı, uygulama kurulumu atlandı."
    fi
}

# Argüman kontrolü
ACTION=""
DO_USER=false
DO_SYSTEM=false

for arg in "$@"; do
    case "$arg" in
        --yedekle)
            ACTION="backup"
            ;;
        --restore)
            ACTION="restore"
            ;;
        --user)
            DO_USER=true
            ;;
        --system)
            DO_SYSTEM=true
            ;;
        *)
            echo "❌ Geçersiz argüman: $arg"
            echo "Kullanım: $0 [--yedekle|--restore] [--user] [--system]"
            exit 1
            ;;
    esac
done

# Varsayılan olarak her ikisini yap
if [ "$DO_USER" = false ] && [ "$DO_SYSTEM" = false ]; then
    DO_USER=true
    DO_SYSTEM=true
fi

# İşlem seçimi
if [ "$ACTION" = "backup" ]; then
    echo "🔄 Yedekleme başlatılıyor..."
    $DO_USER && backup_user
    $DO_SYSTEM && backup_system
    echo "✅ Yedekleme tamamlandı."
elif [ "$ACTION" = "restore" ]; then
    echo "🔄 Geri yükleme başlatılıyor..."
    install_flatpaks_from_list
    $DO_USER && restore_user
    $DO_SYSTEM && restore_system
    echo "✅ Geri yükleme tamamlandı."
else
    echo "❌ Hangi işlemin yapılacağı belirtilmedi: --yedekle veya --restore"
    exit 1
fi
