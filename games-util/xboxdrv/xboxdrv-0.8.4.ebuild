# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xboxdrv/xboxdrv-0.8.4.ebuild,v 1.5 2012/11/29 02:06:18 ssuominen Exp $

EAPI=2
inherit scons-utils toolchain-funcs linux-info

MY_P=${PN}-linux-${PV}
DESCRIPTION="Userspace Xbox 360 Controller driver"
HOMEPAGE="http://pingus.seul.org/~grumbel/xboxdrv/"
SRC_URI="http://pingus.seul.org/~grumbel/xboxdrv/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-libs/boost
	virtual/udev
	sys-apps/dbus
	dev-libs/glib:2
	virtual/libusb:1
	x11-libs/libX11"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

CONFIG_CHECK="~INPUT_EVDEV ~INPUT_JOYDEV ~INPUT_UINPUT ~!JOYSTICK_XPAD"

src_compile() {
	escons \
		BUILD=custom \
		CXX="$(tc-getCXX)" \
		CXXFLAGS="-Wall ${CXXFLAGS}" \
		LINKFLAGS="${LDFLAGS}" \
		|| die
}

src_install() {
	dobin xboxdrv || die
	doman doc/xboxdrv.1
	dodoc AUTHORS NEWS PROTOCOL README TODO
}
