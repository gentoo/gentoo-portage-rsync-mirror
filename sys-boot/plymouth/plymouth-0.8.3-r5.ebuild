# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/plymouth/plymouth-0.8.3-r5.ebuild,v 1.5 2012/05/03 04:50:13 jdhore Exp $

EAPI="3"

inherit autotools-utils

DESCRIPTION="Graphical boot animation (splash) and logger"
HOMEPAGE="http://cgit.freedesktop.org/plymouth/"
SRC_URI="http://cgit.freedesktop.org/${PN}/snapshot/${P}.tar.bz2
	http://dev.gentoo.org/~aidecoe/distfiles/${CATEGORY}/${PN}/gentoo-logo.png
	"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE_VIDEO_CARDS="video_cards_intel video_cards_nouveau video_cards_radeon"
IUSE="${IUSE_VIDEO_CARDS} debug gdm +openrc +pango static-libs"

COMMON_DEPEND=">=media-libs/libpng-1.2.16
	>=x11-libs/gtk+-2.12:2
	pango? ( >=x11-libs/pango-1.21 )
	video_cards_intel? ( x11-libs/libdrm[video_cards_intel] )
	video_cards_nouveau? ( x11-libs/libdrm[video_cards_nouveau] )
	video_cards_radeon? ( x11-libs/libdrm[video_cards_radeon] )
	"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	"
RDEPEND="${COMMON_DEPEND}
	>=sys-kernel/dracut-008-r1[dracut_modules_plymouth]
	openrc? ( sys-boot/plymouth-openrc-plugin !sys-apps/systemd )
	"

DOCS=(AUTHORS ChangeLog NEWS README TODO)

PATCHES=(
	"${FILESDIR}"/${PV}-drm-reduce-minimum-build-requirements.patch
	"${FILESDIR}"/${PV}-image-replace-deprecated-libpng-function.patch
	"${FILESDIR}"/${PV}-gentoo-fb-path.patch
	)

src_prepare() {
	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--localstatedir=/var
		$(use_enable debug tracing)
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
	newins "${DISTDIR}"/gentoo-logo.png bizcom.png || die 'branding failed'
}

pkg_postinst() {
	elog "Follow instructions on"
	elog ""
	elog "  http://dev.gentoo.org/~aidecoe/doc/en/plymouth.xml"
	elog ""
	elog "to set up Plymouth."
}
