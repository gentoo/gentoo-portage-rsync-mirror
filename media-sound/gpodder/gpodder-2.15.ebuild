# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gpodder/gpodder-2.15.ebuild,v 1.1 2011/05/05 16:50:46 angelos Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="sqlite"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils gnome2-utils

DESCRIPTION="gPodder is a Podcast receiver/catcher written in Python, using GTK."
HOMEPAGE="http://gpodder.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="+dbus bluetooth gstreamer ipod mtp test webkit"

RDEPEND="dev-python/eyeD3
	dev-python/feedparser
	dev-python/imaging
	>=dev-python/mygpoclient-1.4
	>=dev-python/pygtk-2.12
	dbus? ( dev-python/dbus-python )
	bluetooth? ( net-wireless/bluez )
	gstreamer? ( dev-python/gst-python )
	ipod? ( media-libs/libgpod[python] )
	mtp? ( >=media-libs/libmtp-1.0.0 )
	webkit? ( dev-python/pywebkitgtk )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-apps/help2man
	test? ( dev-python/minimock
		dev-python/coverage )"

src_prepare() {
	sed -i \
		-e 's:make -C:$(MAKE) -C:' \
		Makefile || die

	distutils_src_prepare
}

src_compile() {
	emake data/org.gpodder.service || die
	emake messages || die

	distutils_src_compile
}

src_test() {
	emake unittest || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	distutils_pkg_postinst
}

pkg_postrm() {
	gnome2_icon_cache_update
	distutils_pkg_postrm
}
