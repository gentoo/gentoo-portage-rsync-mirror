# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/nx_util/nx_util-0.3.ebuild,v 1.2 2013/05/14 21:57:32 dev-zero Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite"
DISTUTILS_SINGLE_IMPL=true

inherit distutils-r1

DESCRIPTION="Whitelist & Reports generation for Naxsi (Web Application Firewall module for Nginx)."
HOMEPAGE="https://code.google.com/p/naxsi/"
SRC_URI="https://naxsi.googlecode.com/files/${P}.tgz"

LICENSE="GPL-2+ Apache-2.0 CC-BY-NC-SA-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="www-servers/nginx[nginx_modules_http_naxsi]"

PATCHES=( "${FILESDIR}/${PV}-fix-install-paths.patch" )

src_prepare() {
	distutils-r1_src_prepare
	mv nx_util{.py,} || die "renaming script failed"
}
