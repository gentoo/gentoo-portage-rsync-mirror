# Copyright 2010-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/weboob/weboob-9999.ebuild,v 1.1 2013/01/25 08:31:16 patrick Exp $

EAPI=5
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit base distutils
if [ "$PV" == "9999" ]; then
	EGIT_REPO_URI="git://git.symlink.me/pub/romain/${PN}.git"
	inherit git-2
	KEYWORDS=""
	SRC_URI=""
elif [ "$PV" == "9998" ]; then
	EGIT_REPO_URI="git://git.symlink.me/pub/romain/${PN}-stable.git"
	inherit git-2
	KEYWORDS=""
	SRC_URI=""
else
	KEYWORDS="~x86 ~amd64"
	SRC_URI="http://symlink.me/attachments/download/199/${PN}-0.d.tar.gz"
	S="${WORKDIR}/${PN}-0.d"
fi

DESCRIPTION="Weboob (Web Out of Browsers) provides several applications to interact with a lot of websites."
HOMEPAGE="http://weboob.org/"

LICENSE="AGPL-3"
SLOT="0"
IUSE="X +secure-updates fast-libs"

DEPEND="X? ( >=dev-python/PyQt4-4.9.4-r1[X] dev-python/pyxdg )"
RDEPEND="${DEPEND}
	dev-python/prettytable
	dev-python/html2text
	dev-python/mechanize
	dev-python/python-dateutil
	dev-python/pyyaml
	dev-python/imaging
	dev-python/gdata
	dev-python/feedparser
	secure-updates? ( app-crypt/gnupg )
	fast-libs? ( dev-python/simplejson dev-python/pyyaml[libyaml] )
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 dev-python/simplejson )
	|| ( ( <dev-python/lxml-3.0 ) ( >=dev-python/lxml-3.0 dev-python/cssselect ) )"

DOCS="AUTHORS COPYING ChangeLog README INSTALL"

set_global_options() {
	DISTUTILS_GLOBAL_OPTIONS=("* --$(usex X '' 'no-')qt" "* --$(usex X '' 'no-')xdg")
}

distutils_src_install_pre_hook() {
	set_global_options
}

distutils_src_install_post_hook() {
	exeinto "/usr/share/${PN}"
	doexe contrib/*-munin
}

distutils_src_compile_pre_hook() {
	set_global_options
}

pkg_postinst() {
	elog "You should now run \"weboob-config update\" (as your login user)."
}
