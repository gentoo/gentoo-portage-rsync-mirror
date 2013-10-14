# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/abi-compliance-checker/abi-compliance-checker-9999.ebuild,v 1.2 2013/10/14 21:05:29 mgorny Exp $

EAPI=5

#if LIVE
EGIT_REPO_URI="git://github.com/lvc/${PN}.git
	http://github.com/lvc/${PN}.git"

inherit git-r3
#endif

DESCRIPTION="A tool for checking backward compatibility of a C/C++ library"
HOMEPAGE="http://ispras.linuxbase.org/index.php/ABI_compliance_checker"
SRC_URI="mirror://github/lvc/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#if LIVE
SRC_URI=
KEYWORDS=
#endif

src_install() {
	mkdir -p "${D}"/usr || die
	perl Makefile.pl --install --prefix=/usr --destdir="${D}" || die
}
