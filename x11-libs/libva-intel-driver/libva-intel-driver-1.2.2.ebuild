# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libva-intel-driver/libva-intel-driver-1.2.2.ebuild,v 1.1 2013/12/30 10:06:41 aballier Exp $

EAPI="3"

SCM=""
if [ "${PV%9999}" != "${PV}" ] ; then # Live ebuild
	SCM=git-2
	EGIT_BRANCH=master
	EGIT_REPO_URI="git://anongit.freedesktop.org/git/vaapi/intel-driver"
fi

inherit autotools ${SCM} multilib

DESCRIPTION="HW video decode support for Intel integrated graphics"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/vaapi"
if [ "${PV%9999}" != "${PV}" ] ; then # Live ebuild
	SRC_URI=""
	S="${WORKDIR}/${PN}"
else
	SRC_URI="http://www.freedesktop.org/software/vaapi/releases/libva-intel-driver/${P}.tar.bz2"
fi

LICENSE="MIT"
SLOT="0"
if [ "${PV%9999}" = "${PV}" ] ; then
	KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
else
	KEYWORDS=""
fi
IUSE="+drm wayland X"

RDEPEND=">=x11-libs/libva-1.2.0[X?,wayland?,drm?]
	!<x11-libs/libva-1.0.15[video_cards_intel]
	>=x11-libs/libdrm-2.4.45[video_cards_intel]
	wayland? ( media-libs/mesa[egl] >=dev-libs/wayland-1 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-silent-rules \
		$(use_enable drm) \
		$(use_enable wayland) \
		$(use_enable X x11)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README || die
	find "${D}" -name '*.la' -delete
}
