class VirtViewer < Formula
  desc "App for virtualized guest interaction"
  homepage "https://virt-manager.org/"
  url "https://virt-manager.org/download/sources/virt-viewer/virt-viewer-10.0.tar.xz"
  sha256 "d23bc0a06e4027c37b8386cfd0286ef37bd738977153740ab1b6b331192389c5"
  revision 3

  depends_on "gettext" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build

  depends_on "desktop-file-utils"
  depends_on "glib"
  depends_on "gtk-vnc"
  depends_on "gtk+3"
  depends_on "libvirt-glib"
  depends_on "shared-mime-info"
  depends_on "spice-gtk"

  patch :DATA

  def install
    system "meson", "setup", "builddir", *std_meson_args
    system "ninja", "-C", "builddir", "install", "-v"
  end

  def post_install
    system Formula["shared-mime-info"].opt_bin/"update-mime-database", HOMEBREW_PREFIX/"share/mime"
    system Formula["gtk+3"].opt_bin/"gtk3-update-icon-cache", HOMEBREW_PREFIX/"share/icons/hicolor"
    system Formula["desktop-file-utils"].opt_bin/"update-desktop-database", HOMEBREW_PREFIX/"share/applications"
  end

  test do
    system bin/"virt-viewer", "--version"
  end
end