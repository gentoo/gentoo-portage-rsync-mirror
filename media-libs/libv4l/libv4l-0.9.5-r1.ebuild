# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libv4l/libv4l-0.9.5-r1.ebuild,v 1.3 2013/05/05 01:16:50 ssuominen Exp $

EAPI=5
inherit eutils linux-info udev multilib-minimal

MY_P=v4l-utils-${PV}

DESCRIPTION="Separate libraries ebuild from upstream v4l-utils package"
HOMEPAGE="http://git.linuxtv.org/v4l-utils.git"
SRC_URI="http://linuxtv.org/downloads/v4l-utils/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# baselibs is for 32bit libjpeg, pending on converting libjpeg-turbo to multilib build
RDEPEND="virtual/jpeg:=
	virtual/glu
	virtual/opengl
	x11-libs/libX11:=
	!media-tv/v4l2-ctl
	!<media-tv/ivtv-utils-1.4.0-r2
	amd64? ( abi_x86_32? ( app-emulation/emul-linux-x86-baselibs[development] ) )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/os-headers
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	CONFIG_CHECK="~SHMEM"
	linux-info_pkg_setup
}

src_prepare() {
	multilib_copy_sources
}

multilib_src_configure() {
	econf \
		--disable-static \
		--disable-qv4l2 \
		--disable-v4l-utils \
		--with-udevdir="$(get_udevdir)"
}

multilib_src_compile() {
	emake -C lib
}

multilib_src_install() {
	emake -j1 -C lib DESTDIR="${D}" install
}

multilib_src_install_all() {
	dodoc ChangeLog README.lib* TODO
	prune_libtool_files --all
}
