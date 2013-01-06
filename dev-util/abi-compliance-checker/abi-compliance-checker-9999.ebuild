# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/abi-compliance-checker/abi-compliance-checker-9999.ebuild,v 1.1 2012/12/15 12:47:24 mgorny Exp $

EAPI=4

#if LIVE
EGIT_REPO_URI="git://github.com/lvc/${PN}.git
	http://github.com/lvc/${PN}.git"

inherit git-2
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
