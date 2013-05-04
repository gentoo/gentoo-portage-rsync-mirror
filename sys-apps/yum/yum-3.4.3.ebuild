# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/yum/yum-3.4.3.ebuild,v 1.4 2013/05/04 19:06:33 floppym Exp $

EAPI="4"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite"

inherit eutils python

DESCRIPTION="automatic updater and package installer/remover for rpm systems"
HOMEPAGE="http://yum.baseurl.org/"
SRC_URI="http://yum.baseurl.org//download/${PV:0:3}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"

DEPEND="dev-util/intltool
	test? ( dev-python/nose )"

RDEPEND="app-arch/rpm[python]
	dev-python/sqlitecachec
	dev-libs/libxml2[python]
	dev-python/urlgrabber"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -i -e "s:lib:$(get_libdir):g" rpmUtils/Makefile yum/Makefile || die
}

src_install() {
	emake install DESTDIR="${D}"
	rm -r "${ED}etc/rc.d"
	find "${ED}" -name '*.py[co]' -print0 | xargs -0 rm -f
	python_convert_shebangs -r -x "${PYTHON_ABI}" "${ED}"
}

pkg_postinst() {
	python_mod_optimize yum rpmUtils /usr/share/yum-cli
}

pkg_postrm() {
	python_mod_cleanup yum rpmUtils /usr/share/yum-cli
}
