# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdemu/cdemu-2.0.0.ebuild,v 1.3 2013/06/25 16:56:14 ago Exp $

EAPI="5"

CMAKE_MIN_VERSION="2.8.5"
PYTHON_COMPAT=( python2_6 python2_7 )
PLOCALES="de fr no pl sl sv"

inherit cmake-utils eutils fdo-mime l10n python-single-r1

DESCRIPTION="Command-line tool for controlling cdemu-daemon"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/cdemu-client-${PV}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~hppa x86"
IUSE="+cdemu-daemon"

RDEPEND="${PYTHON_DEPS}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	cdemu-daemon? ( app-cdr/cdemu-daemon:0/4 )"
DEPEND="${RDEPEND}
	dev-util/desktop-file-utils
	>=dev-util/intltool-0.21
	>=sys-devel/gettext-0.18"

S=${WORKDIR}/cdemu-client-${PV}

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	python_fix_shebang src/cdemu
	epatch "${FILESDIR}/${PN}-2.0.0-bash-completion-dir.patch"
	# build system doesn't respect LINGUAS :/
	rm_po() {
		rm po/$1.po || die
	}
	l10n_for_each_disabled_locale_do rm_po
}

src_configure() {
	DOCS="AUTHORS README"
	local mycmakeargs=( -DPOST_INSTALL_HOOKS=OFF )
	cmake-utils_src_configure
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
