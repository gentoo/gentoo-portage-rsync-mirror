# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hotot/hotot-0.9.8.11.ebuild,v 1.1 2012/12/16 23:40:38 xmw Exp $

EAPI=4

PYTHON_DEPEND="gtk? 2"
RESTRICT_PYTHON_ABIS="3.*"

inherit cmake-utils python vcs-snapshot

DESCRIPTION="lightweight & open source microblogging client"
HOMEPAGE="http://hotot.org"
SRC_URI="https://github.com/shellex/Hotot/tarball/f32d0fb4 -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="chrome gtk kde qt4"

RDEPEND="dev-python/dbus-python
	gtk? ( dev-python/pywebkitgtk )
	qt4? ( x11-libs/qt-webkit:4
		kde? ( kde-base/kdelibs ) )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	qt4? ( x11-libs/qt-sql:4 )"

REQUIRED_USE="|| ( chrome gtk qt4 )"

pkg_setup() {
	if ! use gtk ; then
		if ! use qt4 ; then
			ewarn "neither gtk not qt4 binaries will be build"
		fi
	fi
	python_pkg_setup
}

src_configure() {
	mycmakeargs="${mycmakeargs} \
		$(cmake-utils_use_with chrome CHROME) \
		$(cmake-utils_use_with gtk GTK) \
		$(cmake-utils_use_with kde KDE) \
		$(cmake-utils_use_with qt4 QT) \
		-DPYTHON_EXECUTABLE=$(PYTHON -2 -a)"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	find "${D}" -name "*.pyc" -delete
}

pkg_postinst() {
	if use chrome; then
		elog "TO install hotot for chrome, open chromium/google-chrome,"
		elog "vist chrome://chrome/extensions/ and load /usr/share/hotot"
		elog "as unpacked extension."
	fi
}
