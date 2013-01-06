# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/plymouth/plymouth-0.8.4.ebuild,v 1.6 2013/01/01 14:55:27 ago Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Graphical boot animation (splash) and logger"
HOMEPAGE="http://cgit.freedesktop.org/plymouth/"
SRC_URI="
	http://www.freedesktop.org/software/plymouth/releases/${P}.tar.bz2
	http://dev.gentoo.org/~aidecoe/distfiles/${CATEGORY}/${PN}/gentoo-logo.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE_VIDEO_CARDS="video_cards_intel video_cards_nouveau video_cards_radeon"
IUSE="${IUSE_VIDEO_CARDS} debug gdm +libkms +openrc +pango static-libs"

CDEPEND=">=media-libs/libpng-1.2.16
	>=x11-libs/gtk+-2.12:2
	libkms? ( x11-libs/libdrm[libkms] )
	pango? ( >=x11-libs/pango-1.21 )
	video_cards_intel? ( x11-libs/libdrm[video_cards_intel] )
	video_cards_nouveau? ( x11-libs/libdrm[video_cards_nouveau] )
	video_cards_radeon? ( x11-libs/libdrm[video_cards_radeon] )
	"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	"
RDEPEND="${CDEPEND}
	>=sys-kernel/dracut-008-r1[dracut_modules_plymouth]
	openrc? ( sys-boot/plymouth-openrc-plugin !sys-apps/systemd )
	"

DOCS=(AUTHORS README TODO)

src_prepare() {
	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--with-system-root-install
		--localstatedir=/var
		$(use_enable debug tracing)
		$(use_enable libkms)
		$(use_enable pango)
		$(use_enable gdm gdm-transition)
		$(use_enable video_cards_intel libdrm_intel)
		$(use_enable video_cards_nouveau libdrm_nouveau)
		$(use_enable video_cards_radeon libdrm_radeon)
		)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	if use static-libs; then
		mv "${D}/$(get_libdir)"/libply{,-splash-core}.a \
			"${D}/usr/$(get_libdir)"/ || die 'mv *.a files failed'
		gen_usr_ldscript libply.so libply-splash-core.so
	else
		local la
		for la in "${D}/usr/$(get_libdir)"/plymouth/{*.la,renderers/*.la}; do
			einfo "Removing left ${la#${D}}"
			rm "${la}" || die "rm '${la}'"
		done
	fi

	insinto /usr/share/plymouth
	newins "${DISTDIR}"/gentoo-logo.png bizcom.png
}

pkg_postinst() {
	elog "Follow instructions on"
	elog ""
	elog "  http://dev.gentoo.org/~aidecoe/doc/en/plymouth.xml"
	elog ""
	elog "to set up Plymouth."
}
