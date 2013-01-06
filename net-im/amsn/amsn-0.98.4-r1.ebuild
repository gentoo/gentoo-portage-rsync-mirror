# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/amsn/amsn-0.98.4-r1.ebuild,v 1.10 2011/10/23 16:05:20 armin76 Exp $

EAPI=4
inherit autotools eutils fdo-mime gnome2-utils toolchain-funcs

MY_P=${P/_rc/RC}

DESCRIPTION="aMSN Messenger client"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${MY_P}-src.tar.bz2"
HOMEPAGE="http://www.amsn-project.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc -sparc x86"
IUSE="debug"

DEPEND=">=dev-lang/tcl-8.4
	>=dev-lang/tk-8.4
	virtual/jpeg
	media-libs/libpng
	>=dev-tcltk/snack-2.2.10
	>=net-libs/gupnp-igd-0.1.3
	media-libs/libv4l
	media-libs/imlib"
#	>=net-libs/farsight2-0.0.14
#	>=media-libs/gstreamer-0.10.23
#	>=media-libs/gst-plugins-base-0.10.23

RDEPEND="${DEPEND}
	>=dev-tcltk/tls-1.5
	virtual/ffmpeg[encode]"
#	>=media-libs/gst-plugins-good-0.10.15
#	>=media-libs/gst-plugins-bad-0.10.13
#	>=media-plugins/gst-plugins-ffmpeg-0.10.7

# The tests are interactive
RESTRICT="test"

S=${WORKDIR}/${MY_P}

DOCS=( AGREEMENT TODO README FAQ CREDITS )

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-0.98-noautoupdate.patch \
		"${FILESDIR}"/${PN}-0.98.4-v4l2.patch \
		"${FILESDIR}"/${PN}-0.98.4-amsnplus-ldflags.patch

	# The NetBSD patch kills backwards compability, see http://bugs.gentoo.org/376407
	has_version '>=media-libs/libpng-1.5:0' && epatch "${FILESDIR}"/${PN}-0.98.4-libpng15.patch

	# only portage should strip files, bug 285682
	sed -i -e "s/LDFLAGS += -s/LDFLAGS += /" Makefile.in || die "sed failed"
	# Ships with a 32-bit binary, we want to rebuild it
	rm -f plugins/amsnplus/snapshot || die
	eautoreconf
}

src_configure() {
	tc-export CC
	econf $(use_enable debug)
}

src_install() {
	emake -C plugins/amsnplus
	default

	domenu amsn.desktop
	sed -i -e s:.png:: "${D}"/usr/share/applications/amsn.desktop || die

	pushd desktop-icons
	local res
	for res in 22 32 48 64 72 96 128; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		doins ${res}x${res}/apps/amsn.png
	done
	popd
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
