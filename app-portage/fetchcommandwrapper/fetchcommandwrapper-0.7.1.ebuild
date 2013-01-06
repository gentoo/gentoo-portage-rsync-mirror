# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/fetchcommandwrapper/fetchcommandwrapper-0.7.1.ebuild,v 1.1 2010/10/27 20:42:52 sping Exp $

EAPI="2"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Wrapper integrating aria2 into portage's FETCHCOMMAND"
HOMEPAGE="http://git.goodpoint.de/?p=fetchcommandwrapper.git;a=summary"
SRC_URI="http://www.hartwork.org/public/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=net-misc/aria2-1.10.2"

pkg_postinst() {
	distutils_pkg_postinst

	ewarn 'You need to append'
	ewarn '   source /usr/share/fetchcommandwrapper/make.conf'
	ewarn 'to /etc/make.conf in order to integrate fetchcommandwrapper.'
}
