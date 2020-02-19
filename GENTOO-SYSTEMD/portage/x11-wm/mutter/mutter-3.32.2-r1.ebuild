# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit gnome2 meson virtualx

DESCRIPTION="GNOME 3 compositing window manager based on Clutter"
HOMEPAGE="https://git.gnome.org/browse/mutter/"

LICENSE="GPL-2+"
SLOT="0/0"

IUSE="debug gles2 input_devices_wacom +introspection test udev wayland"

KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"

# libXi-1.7.4 or newer needed per:
# https://bugzilla.gnome.org/show_bug.cgi?id=738944
COMMON_DEPEND="
	>=dev-libs/atk-2.5.3
	>=x11-libs/gdk-pixbuf-2:2
	>=dev-libs/json-glib-0.12.0
	>=x11-libs/pango-1.30[introspection?]
	>=x11-libs/cairo-1.14[X]
	>=x11-libs/gtk+-3.19.8:3[X,introspection?]
	>=dev-libs/glib-2.58.0:2[dbus]
	>=media-libs/libcanberra-0.26[gtk3]
	>=x11-libs/startup-notification-0.7
	>=x11-libs/libXcomposite-0.2
	>=gnome-base/gsettings-desktop-schemas-3.31.0[introspection?]
	gnome-base/gnome-desktop:3=
	>sys-power/upower-0.99:=

	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	>=x11-libs/libXcomposite-0.4
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	>=x11-libs/libXfixes-3
	>=x11-libs/libXi-1.7.4
	x11-libs/libXinerama
	>=x11-libs/libXrandr-1.5
	x11-libs/libXrender
	x11-libs/libxcb
	x11-libs/libxkbfile
	>=x11-libs/libxkbcommon-0.4.3[X]
	x11-misc/xkeyboard-config

	gnome-extra/zenity
	media-libs/mesa[egl]

	gles2? ( media-libs/mesa[gles2] )
	input_devices_wacom? ( >=dev-libs/libwacom-0.13 )
	introspection? ( >=dev-libs/gobject-introspection-1.42:= )
	udev? ( >=virtual/libgudev-232:= )
	wayland? (
		>=dev-libs/libinput-1.4
		>=dev-libs/wayland-1.6.90
		>=dev-libs/wayland-protocols-1.7
		>=media-libs/mesa-10.3[egl,gbm,wayland]
		sys-apps/systemd
		>=virtual/libgudev-232:=
		>=virtual/libudev-136:=
		x11-base/xorg-server[wayland]
		x11-libs/libdrm:=
	)
"
DEPEND="${COMMON_DEPEND}
	>=sys-devel/gettext-0.19.6
	virtual/pkgconfig
	x11-base/xorg-proto
	test? ( app-text/docbook-xml-dtd:4.5 )
	wayland? ( >=sys-kernel/linux-headers-4.4 )
	>=dev-util/meson-0.50
"
RDEPEND="${COMMON_DEPEND}
	!x11-misc/expocity
"

PATCHES=(
	"${FILESDIR}"/mutter-281.patch
	"${FILESDIR}"/mutter-520.patch
	"${FILESDIR}"/mutter-576.patch
        "${FILESDIR}"/mutter-602.patch
)

src_configure() {
	local emesonargs=(
		-Dopengl=true
		-Degl=true
		-Dglx=true
		-Dsm=true
		$(meson_use gles2)
		$(meson_use wayland native_backend)
		$(meson_use wayland)
		$(meson_use udev)
		$(meson_use input_devices_wacom libwacom)
		-Dremote_desktop=false
		$(meson_use wayland egl_device)
		$(meson_use udev)
		-Dpango_ft2=true
		-Dstartup_notification=true
		$(meson_use introspection)
		$(meson_use test cogl_tests)
		$(meson_use test clutter_tests)
		$(meson_use test tests)
		$(meson_use test installed_tests)
		-Dverbose=true
	)

meson_src_configure
}

src_test() {
	virtx emake check
}

src_install() {
	newenvd "${FILESDIR}"/02nvidiamaxframes 02nvidiamaxframes
	meson_src_install
}

