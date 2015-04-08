# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/intel-gpu-tools/intel-gpu-tools-1.7.ebuild,v 1.7 2015/02/19 08:51:42 ago Exp $

EAPI=5

PYTHON_COMPAT=( python{3_3,3_4} )

inherit python-single-r1 xorg-2

DESCRIPTION="Intel GPU userland tools"
KEYWORDS="amd64 x86"
IUSE="python video_cards_nouveau"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="test"

DEPEND="dev-libs/glib:2
	>=x11-libs/cairo-1.12.0
	>=x11-libs/libdrm-2.4.52[video_cards_intel,video_cards_nouveau?]
	>=x11-libs/libpciaccess-0.10
	python? ( ${PYTHON_DEPS} )"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-shader-debugger-Force-file-stdout-IO-as-UTF-8.patch" )

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable python dumper)
		$(use_enable video_cards_nouveau nouveau)
		--disable-tests #484618
	)
	xorg-2_src_configure
}
