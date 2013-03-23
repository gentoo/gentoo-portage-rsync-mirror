# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/emesene/emesene-9999.ebuild,v 1.11 2013/03/23 10:48:57 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
EGIT_REPO_URI="git://github.com/${PN}/${PN}.git
	http://github.com/${PN}/${PN}.git"

inherit distutils eutils git-2

DESCRIPTION="Platform independent IM client written in Python+GTK"
HOMEPAGE="http://www.emesene.org"

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 )"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/pygtk:2
	dev-python/notify-python
	dev-python/pywebkitgtk
	dev-python/pyopenssl
	dev-python/xmpppy"

src_prepare() {
	# do not import dummy session
	sed -i -e  "/import e3dummy/d" ${PN}/${PN}.py || die
	# Use a better meny entry
	sed -i -e "/^Name/s:${PN}:Emesene:" \
		${PN}/data/share/applications/${PN}.desktop || die
	python_convert_shebangs -r 2 .
	distutils_src_prepare
}

src_install() {
	mysymlink(){
		dosym  $(python_get_sitedir)/${PN}/${PN} /usr/bin/${PN} || die
	}
	distutils_src_install
	python_execute_function -q mysymlink
}

pkg_postinst() {
	elog
	elog "${PN} is on early stages of development."
	elog "Please do not file bugs on Gentoo bugzilla"
	elog "unless you have problems with this ebuild."
	elog "Use the upstram bug tracker to report bugs:"
	elog
	elog "https://github.com/emesene/emesene/issues"
}
