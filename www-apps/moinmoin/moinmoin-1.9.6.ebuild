# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/moinmoin/moinmoin-1.9.6.ebuild,v 1.4 2013/01/04 12:54:20 ago Exp $

EAPI="5"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="xml"
PYTHON_MODNAME="MoinMoin"

inherit distutils webapp

MY_PN="moin"

DESCRIPTION="Python WikiClone"
HOMEPAGE="http://moinmo.in/"
SRC_URI="http://static.moinmo.in/files/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc x86"
IUSE=""

RDEPEND=">=dev-python/docutils-0.4
	>=dev-python/flup-1.0.2
	>=dev-python/pygments-1.1.1
	>=dev-python/werkzeug-0.7.0"

need_httpd_cgi

S=${WORKDIR}/${MY_PN}-${PV}

WEBAPP_MANUAL_SLOT="yes"

pkg_setup() {
	if has_version "<www-apps/moinmoin-1.9" ; then
		ewarn
		ewarn "You already have a version of moinmoin prior to 1.9 installed."
		ewarn "moinmoin-1.9 has a very different configuration than 1.8 (among"
		ewarn "other changes, static content is no longer installed under the"
		ewarn "htdocs directory)."
		ewarn
		ewarn "Please read http://moinmo.in/MoinMoinRelease1.9 and"
		ewarn "README.migration in /usr/share/doc/${PF}"
		ewarn
	fi

	python_set_active_version 2
	python_pkg_setup
	webapp_pkg_setup
}

src_prepare() {
	# remove bundled -- parsedatetime and xappy not packaged yet
	rm -r MoinMoin/support/{pygments,werkzeug,flup} || die
	sed -i "/\(flup\|pygments\|werkzeug\)/d" setup.py || die
}

src_install() {
	webapp_src_preinst
	distutils_src_install

	dodoc README docs/CHANGES* docs/README.migration
	dohtml docs/INSTALL.html
	rm -rf README docs/

	cd "${D}"/usr/share/moin

	insinto "${MY_HTDOCSDIR}"
	doins -r server/moin.cgi
	fperms +x "${MY_HTDOCSDIR}/moin.cgi"

	insinto "${MY_HOSTROOTDIR}"/${PF}
	doins -r data underlay config/wikiconfig.py

	insinto "${MY_HOSTROOTDIR}"/${PF}/altconfigs
	doins -r config

	insinto "${MY_HOSTROOTDIR}"/${PF}/altserver
	doins -r server

	# data needs to be server owned per moin devs
	cd "${D}/${MY_HOSTROOTDIR}"/${PF}
	for file in $(find data underlay); do
		webapp_serverowned "${MY_HOSTROOTDIR}/${PF}/${file}"
	done

	webapp_configfile "${MY_HOSTROOTDIR}"/${PF}/wikiconfig.py
	webapp_hook_script "${FILESDIR}"/reconfig-1.9.4
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en-1.9.4.txt

	webapp_src_install
}

pkg_postinst() {
	ewarn
	ewarn "If you are upgrading from an older version, please read"
	ewarn "README.migration in /usr/share/doc/${PF}"
	ewarn

	distutils_pkg_postinst
	webapp_pkg_postinst
}
