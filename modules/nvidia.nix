{ config, pkgs, ... }:

{
  # Kernel параметры для NVIDIA
  boot.kernelParams = [ 
    "nvidia-drm.modeset=1"  # Включает modesetting для NVIDIA
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"  # Для suspend/resume
  ];

  # NVIDIA драйверы
  services.xserver.videoDrivers = [ "nvidia" ];

  # Аппаратная графика с поддержкой 32-bit
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Для поддержки 32-битных приложений (Steam, Wine)
  };

  # Настройки NVIDIA
  hardware.nvidia = {
    # Используем проприетарные драйверы
    modesetting.enable = true;
    
    # Включаем power management (может помочь с suspend/resume)
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    
    # Открываем nvidia-settings для настройки
    nvidiaSettings = true;
    
    # Выбираем стабильную версию драйвера
    # Для GTX 1080 Ti (Pascal) подходит production branch
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
    # Для Hyprland важно включить
    open = false;  # GTX 1080 Ti не поддерживает open-source драйверы
  };

  # Environment variables для NVIDIA + Wayland/Hyprland
  environment.sessionVariables = {
    # NVIDIA Wayland
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    
    # Для Hyprland - фикс для курсора на NVIDIA
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # CUDA (если планируете использовать)
    CUDA_CACHE_PATH = "$HOME/.cache/cuda";
  };

  # NVIDIA и GPU утилиты
  environment.systemPackages = with pkgs; [
    # NVIDIA утилиты и инструменты
    nvtopPackages.nvidia     # Мониторинг GPU (аналог htop для видеокарты)
    mangohud                 # Игровой оверлей с FPS и статистикой
    
    # Аппаратное ускорение видео
    libva                    # Video Acceleration API
    libva-utils              # Утилиты для проверки VA-API
    libva-vdpau-driver       # VA-API драйвер для VDPAU
    
    # Vulkan поддержка (для игр и 3D приложений)
    vulkan-tools             # vulkaninfo, vkcube и др.
    vulkan-loader            # Загрузчик Vulkan
    vulkan-validation-layers # Слои валидации для разработки
    
    # OpenGL утилиты
    mesa-demos               # glxinfo, glxgears и другие OpenGL утилиты
    
    # CUDA (раскомментируйте если нужно)
    # cudaPackages.cudatoolkit  # CUDA toolkit для GPU вычислений
  ];

  # Steam с полной поддержкой
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;      # Открыть порты для Remote Play
    dedicatedServer.openFirewall = true; # Открыть порты для dedicated серверов
    gamescopeSession.enable = true;      # Gamescope compositor для игр
  };

  # GameMode - автоматическая оптимизация производительности для игр
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;  # Повышенный приоритет для игр
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";  # Для AMD, но не помешает
      };
    };
  };
}

